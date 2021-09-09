-- SKU CoE ITE Logical Circuit Design(PM) Group 16
-- 20170910 ParkSooYoung , 20170880 KangJiWon

package my_package is
	constant input_width : integer := 4;
	constant output_width : integer := 4;
	subtype input_value is integer range 0 to 2**input_width-1;
	subtype output_value is integer range 0 to 2**output_width-1;
end my_package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_package.all;

entity Sorting is
	port ( clk : in std_logic;
			a, b : in input_value; --integer range 0 to 15;
			 FND : out std_logic_vector(0 to 7);
			 SEL : out std_logic_vector(0 to 1) );
end Sorting;

architecture Behavioral of Sorting is
	signal clk100Hz : std_logic;
	signal disp_val : output_value;
	
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
	
	process(clk100Hz, a, b)
	begin
		if(clk100Hz = '1') then
			SEL <= "01";
			if( a > b ) then
				disp_val <= a;
			else
				disp_val <= b;
			end if;
		else
			SEL <= "10";
			if( a > b ) then
				disp_val <= b;
			else
				disp_val <= a;
			end if;
		end if;
	end process;

	-- process for 7-segment Decording
	process(disp_val)
	begin
		case disp_val is
			when 0 => FND <= "00000010"; when 1 => FND <= "10011110";
			when 2 => FND <= "00100100"; when 3 => FND <= "00001100";
			when 4 => FND <= "10011000"; when 5 => FND <= "01001000";
			when 6 => FND <= "01000000"; when 7 => FND <= "00011110";
			when 8 => FND <= "00000000"; when 9 => FND <= "00011000";
			when 10 => FND <= "00010000"; when 11 => FND <= "11000000";
			when 12 => FND <= "11100100"; when 13 => FND <= "10000100";
			when 14 => FND <= "00100000"; when 15 => FND <= "01110000";
		end case;
	end process;
end Behavioral;
