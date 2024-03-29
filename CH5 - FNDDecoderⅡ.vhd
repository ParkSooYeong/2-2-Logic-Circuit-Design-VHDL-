-- SKU CoE ITE Logical Circuit Design(PM) Group 16
-- 20170910 ParkSooYoung , 20170880 KangJiWon

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity FNDDecoderII is
	port( clk : in std_logic;
			a, b : in std_logic_vector(3 downto 0);
			FND : out std_logic_vector(0 to 6);
			FNDSel2, FNDSel1 : out std_logic);
end FNDDecoderII;

architecture Behavioral of FNDDecoderII is
	signal FNDa, FNDb : std_logic_vector(0 to 6);
	signal clk100Hz : std_logic;
	
	begin
		process(clk)
			variable m : integer := 0;
		begin
			if rising_edge(clk) then
				if m >= 249999 then
					m := 0;
					clk100Hz <= not clk100Hz;
				
				else
					m := m + 1;
				end if;
			end if;
		end process;
		
		process(clk, a, b)
		begin
			if rising_edge(clk) then
				case a is
					when "0000" => FNDa <= "0000001";
					when "0001" => FNDa <= "1001111";
					when "0010" => FNDa <= "0010010";
					when "0011" => FNDa <= "0000110";
					when "0100" => FNDa <= "1001100";
					when "0101" => FNDa <= "0100100";
					when "0110" => FNDa <= "0100000";
					when "0111" => FNDa <= "0001111";
					when "1000" => FNDa <= "0000000";
					when "1001" => FNDa <= "0000100";
					when "1010" => FNDa <= "0001000";
					when "1011" => FNDa <= "1100000";
					when "1100" => FNDa <= "0110001";
					when "1101" => FNDa <= "1000010";
					when "1110" => FNDa <= "0010000";
					when "1111" => FNDa <= "0111000";
					when others => null;
				end case;
				
				case b is
					when "0000" => FNDb <= "0000001";
					when "0001" => FNDb <= "1001111";
					when "0010" => FNDb <= "0010010";
					when "0011" => FNDb <= "0000110";
					when "0100" => FNDb <= "1001100";
					when "0101" => FNDb <= "0100100";
					when "0110" => FNDb <= "0100000";
					when "0111" => FNDb <= "0001111";
					when "1000" => FNDb <= "0000000";
					when "1001" => FNDb <= "0000100";
					when "1010" => FNDb <= "0001000";
					when "1011" => FNDb <= "1100000";
					when "1100" => FNDb <= "0110001";
					when "1101" => FNDb <= "1000010";
					when "1110" => FNDb <= "0010000";
					when "1111" => FNDb <= "0111000";
					when others => null;
				end case;
			end if;
		end process;
		
		process(clk100Hz, FNDa, FNDb)
		begin
			if (clk100Hz = '1') then
				FNDSel1 <= '0';
				FNDSel2 <= '1';
				FND <= FNDa;
			else
				FNDSel1 <= '1';
				FNDSel2 <= '0';
				FND <= FNDb;
			end if;
		end process;
end Behavioral;
