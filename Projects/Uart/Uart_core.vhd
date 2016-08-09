----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:39:37 08/09/2016 
-- Design Name: 
-- Module Name:    Uart_core - Behavioral 
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

entity Uart_core is
	 Generic (
				CLK_RATE: natural :=100_000_000;
				BAUD_RATE: natural :=19_200);
    Port ( 
			  RST : in STD_LOGIC;
			  CLK : in STD_LOGIC;
			  Data_TX : in  STD_LOGIC_VECTOR (7 downto 0);
           Data_RX : out  STD_LOGIC_VECTOR (7 downto 0);
           Send : in  STD_LOGIC;
			  RX : in  STD_LOGIC;
			  TX_busy : out  STD_LOGIC;
			  RX_busy : out  STD_LOGIC;
			  TX : out  STD_LOGIC;
           Rec : out  STD_LOGIC);
end Uart_core;

architecture Behavioral of Uart_core is
component Transmitter_Core is
	Generic (
				CLK_RATE: natural :=100_000_000;
				BAUD_RATE: natural :=19_200);
	port( 
			RST : in STD_LOGIC;
			CLK : in STD_LOGIC;
			Data_TX : in  STD_LOGIC_VECTOR (7 downto 0);
         Send : in  STD_LOGIC;
			TX_busy : out  STD_LOGIC;
         TX : out  STD_LOGIC
			);
end component;
component Reciever_Core is
	Generic (
				CLK_RATE: natural :=100_000_000;
				BAUD_RATE: natural :=19_200);
	port( 
			RST : in STD_LOGIC;
			CLK : in STD_LOGIC;
			Data_RX : out  STD_LOGIC_VECTOR (7 downto 0);
         Rec : out  STD_LOGIC;
			RX_busy : out  STD_LOGIC;
         RX : in  STD_LOGIC
			);
end component;



begin

Transmitter_Core_i : Transmitter_Core
	Generic Map(
		CLK_RATE => CLK_RATE,
		BAUD_RATE => BAUD_RATE
	)
    Port map( 
			RST => RST,
			CLK =>CLk,
			Data_TX => Data_TX,
			Send => Send,
			TX_busy => TX_busy,
			TX  => TX
	);
Reciever_Core_i : Reciever_Core
	Generic Map(
		CLK_RATE => CLK_RATE,
		BAUD_RATE => BAUD_RATE
	)
    Port map( 
			RST => RST,
			CLK =>CLk,
			Data_RX => Data_RX,
			Rec => Rec,
			RX_busy => RX_busy,
			RX  => RX
	);

end Behavioral;

