----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:44:02 08/09/2016 
-- Design Name: 
-- Module Name:    Reciever_Core - Behavioral 
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

entity Reciever_Core is
    Port ( RST : in STD_LOGIC;
			  CLK : in STD_LOGIC;
			  BIT_EN : in STD_LOGIC;
			  Data_RX : out  STD_LOGIC_VECTOR (7 downto 0);
           Rec : out  STD_LOGIC;
           RX : in  STD_LOGIC);
end Reciever_Core;

architecture Behavioral of Reciever_Core is

begin


end Behavioral;

