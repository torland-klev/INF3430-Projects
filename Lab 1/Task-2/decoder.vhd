library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder is
	Port
	(
		Input	:	in	std_logic_vector (1 downto 0); 	-- 2-bit input
		Output	:	out	std_logic_vector (3 downto 0); 	-- 4-bit output
		Enable	:	in 	std_logic					   	-- Enable
	);
end decoder;

architecture decoder_arch of decoder is
begin
	DECODER:
	process (Input, Enable)
	
	begin
		Output <= "1001";	-- default output
		if (Enable = '1') then
			case Input is
				when "00" => Output <= "1110";
				when "01" => Output <= "1101";
				when "10" => Output <= "1011";
				when "11" => Output <= "0111";
				when others => Output <= "1001";
			end case;
		end if;
	end process;
end decoder_arch;