-- SKU CoE ITE Logical Circuit Design(PM) Group 16
-- 20170910 ParkSooYoung , 20170880 KangJiWon

package my_package is
	constant adder_width : integer:=4;
	constant result_width : integer:=5;
	subtype adder_value is integer range 0 to 2**adder_width-1;
	subtype result_value is integer range -2**result_width to 2**result_width-1;
end my_package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;use work.my_package.all;

entity BCDAdd is
	port( clk : in std_logic;
		  a, b : in adder_value;
			  c : in std_logic;
	 seg_data : out std_logic_vector(0 to 7);
	  seg_com : out std_logic_vector(3 downto 0));
end BCDAdd;

architecture Behavioral of BCDAdd is
	function dec_7_seg( val : INTEGER ) return std_logic_vector is -- 7 segment decoder
		variable res : std_logic_vector(7 downto 0);
	begin
		if (val = 16#0#) then res := "00000011"; --X"03" -- '0' : ON
		elsif (val = 16#1#) then res := "10011111"; --X"9F" -- '1' : OFF
		elsif (val = 16#2#) then res := "00100101"; --X"25" -- LEFT : Segment 'a'
		elsif (val = 16#3#) then res := "00001101"; --X"0D" -- RIGHT : Segment 'h'
		elsif (val = 16#4#) then res := "10011001"; --X"99"
		elsif (val = 16#5#) then res := "01001001"; --X"49"
		elsif (val = 16#6#) then res := "01000001"; --X"41"
		elsif (val = 16#7#) then res := "00011111"; --X"1F"
		elsif (val = 16#8#) then res := "00000001"; --X"01"
		elsif (val = 16#9#) then res := "00011001"; --X"19"
		elsif (val = 16#A#) then res := "00010001"; --X"11"
		elsif (val = 16#B#) then res := "11000001"; --X"C1"
		elsif (val = 16#C#) then res := "01100011"; --X"63"
		elsif (val = 16#D#) then res := "10000101"; --X"85"
		elsif (val = 16#E#) then res := "01100001"; --X"61"
		elsif (val = 16#F#) then res := "01110001"; --X"71"
		else res := "10000000";
		end if;
		return res;
	end dec_7_seg;
	
	SIGNAL d0, d1, d2, d3 : INTEGER RANGE 0 TO 15;
	SIGNAL scan : INTEGER RANGE 0 TO 3;
	signal clk1kHz : std_logic;
	
	begin
		P_SCAN : PROCESS(clk1kHz) -- Array FND Display Counter
		BEGIN
			IF clk1kHz'EVENT AND clk1kHz = '1' THEN
				IF scan /= 3 THEN
					scan <= scan + 1;
				ELSE
					scan <= 0;
				END IF;
			END IF;
		END PROCESS;
		
	process(clk)
		variable cnt : integer range 0 to 24999 := 0;
	begin
		if rising_edge(clk) then
			if cnt >= 24999 then
				cnt := 0;
				clk1kHz <= not clk1kHz;
			else
				cnt := cnt + 1;
			end if;
		end if;
	end process;
	
	P_OUT : PROCESS(scan, d0, d1, d2, d3) -- Call dec_7_seg and
	BEGIN -- According to scan
		CASE scan IS -- Sellect its display value
			WHEN 0 => seg_data <= dec_7_seg(d0);
				seg_com <= "1110"; -- SEL COM0
			WHEN 1 => seg_data <= dec_7_seg(d1);
				seg_com <= "1101"; -- SEL COM1
			WHEN 2 => seg_data <= dec_7_seg(d2);
				seg_com <= "1011"; -- SEL COM2
			WHEN 3 => seg_data <= dec_7_seg(d3);
				seg_com <= "0111"; -- SEL COM3
			WHEN OTHERS =>
				seg_data <= X"00"; --
				seg_com <= "1111"; -- SEL X
		END CASE;
	END PROCESS;
	
	process(c, a, b)
		variable result : result_value;
	begin
		d0 <= b;
		d1 <= a;
		result := a+b;
		d2 <= result mod 10;
		d3 <= result / 10;
	end process;
end Behavioral;
