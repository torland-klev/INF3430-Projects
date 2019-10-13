library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TEST_DECODER is
end TEST_DECODER;

architecture TESTBENCH of TEST_DECODER is

	component decoder
	 port
	 (
		INPUT	:	in	std_logic_vector(1 downto 0); 	-- 2-bit input
		OUTPUT	:	out	std_logic_vector(3 downto 0); 	-- 4-bit output
		ENABLE	:	in 	std_logic					   	-- Enable
	 );
	end component;
	
	signal INPUT : std_logic_vector(1 downto 0) := (others => '0');
	signal OUTPUT : std_logic_vector(3 downto 0);
	signal ENABLE : std_logic := '0';
	
begin
	
	UUT : decoder
	port map(
		Input => Input,
		Output => Output,
		Enable => Enable
	);
	
	STIMULI:
	process
	begin
		Enable <= '0', '1' after 100 ns;
		Input <= "00";
		wait for 200 ns;
		Input <= "01";
		wait for 100 ns;
		Input <= "10";
		wait for 100 ns;
		Input <= "11";
		wait;
	end process;
end;
		
	
	
 
