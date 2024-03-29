-- SKU CoE ITE Logical Circuit Design(PM) Group 16
-- 20170910 ParkSooYoung , 20170880 KangJiWon

library ieee;
use ieee.std_logic_1164.all;

entity StopWatch is
	PORT( clk : in std_logic;
	 sw_reset : in std_logic;
 sw_strtstop : in std_logic;
	  seg_com : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- 7-SEGMENT COMMON SELECT
	 seg_data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ); -- 7-SEGMENT DATA
end StopWatch;

architecture StopWatch of StopWatch is
	function dec_7_seg( val : INTEGER ) return std_logic_vector is -- 7 segment decoder
		variable res : std_logic_vector(7 downto 0);
	begin
		if (val = 16#0#) then res := not("11111100");
		elsif (val = 16#1#) then res := not("01100000");
		elsif (val = 16#2#) then res := not("11011010");
		elsif (val = 16#3#) then res := not("11110010");
		elsif (val = 16#4#) then res := not("01100110");
		elsif (val = 16#5#) then res := not("10110110");
		elsif (val = 16#6#) then res := not("10111110");
		elsif (val = 16#7#) then res := not("11100000");
		elsif (val = 16#8#) then res := not("11111110");
		elsif (val = 16#9#) then res := not("11100110");
		elsif (val = 16#A#) then res := not("11111010");
		elsif (val = 16#B#) then res := not("00111110");
		elsif (val = 16#C#) then res := not("00011010");
		elsif (val = 16#D#) then res := not("01111010");
		elsif (val = 16#E#) then res := not("11011110");
		elsif (val = 16#F#) then res := not("10001110");
		else res := not("00000001");
		end if;
		return res;
	end dec_7_seg;
	
	signal clk_1kHz, clk_1Hz : std_logic;
	signal strtstop : std_logic;
	signal sec : integer range 0 to 3599 := 0; -- until 1Hour
	
begin
	P0 : process(sw_strtstop, sw_reset)
	begin
		if( sw_reset = '0' ) then -- If sw_reset, Stop watch
			strtstop <= '0'; --
		elsif( rising_edge(sw_strtstop) ) then -- If sw_strtstop, toggle signal strtstop
			strtstop <= not strtstop; --
		end if;
	end process;
	
	P_MK_1kHz : process(sw_reset, strtstop, clk) -- Making 1kHz from 50MHz
		variable cnt : integer range 0 to 24999 := 0;
	begin
		if( sw_reset = '0' ) then -- If sw_reset, Clear counter cnt
			cnt := 0;
		elsif( rising_edge(clk) ) then
			if( cnt >= 24999 ) then
				cnt := 0;
				clk_1kHz <= not clk_1kHz; -- Toggle 1KHz Clock when cnt is 24999
			else
				cnt := cnt + 1;
			end if;
		end if;
	end process;
	
	P_MK_1Hz : process(sw_reset, clk_1kHz) -- Making 1Hz from 1kHz
		variable cnt1k : integer range 0 to 499 := 0;
	begin
		if( sw_reset = '0' ) then -- If sw_reset, Clear counter sec
			cnt1k := 0;
		elsif( rising_edge(clk_1kHz) and strtstop = '1' ) then -- If not, skip count.
			if( cnt1k >= 499 ) then
				cnt1k := 0;
				clk_1Hz <= not clk_1Hz; -- Toggle 1Hz Clock when cnt1k is 499
			else
				cnt1k := cnt1k + 1;
			end if;
		end if;
	end process;
	
	PSEC : process(sw_reset, clk_1Hz)
	begin
		if( sw_reset = '0' ) then -- If sw_reset, Clear counter sec
			sec <= 0;
		elsif( rising_edge(clk_1Hz) ) then
			if( sec /= 3599 ) then
				sec <= sec + 1;
			else
				sec <= 0;
			end if;
		end if;
	end process;
	
	P_OUT : process(clk_1kHz, sec)
		variable scan : integer range 0 to 3;
		variable d1, d2, d3, d4 : integer range 0 to 9;
	begin
		d1 := (sec / 60) / 10; -- min_val = sec / 60
		d2 := (sec / 60) mod 10;
		d3 := (sec mod 60) / 10; -- sec_val = sec mod 60
		d4 := (sec mod 60) mod 10;
		
		if( rising_edge(clk_1kHz) ) then
			scan := (scan + 1) mod 4;
		end if;
		
		case scan is
			when 0 =>seg_com <= "1110";
				seg_data <= dec_7_seg(d1);
			when 1 =>seg_com <= "1101";
				seg_data <= dec_7_seg(d2);
			when 2 =>seg_com <= "1011";
				seg_data <= dec_7_seg(d3);
			when 3 =>seg_com <= "0111";
				seg_data <= dec_7_seg(d4);
		end case;
	end process;
end StopWatch;
