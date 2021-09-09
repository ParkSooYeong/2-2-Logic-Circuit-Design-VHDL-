library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LeadingOneCounter is
	port( d : in std_logic_vector(7 downto 0);
		 FND : out std_logic_vector(0 to 7);
	FNDSel1 : out std_logic;
		 led : out std_logic_vector(7 downto 0));
end LeadingOneCounter;

architecture Behavioral of LeadingOneCounter is
begin
	led <= not(d);
	FNDSel1 <= '0';
	CNT : PROCESS(d)
	
	variable oneCount : integer range 0 to 8;
	
	begin
		oneCount := 0;
		
		for i in d'range loop
			if(d(i)='1') then
				oneCount := oneCount + 1;
			else
				exit;
			end if;
		end loop;
	
		case oneCount is --"abcdefg-"
			when 0 => FND <= not("11111100"); --X"03"; "11111100";
			when 1 => FND <= not("01100000"); --X"9F"; "01100000";
			when 2 => FND <= not("11011010"); --X"25"; "11011010";
			when 3 => FND <= not("11110010"); --X"0D"; "11110010";
			when 4 => FND <= not("01100110"); --X"99"; "01100110";
			when 5 => FND <= not("10110110"); --X"49"; "10110110";
			when 6 => FND <= not("10111110"); --X"41"; "10111110";
			when 7 => FND <= not("11100000"); --X"1F"; "11100000";
			when 8 => FND <= not("11111110"); --X"01"; "11111110";
			when others =>FND <= not("00000001");
		end case;
	end process;
end Behavioral;
