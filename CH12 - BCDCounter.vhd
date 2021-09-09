-- SKU CoE ITE Logical Circuit Design(PM) Group 16
-- 20170910 ParkSooYoung , 20170880 KangJiWon

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;

entity BCDCounter is
	port( clk : in std_logic;
		 reset : in std_logic;
	  cnt_out : out std_logic_vector(3 downto 0);
			FND : out std_logic_vector(7 downto 0);
	  FNDSel1 : out std_logic );
end BCDCounter;

architecture Behavioral of BCDCounter is
	type STATE_TYPE is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9);
	signal state, next_state : STATE_TYPE := S0;
	signal m : integer := 0;

begin
	process(clk)
	begin
		if rising_edge(clk) then
			if m < 49999999 then
				m <= m + 1;
			else
				m <= 0;
				state <= next_state;
			end if;
		end if;
	end process;

	process (state, m)
	begin
		if m < 49999999 then
			next_state <= state;
		else
			case state is
				when s0 => next_state <= s1;
					FND <= not("11111100");
				when s1=> next_state <= s2;
					FND <= not("01100000");
				when s2=> next_state <= s3;
					FND <= not("11011010");
				when s3=> next_state <= s4;
					FND <= not("11110010");
				when s4=> next_state <= s5;
					FND <= not("01100110");
				when s5=> next_state <= s6;
					FND <= not("10110110");
				when s6=> next_state <= s7;
					FND <= not("10111110");
				when s7=> next_state <= s8;
					FND <= not("11100100");
				when s8=> next_state <= s9;
					FND <= not("11111110");
				when s9=> next_state <= s0;
					FND <= not("11110110");
			end case;
		end if;
	end process;
	
	FNDSel1 <= '0';
	cnt_out <= not(conv_std_logic_vector( STATE_TYPE'POS(state), cnt_out'length ));
end Behavioral;
