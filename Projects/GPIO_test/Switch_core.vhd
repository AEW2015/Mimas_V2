----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:07:42 07/20/2016 
-- Design Name: 
-- Module Name:    Switch_core - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Switch_core is
    Port ( 
			RST : in STD_LOGIC;
			CLK : in STD_LOGIC;
			GPIO_Switch : in  STD_LOGIC_VECTOR (5 downto 0);
           Switch_Out : out  STD_LOGIC_VECTOR (5 downto 0));
end Switch_core;

architecture Behavioral of Switch_core is
component button_debounce is
    Port ( Rst : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Button_in : in  STD_LOGIC;
           Button_out : out  STD_LOGIC);
end component;
signal inverted_switch : STD_LOGIC_VECTOR(5 downto 0);
	
begin
inverted_switch <= not GPIO_Switch;

-- need to figure out how to debounce the best way...
Switch_0 : button_debounce
	port map(
			RST => rst,
			CLK =>CLk,
			Button_in =>inverted_switch(0),
			Button_out => Switch_Out(0)
	);
Switch_1 : button_debounce
	port map(
			RST => rst,
			CLK =>CLk,
			Button_in =>inverted_switch(1),
			Button_out => Switch_Out(1)
	);
Switch_2 : button_debounce
	port map(
			RST => rst,
			CLK =>CLk,
			Button_in =>inverted_switch(2),
			Button_out => Switch_Out(2)
	);
Switch_3 : button_debounce
	port map(
			RST => rst,
			CLK =>CLk,
			Button_in =>inverted_switch(3),
			Button_out => Switch_Out(3)
	);
Switch_4 : button_debounce
	port map(
			RST => rst,
			CLK =>CLk,
			Button_in =>inverted_switch(4),
			Button_out => Switch_Out(4)
	);
Switch_5 : button_debounce
	port map(
			RST => rst,
			CLK =>CLk,
			Button_in =>inverted_switch(5),
			Button_out => Switch_Out(5)
	);




end Behavioral;

