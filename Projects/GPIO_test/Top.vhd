----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
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
			LED : out  STD_LOGIC_VECTOR (7 downto 0);
			DPSwitch: in STD_LOGIC_VECTOR(7 downto 0);
			Switch : in STD_LOGIC_VECTOR(5 downto 0)
		);
end Top;



architecture Behavioral of Top is
component LED_control is
	port( 
			RST : in STD_LOGIC;
			CLK : in STD_LOGIC;
			LED_INPUT : in  STD_LOGIC_VECTOR (31 downto 0);
			GPIO_LED : out  STD_LOGIC_VECTOR (7 downto 0)
		);
end component;


signal temp_1, temp_2,rst : STD_LOGIC := '1';
signal led_input : STD_LOGIC_VECTOR(31 downto 0) := X"0257ACEF";
signal counter, counter_next : unsigned(51 downto 0) := (others=>'0');
begin
rst <= not Switch(0);
process (CLK_100MHz,rst)
begin
	if (rst = '1') then
		counter <= (others=>'0');
	elsif rising_edge(CLK_100MHz) then
			temp_1 <= not temp_1;
			counter <= counter_next;
	end if;
end process;
counter_next<=counter+1;
process (CLK_12MHz)
begin
	if rising_edge(CLK_12MHz) then
			temp_2 <= not temp_2;
	end if;
end process;
led_input <= STD_LOGIC_VECTOR(counter(49 downto 18));
led_control_i : LED_control
	port map(
			RST => rst,
			CLK =>CLK_100MHz,
			LED_INPUT =>led_input,
			GPIO_LED =>LED
	);

end Behavioral;

