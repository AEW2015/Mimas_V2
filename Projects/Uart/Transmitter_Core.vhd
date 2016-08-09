----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:42:55 08/09/2016 
-- Design Name: 
-- Module Name:    Transmitter_Core - Behavioral 
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Transmitter_Core is
    Port ( RST : in STD_LOGIC;
			  CLK : in STD_LOGIC;
			  BIT_EN : in STD_LOGIC;
			  Data_TX : in  STD_LOGIC_VECTOR (7 downto 0);
           Send : in  STD_LOGIC;
			  TX_busy : out  STD_LOGIC;
           TX : out  STD_LOGIC);
end Transmitter_Core;

architecture Behavioral of Transmitter_Core is
constant BIT_COUNTER_MAX_VAL : Natural := 15;
type fsm is (IDLE,STRT,DATA,STP,RETRN);
signal state,state_next: fsm;
signal reg, reg_next : std_logic_vector(7 downto 0);

signal bit_counter, bit_counter_next : unsigned(7 downto 0);

signal tx_reg: std_logic:='1';
signal tx_reg_next: std_logic;
signal tx_bit,shift,load,stop,start,shift_out,clrTimer: std_logic;

begin
------------------------
-------CLK LOGIC--------
------------------------
	process(rst,clk)
	begin
		if(rst ='1') then
			state <= IDLE;
			bit_counter<= (others=>'0');
			reg<=(others=>'0');
			tx_reg<='1';
		elsif (clk'event and clk = '1') then
			state<=state_next;
			bit_counter<=bit_counter_next;
			reg<=reg_next;
			tx_reg<=tx_reg_next;
		end if;
	end process;
	
--------------------------
---FSM NEXT STATE LOGIC---
--------------------------
	process(Send,state,tx_bit,end_data_flag)
	begin
		shift <= '0';
		load <= '0';
		stop <= '0';
		start <= '0';
		clrTimer <= '0';
		tx_busy<= '1';
		case state is
			when IDLE =>
				tx_busy<= '0';
				stop<= '1';
				clrTimer<='1';
				if (Send = '1') then
					state_next <= STRT;
					load <= '1';
				else
					state_next <= IDLE;
				end if;
			when STRT =>
				start <= '1';
				if (tx_bit = '1') then
					state_next <= DATA;
				else
					state_next <= STRT;
				end if;
			when DATA =>
				if (tx_bit = '1') then
					shift <= '1';
				elsif (end_data_flag = '1')
				else
					state_next <= DATA;
				end if;
			when STP =>
				stop<= '1';
				if (tx_bit = '1') then
					state_next <= RETRN;
				else
					state_next <= STP;
				end if;	
			when RETRN =>
				stop<= '1';
				--only one byte at a time?
				if (Send = '0') then
					state_next <= IDLE;
				else
					state_next <= RETRN;
				end if;
		end case;
	end process;
	
----------------------------------------
-------COUNTER NEXT STATE LOGIC---------
----------------------------------------
process (bit_counter,BIT_EN,clrTimer)
begin
	bit_counter_next<=bit_counter;
	tx_bit <= '0';
	end_data_flag <= '0';
	
	
	if (BIT_EN = '1') then
		bit_counter_next<=bit_counter+1;
		if(bit_counter(3 downto 0) = 15) then
			tx_bit <= '1';
			if(bit_counter(6 downto 4) = 8) then
				end_data_flag <= '1';
			end if;
		end if;
	end if;

end process;

						
						
						
						
						
reg_next <= Data_TX when load = '1' else
				'0' & reg(7 downto 1) when shift='1' else
				reg;
shift_out <= reg(0);
				
tx_reg_next<= '1' when stop = '1' else 
			'0' when start = '1' else
			shift_out;
				

----------------------
-------outputs--------
----------------------
TX<= tx_reg;	
	
	

end Behavioral;

