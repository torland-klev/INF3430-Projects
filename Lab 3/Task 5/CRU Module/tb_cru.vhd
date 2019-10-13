library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cru_tb is
end cru_tb;

architecture behaviour of cru_tb is

	component cru is
		port (
			arst		   : in std_logic;		-- Asynch. reset
			refclk		 : in std_logic;		-- Reference clock
			rst			   : out std_logic;	-- Synchronized arst_n for mclk
			rst_div	 : out std_logic;	-- Synchronized arst_n for mclk_div
			mclk	  	 : out std_logic;	-- Master clock
			mclk_div	: out std_logic		-- Master clock div. by 128.
		);
	end component;
	
	-- Input signals
	signal arst, refclk		 : std_logic := '0';
	
	-- Output signals
	signal mclk, mclk_div	 : std_logic := '0';
	signal rst, rst_div		 : std_logic := '0';

	constant clk_half_period : time := 5 ns;
	constant clk_period 	 : time := 10 ns;	
	
begin
  
  -- Port map the clock-reset-unit
	UUT: cru
	port map (
		arst => arst,
		refclk => refclk,
		rst => rst,
		rst_div => rst_div,
		mclk => mclk,
		mclk_div => mclk_div
	);
	
	-- Simulate the clock
	CLOCK_PROCESS: process
	begin
		refclk <= '0';
		wait for clk_half_period;
		refclk <= '1';
		wait for clk_half_period;
	end process;
	
	STIMULI: process
	begin
		wait for clk_period*2;
		arst <= '1';
		wait for clk_period*6;
		arst <= '0';
		wait for clk_period*200;
		arst <= '1';
		wait for clk_period*256;
		arst <= '0';
		wait;
	end process;
	
end;