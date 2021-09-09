-- SKU CoE ITE 논리회로설계(오후반) - 16조 20170910 박수영 , 20170880 강지원

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SampleProject is
	port( a, b			: in std_logic;
	       and_out, or_out, not_out	: out std_logic);
end SampleProject;

architecture Behavioral of SampleProject is
begin
	and_out <= a and b;
	or_out <= a or b;
	not_out <= not a;
end Behavioral;
