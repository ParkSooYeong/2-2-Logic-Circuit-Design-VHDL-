-- SKU CoE ITE Logical Circuit Design(PM) Group 16
-- 20170910 ParkSooYoung , 20170880 KangJiWon

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;

entity ClockDivider is
	port ( reset : in std_logic;
			 inClk : in std_logic;
			outClk : out std_logic);
end ClockDivider;

architecture Behavioral of ClockDivider is
	type state_type is (s0, s1);
	signal state, next_state : state_type := s0;
	signal clkCount : integer := 0;

begin
	process(reset, inClk)
	begin
		if reset='0' then
			state <= s0;
			clkCount <= 0;
		elsif rising_edge(inClk) then
			state <= next_state;
			if clkCount >= 24999999 then
				clkCount <= 0;
			else
				clkCount <= clkCount + 1;
			end if;
		end if;
	end process;
	
	process(clkCount, state)
	begin
		case state is
			when s0 =>
				if clkCount >= 24999999 then -- 0.5sec (50MHz)
					next_state <= s1;
				else
					next_state <= s0;
				end if;
				outClk <= '0';
			when s1 =>
				if clkCount >= 24999999 then -- 0.5sec (50MHz)
					next_state <= s0;
				else
					next_state <= s1;
				end if;
				outClk <= '1';
		end case;
	end process;
end Behavioral;
