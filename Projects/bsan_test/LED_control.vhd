----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:58:17 07/20/2016 
-- Design Name: 
-- Module Name:    LED_control - Behavioral 
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

entity LED_control is
    Port ( 
			RST : in STD_LOGIC;
			CLK : in STD_LOGIC;
			LED_INPUT : in  STD_LOGIC_VECTOR (31 downto 0);
			LED_en : in STD_LOGIC_VECTOR (7 downto 0);
			GPIO_LED : out  STD_LOGIC_VECTOR (7 downto 0));
end LED_control;

architecture Behavioral of LED_control is
	signal led_counter, led_counter_next : unsigned(3 downto 0) := "0000";
	signal led_reg, led_reg_next : STD_LOGIC_VECTOR(7 downto 0) := (others=>'0');
	signal led_0, led_1, led_2, led_3, led_4, led_5, led_6, led_7 : unsigned(3 downto 0);
begin
GPIO_LED <= led_reg;

process(RST,CLK)
begin
	if(RST = '1') then
		led_reg <= (others=>'0');
		led_counter <= (others=>'0');
	elsif rising_edge(clk) then
		led_counter <= led_counter_next;
		led_reg <=led_reg_next;
	end if;
end process;


led_counter_next <= (others=>'0') when led_counter = 14 else led_counter+1 ;
led_0 <= unsigned(LED_INPUT(3 downto 0));
led_1 <= unsigned(LED_INPUT(7 downto 4));
led_2 <= unsigned(LED_INPUT(11 downto 8));
led_3 <= unsigned(LED_INPUT(15 downto 12));
led_4 <= unsigned(LED_INPUT(19 downto 16));
led_5 <= unsigned(LED_INPUT(23 downto 20));
led_6 <= unsigned(LED_INPUT(27 downto 24));
led_7 <= unsigned(LED_INPUT(31 downto 28));



process (led_counter,led_reg,LED_en,
		led_0, led_1, led_2, led_3, led_4, led_5, led_6, led_7)
begin
	led_reg_next <= led_reg;
	if(led_counter = 0) then
		led_reg_next <= LED_en;
	end if;
	if(led_counter = led_0) then
		led_reg_next(0) <= '0';
	end if;
	if(led_counter = led_1) then
		led_reg_next(1) <= '0';
	end if;
	if(led_counter = led_2) then
		led_reg_next(2) <= '0';
	end if;
	if(led_counter = led_3) then
		led_reg_next(3) <= '0';
	end if;
	if(led_counter = led_4) then
		led_reg_next(4) <= '0';
	end if;
	if(led_counter = led_5) then
		led_reg_next(5) <= '0';
	end if;
	if(led_counter = led_6) then
		led_reg_next(6) <= '0';
	end if;
	if(led_counter = led_7) then
		led_reg_next(7) <= '0';
	end if;
	
end process;	


end Behavioral;

