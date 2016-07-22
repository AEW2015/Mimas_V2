----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:12:34 07/22/2016 
-- Design Name: 
-- Module Name:    DPSwitch_core - Behavioral 
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

entity DPSwitch_core is
    Port ( GPIO_DPSwitch : in  STD_LOGIC_VECTOR (7 downto 0);
           DPSwitch_out : out  STD_LOGIC_VECTOR (7 downto 0));
end DPSwitch_core;

architecture Behavioral of DPSwitch_core is

begin

DPSwitch_out <= not GPIO_DPSwitch;


end Behavioral;

