-- SKU CoE ITE Logical Circuit Design(PM) Group 16
-- 20170910 ParkSooYoung , 20170880 KangJiWon

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY ParityChecker IS
	PORT( data_in : IN std_logic_vector(4 downto 0);
	  parityCheck : OUT std_logic);
END ParityChecker;

ARCHITECTURE Behavioral OF ParityChecker IS
	FUNCTION parity(x:std_logic_vector) RETURN std_logic IS
		VARIABLE res : std_logic := '0';
	BEGIN
		for i in x'range loop
			res := res xor x(i);
		end loop;
		RETURN res;
	END parity;

BEGIN
	PROCESS(data_in)
		VARIABLE is_wrong : std_logic;
		BEGIN
			is_wrong := parity(data_in);
			parityCheck <= not(is_wrong);
	END PROCESS;
END Behavioral;
