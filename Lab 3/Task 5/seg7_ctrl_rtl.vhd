library IEEE;
library work;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.subprog_pck.all;

architecture beh of seg7_ctrl is
	constant CLOCK_CYCLES : INTEGER := 127;
	signal count : INTEGER := 0;
	signal display_number : INTEGER := 0;
begin
	
	process (mclk, rst) is
	begin 
		if (rst = '1') then									-- rst os async.
			a_n <= "ZZZZ";									-- If reset, set outputs to 
			abcdefgdec_n <= "ZZZZZZZZ";						-- high impendence and reset
			count <= 0;										-- internal signals.
			display_number <= 0;
		elsif (rising_edge(mclk)) then						-- Positivly edgetriggered
			if (count = CLOCK_CYCLES) then					-- Statement true if display has been active for decided amount of time
				if (display_number = 3) then				-- If at third display, start over at the first one
					display_number <= 0;					
				else 
					display_number <= display_number + 1;	-- Else go to the next one
				end if;
				count <= 0;									-- Reset count, as decided amount of clock cycles has been completed
			else 
				count <= count + 1;							-- Increment count if not reached decided count
			end if;
			a_n <= "1111";									-- No active displays
			a_n(display_number) <= '0';						-- Set display_number to be active display
			if (display_number = 0) then					
				abcdefgdec_n <= hex2seg7(pos1(3 downto 0));
			elsif (display_number = 1) then
				abcdefgdec_n <= hex2seg7(pos1(7 downto 4));
			elsif (display_number = 2) then
				abcdefgdec_n <= hex2seg7(sp(3 downto 0));
			elsif (display_number = 3) then
				abcdefgdec_n <= hex2seg7(sp(7 downto 4));
			else
				abcdefgdec_n <= "ZZZZZZZZ";					-- High impendence if error
			end if;
		end if;
	end process;
end architecture beh;