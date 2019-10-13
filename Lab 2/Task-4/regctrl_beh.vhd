library IEEE;
use IEEE.std_logic_1164.all;

architecture beh of regctrl is

begin
	process(CLK, reset, load)
	begin
		if (reset = '1') then
			D3 <= "0000";
			D2 <= "0000";
			D1 <= "0000";
			D0 <= "0000";
		elsif (load = '1') then
			if (rising_edge(CLK)) then
				if (sel = "11") then
					D0 <= Input;
				elsif (sel = "10") then
					D1 <= Input;
				elsif (sel = "01") then
					D2 <= Input;
				elsif (sel = "00") then
					D3 <= Input;
				else
					D3 <= "ZZZZ";
					D2 <= "ZZZZ";
					D1 <= "ZZZZ";
					D0 <= "ZZZZ";
				end if;
			end if;
		end if;	
	end process;
end architecture;