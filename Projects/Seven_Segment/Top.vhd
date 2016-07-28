----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Andrew Wilson
-- 
-- Create Date:    07:50:38 07/20/2016 
-- Design Name: 
-- Module Name:    Top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top is
    Port ( 
			CLK_100MHz : in STD_LOGIC;
			CLK_12MHz : in STD_LOGIC;
			GPIO_LED : out  STD_LOGIC_VECTOR (7 downto 0);
			GPIO_DPSwitch: in STD_LOGIC_VECTOR(7 downto 0);
			GPIO_Switch : in STD_LOGIC_VECTOR(5 downto 0);
			SevenSegment: out STD_LOGIC_VECTOR(7 downto 0);
			SevenSegmentEnable : out STD_LOGIC_VECTOR(2 downto 0)
		);
end Top;



architecture Behavioral of Top is
component LED_control is
	port( 
			RST : in STD_LOGIC;
			CLK : in STD_LOGIC;
			LED_INPUT : in  STD_LOGIC_VECTOR (31 downto 0);
			LED_en : in STD_LOGIC_VECTOR (7 downto 0);
			GPIO_LED : out  STD_LOGIC_VECTOR (7 downto 0)
		);
end component;
component Switch_core is
    Port ( 
			RST : in STD_LOGIC;
			CLK : in STD_LOGIC;
			GPIO_Switch : in  STD_LOGIC_VECTOR (5 downto 0);
           Switch_Out : out  STD_LOGIC_VECTOR (5 downto 0));
end component;
component DPSwitch_core is
    Port ( GPIO_DPSwitch : in  STD_LOGIC_VECTOR (7 downto 0);
           DPSwitch_out : out  STD_LOGIC_VECTOR (7 downto 0)
		   );
end component;
component seven_segment_core is
    Port ( 
			RST : in STD_LOGIC;
			CLK : in STD_LOGIC;
			Data_in : in  STD_LOGIC_VECTOR (15 downto 0);
           Dp_in : in  STD_LOGIC_VECTOR (2 downto 0);
           Seven_out : out  STD_LOGIC_VECTOR (6 downto 0);
		   Dp_out: out STD_LOGIC;
           Enable_out : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

signal rst : STD_LOGIC;

signal DPSwitch, tmp : STD_LOGIC_VECTOR (7 downto 0);
signal led_input : STD_LOGIC_VECTOR(31 downto 0) := X"0257ACEF";
signal counter, counter_next : unsigned(51 downto 0) := (others=>'0');
signal Switch : STD_LOGIC_VECTOR(5 downto 0);
begin
rst <= not GPIO_Switch(0);


process (CLK_100MHz,rst)
begin 
	if (rst = '1') then
		counter <= (others=>'0');
	elsif rising_edge(CLK_100MHz) then
			counter <= counter_next;
	end if;
end process;

counter_next<=counter+1;



--make seven segment display core







led_input <= x"FFFFFFFF";



seven_core_i : seven_segment_core
    Port map( 
			RST => RST,
			CLK => CLK_100MHz,
			Data_in =>DPSwitch & DPSwitch,
           Dp_in  => "101",
           Seven_out => SevenSegment(6 downto 0),
		   Dp_out => SevenSegment(7),
           Enable_out => SevenSegmentEnable
	);

led_control_i : LED_control
	port map(
			RST => rst,
			CLK =>CLK_100MHz,
			LED_INPUT =>led_input,
			LED_en => DPSwitch,
			GPIO_LED =>GPIO_LED
	);
switch_core_i : Switch_core
	port map(
			RST => rst,
			CLK => CLK_100MHz,
			GPIO_Switch => GPIO_Switch,
			Switch_Out => Switch
	);
DPSwitch_core_i : DPSwitch_core
	port map(
			GPIO_DPSwitch => GPIO_DPSwitch,
			DPSwitch_out => DPSwitch
	);
end Behavioral;

