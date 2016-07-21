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
	constant counter_Size : integer := 20;
	signal counter_out, counter_out_next : STD_LOGIC_VECTOR(counter_size DOWNTO 0) := (OTHERS => '0');
	signal flip_flops, flip_flops_ne : STD_LOGIC_VECTOR(2 downto 0) := (others=>'0');
	signal counter_set : STD_LOGIC;
	
begin


end Behavioral;

