library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity clkdiv is
	port (
		rst		 : in STD_LOGIC;	-- Reset
		mclk	 : in STD_LOGIC;	-- Master clock
		mclk_div : out STD_LOGIC	-- Master clock div. by 128		
	);
end clkdiv;