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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seven_segment_core is
    Port ( 
			CLK : in STD_LOGIC;
			Data_in : in  STD_LOGIC_VECTOR (31 downto 0);
           Dp_in : in  STD_LOGIC_VECTOR (2 downto 0);
           Seven_out : out  STD_LOGIC_VECTOR (6 downto 0);
		   Dp_out: out STD_LOGIC;
           Enable_out : out  STD_LOGIC_VECTOR (2 downto 0));
end seven_segment_core;

architecture Behavioral of seven_segment_core is

begin

Dp_out <= '1';
Enable_out <= "010";
Seven_out <= "0001111";

end Behavioral;

