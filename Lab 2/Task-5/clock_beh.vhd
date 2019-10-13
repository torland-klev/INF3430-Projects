library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture beh of clock is

constant MAX_COUNT : INTEGER := 100000000; -- Change this to 1000 for simulation
signal counter 	: INTEGER := 0; -- Counting clock cycles upto 1 second
signal count3	: INTEGER := 0;
signal count2	: INTEGER := 0;
signal count1	: INTEGER := 0;
signal count0	: INTEGER := 0;
signal stopped : std_logic := '1';

begin
	process(CLK, Reset, Stop, Start)
	begin
		if (Reset = '1') then
			D3 <= "0000";
			D2 <= "0000";
			D1 <= "0000";
			D0 <= "0000";
			count3 <= 0;
			count2 <= 0;
			count1 <= 0;
			count0 <= 0;
			stopped <= '1';		
		elsif (rising_edge(CLK)) then
			if (Start = '1') then
				stopped <= '0';
			elsif (Stop = '1') then
				Stopped <= '1';
			end if;
			
			if (Stopped = '1') then
				counter <= counter;
			elsif (stopped = '0') then
				if (counter = MAX_COUNT) then
					if (count0 = 9 ) then
						if (count1 = 9) then
							if (count2 = 9) then
								if (count3 = 9) then
									count3 <= 0;
									count2 <= 0;
									count1 <= 0;
									count0 <= 0;
								else
									count3 <= count3 + 1;
									count2 <= 0;
									count1 <= 0;
									count0 <= 0;
								end if;
							else 
								count2 <= count2 + 1;
								count1 <= 0;
								count0 <= 0;
							end if;
						else
							count1 <= count1 + 1;
							count0 <= 0;
						end if;
					else
						count0 <= count0 + 1;
					end if;
					D0 <= std_logic_vector(to_unsigned(count3, 4));
					D1 <= std_logic_vector(to_unsigned(count2, 4));
					D2 <= std_logic_vector(to_unsigned(count1, 4));
					D3 <= std_logic_vector(to_unsigned(count0, 4));
					counter <= 0;
				else
					counter <= counter + 1;
				end if;
			end if;
		end if;
	end process;
end architecture;