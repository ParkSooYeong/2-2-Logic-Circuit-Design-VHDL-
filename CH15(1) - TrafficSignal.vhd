-- SKU CoE ITE Logical Circuit Design(PM) Group 16
-- 20170910 ParkSooYoung , 20170880 KangJiWon

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;

entity TrafficSignal is
	port ( reset : in std_logic;
			 inClk : in std_logic;
			sigout : out std_logic_vector(3 downto 0) );
end TrafficSignal;

architecture Behavioral of TrafficSignal is
	type state_type is (s0, s1, s2, s3, s4);
	signal state, next_state : state_type := s0;
	signal clkCount : integer range 0 to 15 := 0;

begin
	process(reset, inClk)
	begin
		if reset='0' then
			state <= s0;
			clkCount <= 0;
		elsif rising_edge(inClk) then
			state <= next_state;
			if ((state = s0 and clkCount >= 15) or
				 (state = s1 and clkCount >= 10) or
				 (state = s2 and clkCount >= 3)  or
				 (state = s3 and clkCount >= 5)  or
				 (state = s4 and clkCount >= 2)) then
				clkCount <= 0;
			else
				clkCount <= clkCount + 1;
			end if;
		end if;
	end process;
	
	process(state, clkCount)
	begin
		case state is
			when s0 =>
				if clkCount >= 15 then
					next_state <= s1;
				else
					next_state <= s0;
				end if;
				sigout <= "0111";
			when s1 =>
				if clkCount >= 10 then
					next_state <= s2;
				else
					next_state <= s1;
				end if;
				sigout <= "1110";
			when s2 =>
				if clkCount >= 3 then
					next_state <= s3;
				else
					next_state <= s2;
				end if;
				sigout <= "1011";
			when s3 =>
				if clkCount >= 5 then
					next_state <= s3;
				else
					next_state <= s4;
				end if;
				sigout <= "0101";
			when s4 =>
				if clkCount >= 2 then
					next_state <= s0;
				else
					next_state <= s4;
				end if;
				sigout <= "0011";
		end case;
	end process;
end Behavioral;
