----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:25:59 07/26/2016 
-- Design Name: 
-- Module Name:    seven_segment_core - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seven_segment_core is
    Port ( 
			RST : in STD_LOGIC;
			CLK : in STD_LOGIC;
			Data_in : in  STD_LOGIC_VECTOR (15 downto 0);
           Dp_in : in  STD_LOGIC_VECTOR (2 downto 0);
           Seven_out : out  STD_LOGIC_VECTOR (6 downto 0);
		   Dp_out: out STD_LOGIC;
           Enable_out : out  STD_LOGIC_VECTOR (2 downto 0));
end seven_segment_core;

architecture Behavioral of seven_segment_core is
signal clk_counter,clk_counter_next : unsigned(31 downto 0):=(others=>'0');
signal display_counter,display_counter_next : unsigned(5 downto 0):= (others=>'0');
signal display_data : STD_LOGIC_VECTOR(3 downto 0);
signal seven_display : STD_LOGIC_VECTOR(6 downto 0);
signal Enable_tmp,Enable_reg, Enable_next :STD_LOGIC_VECTOR(2 downto 0):= (others=>'0');
begin
--TODO:	Negate both output signal and redo logic
--				Change timing so zero is off and 16 is full.

Dp_out <=Dp_in(0) when display_counter(5 downto 4) ="00" else
				Dp_in(1) when display_counter(5 downto 4) ="01" else
				Dp_in(2);

Seven_out <= seven_display;
Enable_out <= Enable_reg;
process (clk,rst)
begin
	if(rst = '1') then
		clk_counter <= (others=>'0');
		display_counter <= (others=>'0');
		Enable_reg <= (others=>'0');
	elsif rising_edge(clk) then
		clk_counter <= clk_counter_next;
		display_counter <= display_counter_next;
		Enable_reg <= Enable_next;
	end if;
end process;

clk_counter_next <= (others=>'0') when clk_counter = 1000 else
								clk_counter + 1;
								
display_counter_next <= (others=>'0') when clk_counter = 1000 and display_counter = "101111" else
										display_counter + 1 when clk_counter = 1000 else
										display_counter;
										
Enable_tmp <= "110" when display_counter(5 downto 4) ="00" else
						"101" when display_counter(5 downto 4) ="01" else
						"011";

display_data <= Data_in(3 downto 0) when display_counter(5 downto 4) ="00" else
						 Data_in(7 downto 4) when display_counter(5 downto 4) ="01" else
						 Data_in(11 downto 8);

with display_data select seven_display <=
    "1000000" when "0000",
	"1111001" when "0001",
    "0100100" when "0010",
    "0110000" when "0011",
	"0011001" when "0100",
    "0010010" when "0101" ,
    "0000010" when "0110",
	"1111000" when "0111",
    "0000000" when "1000",
    "0011000" when "1001",
	"0001000" when "1010",
    "0000011" when "1011",
    "1000110" when "1100",
	"0100001" when "1101",
    "0000110" when "1110" ,
    "0001110" when others;
	

process (display_counter,Enable_reg,Enable_tmp,Data_in)
begin
	Enable_next <= Enable_reg;
	if(display_counter(3 downto 0) = 0) then
		Enable_next <= Enable_tmp;
	end if;
	if(display_counter(3 downto 0) = unsigned(Data_in(15 downto 12) ))then
		Enable_next <= (others=>'1');
	end if;
end process;	



end Behavioral;

