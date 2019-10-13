library IEEE;
use IEEE.STD_LOGIC_1164.all;
library unisim;
use unisim.all;

architecture str of cru is
	
	component bufg
		port (
			i : in std_logic;
			o : out std_logic
		);
	end component;
	
	component rstsynch is
		port (
			arst		: in std_logic;	 -- Asynch. reset
			mclk		: in std_logic;	 -- Master clock
			mclk_div	: in std_logic;	 -- Master clock div. by 128
			rst			: out std_logic;	-- Synch. reset master clock
			rst_div		: out std_logic	 -- Synch. reset div. by 128
		);
	end component rstsynch;
	
	component clkdiv is
		port (
			rst			: in std_logic;	-- Reset
			mclk		: in std_logic;	-- Master clock
			mclk_div	: out std_logic	-- Master clock div. by 128
		);
	end component clkdiv;
	
	signal rst_i		  : std_logic;
	signal rst_local	  : std_logic;
	signal rst_div_local  : std_logic;
	signal rst_div_i	  : std_logic;
	signal mclk_i		  : std_logic;
	signal mclk_div_local : std_logic;
	signal mclk_div_i	  : std_logic;

begin

	bufg_0: bufg
		port map (
			i => refclk,
			o => mclk_i);
		
	rstsynch_0: rstsynch
		port map (
			arst => arst,
			mclk => mclk_i,
			mclk_div => mclk_div_i,
			rst => rst_local,
			rst_div => rst_div_local
		);
		
	bufg_1: bufg
		port map (
			i => rst_local,
			o => rst_i
		);
		
	bufg_2: bufg
		port map (
			i => rst_div_local,
			o => rst_div_i
		);
	
	clkdiv_0: clkdiv
		port map (
			rst => rst_i,
			mclk => mclk_i,
			mclk_div => mclk_div_local
		);
		
	bufg_3: bufg
		port map (
			i => mclk_div_local,
			o => mclk_div_i
		);
	
	rst <= rst_i;
	rst_div <= rst_div_i;
	mclk <= mclk_i;
	mclk_div <= mclk_div_i;

end str;