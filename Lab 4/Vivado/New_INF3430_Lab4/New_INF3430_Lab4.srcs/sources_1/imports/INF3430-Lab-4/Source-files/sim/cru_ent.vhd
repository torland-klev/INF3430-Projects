library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity cru is
	port (
		arst		   : in std_logic;		-- Asynch. reset
		refclk		 : in std_logic;		-- Reference clock
		rst			   : out std_logic;	-- Synchronized arst_n for mclk
		rst_div		: out std_logic;	-- Synchronized arst_n for mclk_div
		mclk		   : out std_logic;	-- Master clock
		mclk_div	: out std_logic		-- Master clock div. by 128.
	);
end cru;