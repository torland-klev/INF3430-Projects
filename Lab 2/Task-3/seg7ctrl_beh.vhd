library IEEE;
library work;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.subprog_pck.all;

architecture beh of seg7ctrl is
	constant CLOCK_CYCLES : INTEGER := 127;
	signal count : INTEGER := 0;
	signal display_number : INTEGER := 0;
begin

	process (mclk, reset) is
	begin 
	if (reset = '1') then
		a_n <= "ZZZZ";
		abcdefgdec_n <= "ZZZZZZZZ";
		count <= 0;
		display_number <= 0;
	elsif (rising_edge(mclk)) then
		if (count = CLOCK_CYCLES) then
			if (display_number = 3) then
				display_number <= 0;
			else 
				display_number <= display_number + 1;
			end if;
			count <= 0;
		else 
			count <= count + 1;
		end if;
		a_n <= "1111";
		a_n(display_number) <= '0';
		if (display_number = 0) then
			abcdefgdec_n <= hex2seg7(d0);
		--	abcdefgdec_n(0) <= not dec(0);
		elsif (display_number = 1) then
			abcdefgdec_n <= hex2seg7(d1);
		--	abcdefgdec_n(0) <= not dec(1);
		elsif (display_number = 2) then
			abcdefgdec_n <= hex2seg7(d2);
		--	abcdefgdec_n(0) <= not dec(2);
		elsif (display_number = 3) then
			abcdefgdec_n <= hex2seg7(d3);
		--	abcdefgdec_n(0) <= not dec(3);
		else
			abcdefgdec_n <= "ZZZZZZZZ";
		end if;
	end if;
	end process;
end architecture beh;