----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:52:14 07/21/2016 
-- Design Name: 
-- Module Name:    button_debounce - Behavioral 
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

entity button_debounce is
    Port ( Rst : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Button_in : in  STD_LOGIC;
           Button_out : out  STD_LOGIC);
end button_debounce;

architecture Behavioral of button_debounce is
	constant counter_Size : integer := 19;
	signal counter_out, counter_out_next : unsigned(counter_size DOWNTO 0) := (OTHERS => '0');
	signal flip_flops : STD_LOGIC_VECTOR(2 downto 0) := (others=>'0');
	signal counter_set : STD_LOGIC;
begin
	Button_out <= flip_flops(2);
	counter_set <= flip_flops(0) xor flip_flops(1);
	counter_out_next <= (others=>'0') when counter_set  = '1' else
									counter_out + 1 when counter_out(counter_Size) = '0' else
									counter_out;
	
	
	process(rst,clk)
	begin
		if (Rst = '1') then
			flip_flops <= (others=>'0');
			counter_out <= (others => '0');
		elsif rising_edge(clk) then
			counter_out <= counter_out_next;
			flip_flops(0) <= Button_in;
			flip_flops(1) <= flip_flops(0);
			if(counter_out(counter_Size) = '1') then
				flip_flops(2) <= flip_flops(1);
			end if;
		end if;
	end process;


end Behavioral;

