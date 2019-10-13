library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity rstsynch is
	port (
		arst		    : in STD_LOGIC;	 -- Asynch. reset
		mclk		    : in STD_LOGIC;	 -- Master clock
		mclk_div 	: in STD_LOGIC;	 -- Master clock div. by 128
		rst 		    : out STD_LOGIC; -- Synch. reset master clock
		rst_div		 : out STD_LOGIC  -- Synch. reset div. by 128
	);
end rstsynch;