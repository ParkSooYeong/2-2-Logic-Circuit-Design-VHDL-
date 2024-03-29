-- SKU CoE ITE Logical Circuit Design(PM) Group 16
-- 20170910 ParkSooYoung, 20170880 KangJiWon

library ieee;
use ieee.std_logic_1164.all;

entity Encoder is
	port(D : in std_logic_vector(7 downto 0);
		  A : out std_logic_vector(2 downto 0);
		  v : out std_logic);
end Encoder;

architecture design of Encoder is
begin
	process(D)
	begin
		if D(7) = '0' then
			V <= '0';
			A <= "000";
		elsif D(6) = '0' then
			V <= '0';
			A <= "001";
		elsif D(5) = '0' then
			V <= '0';
			A <= "010";
		elsif D(4) = '0' then
			V <= '0';
			A <= "011";
		elsif D(3) = '0' then
			V <= '0';
			A <= "100";
		elsif D(2) = '0' then
			V <= '0';
			A <= "101";
		elsif D(1) = '0' then
			V <= '0';
			A <= "110";
		elsif D(0) = '0' then
			V <= '0';
			A <= "111";
		else
			V <= '1';
			A <= "111";
		end if;
	end process;
end design;
