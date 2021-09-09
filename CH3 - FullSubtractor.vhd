-- SKU CoE ITE 논리회로설계(오후반) - 16조 20170910 박수영 , 20170880 강지원

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity FullSubtractor is
	port( Xi, Yi, Bi : in integer range 0 to 1;
			Di, B : out std_logic);
end FullSubtractor;

architecture behavioral of FullSubtractor is
	signal diff : integer range -2 to 1;

begin
	process(Xi, Yi, Bi, diff)
	begin
		diff <= Xi - Yi - Bi;
		if diff = -2 then
			Di <= '0';
			B <= '1';
		elsif diff = -1 then
			Di <= '1';
			B <= '1';
		elsif diff = 0 then
			Di <= '0';
			B <= '0';
		else
			Di <= '1';
			B <= '0';
		end if;
	end process;
end behavioral;
