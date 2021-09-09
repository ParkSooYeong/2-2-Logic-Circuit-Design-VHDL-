-- SKU CoE ITE 논리회로설계(오후반) - 16조 20170910 박수영 , 20170880 강지원

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SimpleGates is
port(A, B, C, D : in std_logic;
     Y          : out std_logic);
end SimpleGates;

architecture Behavioral of SimpleGates is
begin
	Y <= (A nor B) and (C nand D);
end Behavioral;
