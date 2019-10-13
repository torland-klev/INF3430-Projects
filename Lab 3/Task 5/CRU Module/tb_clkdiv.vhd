library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clkdiv_tb is
end clkdiv_tb;

architecture behaviour of clkdiv_tb is

	component clkdiv is
	port (
		rst		 : in STD_LOGIC;	-- Reset
		mclk	 : in STD_LOGIC;	-- Master clock
		mclk_div : out STD_LOGIC	-- Master clock div. by 128		
	);
end component;
	
	signal reset, clock : std_logic := '0';
	signal clock_div	: std_logic := '0';
	
	constant clk_half_period : time := 5 ns;
	constant clk_period 	 : time := 10 ns;
	
begin
	
	UUT: clkdiv PORT MAP(
		rst => reset,
		mclk => clock,
		mclk_div => clock_div
	);
	
	CLOCK_PROCESS: process
	begin
		clock <= '0';
		wait for clk_half_period;
		clock <= '1';
		wait for clk_half_period;
	end process;
	
	STIMULI: process 
	begin
		wait for clk_period*3;
		reset <= '1';
		wait for clk_period*3;
		reset <= '0';
		wait for clk_period*128;	-- Clk_div should become high here
		wait for clk_period*72;
		reset <= '1';
		wait for clk_period*200;
		reset <= '0';
		wait;
	end process;

END;