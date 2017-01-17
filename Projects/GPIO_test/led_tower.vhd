----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:15:32 11/15/2016 
-- Design Name: 
-- Module Name:    led_tower - Behavioral 
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

entity led_tower is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           DATA_IN : in  STD_LOGIC_VECTOR (63 downto 0);
           ARRAY_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
           LEVEL_OUT : out  STD_LOGIC_VECTOR (3 downto 0));
end led_tower;

architecture Behavioral of led_tower is
signal led_counter : STD_LOGIC_VECTOR(3 downto 0) := "0001";
begin
process(RST,CLK)
begin
	if(RST = '1') then
		led_counter<="0001";
	elsif rising_edge(clk) then
		led_counter<=led_counter(2 downto 0) & led_counter(3);
	end if;
end process;

LEVEL_OUT <= led_counter;
ARRAY_OUT <= DATA_IN(15 downto 0) when led_counter(0) = '1' else
				 DATA_IN(31 downto 16) when led_counter(1) = '1' else
			    DATA_IN(47 downto 32) when led_counter(2) = '1' else
				 DATA_IN(63 downto 48);


end Behavioral;

