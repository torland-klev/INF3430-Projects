library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rstsynch_tb is
end rstsynch_tb;

architecture behaviour of rstsynch_tb is

	component rstsynch is
		port (
			arst		: in STD_LOGIC;	 -- Asynch. reset
			mclk		: in STD_LOGIC;	 -- Master mclk
			mclk_div 	: in STD_LOGIC;	 -- Master mclk div. by 128
			rst 		: out STD_LOGIC; -- Synch. reset master mclk
			rst_div		: out STD_LOGIC  -- Synch. reset div. by 128
		);
	end component;
	
	signal clk, clkdiv 				: std_logic := '0';
	signal arst, reset, rst_div : std_logic := '0';
	
	constant clk_half_period 	: time := 5 ns;
	constant clk_period 	 	: time := 10 ns;
	constant clkdiv_half_period : time := 5*128 ns;
	constant clkdiv_period : time := 10*128 ns;
	
begin
	
	UUT: rstsynch
	port map (
		arst => arst,
		mclk => clk,
		mclk_div => clkdiv,
		rst => reset,
		rst_div => rst_div
	);
	
	CLOCK_PROCESS: process
	begin
		clk <= '0';
		wait for clk_half_period;
		clk <= '1';
		wait for clk_half_period;
	end process;
	
	CLOCK_DIV_PROCESS: process
	begin
		clkdiv <= '0';
		wait for clkdiv_half_period;
		clkdiv <= '1';
		wait for clkdiv_half_period;
	end process;
	
	STIMULI: process
	begin
	  arst <= '0';
		wait for clk_period*2;
		arst <= '1';
		wait for clk_period*6;
		arst <= '0';
		wait for clk_period*4;
		arst <= '1';
		wait for clk_period*2;
		arst <= '0';
		wait for clk_period*200;
		arst <= '1';
		wait for clk_period*10;
		arst <= '0';
		wait;
	end process;
		
	
END;