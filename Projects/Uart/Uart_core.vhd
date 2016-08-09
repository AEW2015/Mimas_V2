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
				BAUD_RATE: natural :=9_600);
    Port ( 
			  RST : in STD_LOGIC;
			  CLK : in STD_LOGIC;
			  Data_TX : in  STD_LOGIC_VECTOR (7 downto 0);
           Data_RX : out  STD_LOGIC_VECTOR (7 downto 0);
           Send : in  STD_LOGIC;
			  RX : in  STD_LOGIC;
			  TX_busy : out  STD_LOGIC;
			  TX : out  STD_LOGIC;
           Rec : out  STD_LOGIC);
end Uart_core;

architecture Behavioral of Uart_core is
component Transmitter_Core is
	port( 
			RST : in STD_LOGIC;
			CLK : in STD_LOGIC;
			BIT_EN : in STD_LOGIC;
			Data_TX : in  STD_LOGIC_VECTOR (7 downto 0);
         Send : in  STD_LOGIC;
			TX_busy : out  STD_LOGIC;
         TX : out  STD_LOGIC
			);
end component;
component Reciever_Core is
	port( 
			RST : in STD_LOGIC;
			CLK : in STD_LOGIC;
			BIT_EN : in STD_LOGIC;
			Data_RX : out  STD_LOGIC_VECTOR (7 downto 0);
         Rec : out  STD_LOGIC;
         RX : in  STD_LOGIC
			);
end component;
-----------------------------------------------
function log2c (n: integer) return integer is 
variable m, p: integer; 
begin 
m := 0; 
p := 1; 
while p < n loop 
m := m + 1; 
p := p * 2; 
end loop; 
return m; 
end log2c;
---------------------------------------------------
constant BIT_COUNTER_MAX_VAL : Natural := CLK_RATE/BAUD_RATE/16 - 1;
--div by 16 to find its half mark
constant BIT_COUNTER_BITS : Natural := log2c(BIT_COUNTER_MAX_VAL);
signal bit_timer,bit_timer_next : unsigned(BIT_COUNTER_BITS-1 downto 0);
signal BIT_EN: STD_LOGIC;


begin


process (CLK,RST)
begin 
	if (RST = '1') then
		bit_timer <= (others=>'0');
	elsif rising_edge(CLK) then
		bit_timer <= bit_timer_next;
	end if;
end process;


bit_timer_next<= (others=>'0') when (bit_timer = BIT_COUNTER_MAX_VAL) else
						bit_timer+1;

BIT_EN <= '1' when bit_timer = BIT_COUNTER_MAX_VAL else
				'0';

Transmitter_Core_i : Transmitter_Core
    Port map( 
			RST => RST,
			CLK =>CLk,
			BIT_EN => BIT_EN,
			Data_TX => Data_TX,
			Send => Send,
			TX_busy => TX_busy,
			TX  => TX
	);
Reciever_Core_i : Reciever_Core
    Port map( 
			RST => RST,
			CLK =>CLk,
			BIT_EN => BIT_EN,
			Data_RX => Data_RX,
			Rec => Rec,
			RX  => RX
	);

end Behavioral;

