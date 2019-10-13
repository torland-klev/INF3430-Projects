library IEEE;
use IEEE.std_logic_1164.all;

entity seg7_ctrl is 
	port ( 
		mclk		 : in std_logic; 					 -- This component uses master clock
		rst			 : in std_logic; 					 -- Asynchronous reset 
		pos1		 : in std_logic_vector(7 downto 0);  -- DISP1 and DISP0
		sp			 : in std_logic_vector(7 downto 0);  -- DISP3 and DISP2
		dec 		 : in std_logic_vector(3 downto 0);  -- Hardcoded as "1111", useless in this setting
		abcdefgdec_n : out std_logic_vector(7 downto 0); -- Output char to seven segment
		a_n 		 : out std_logic_vector(3 downto 0)  -- Output which display to use
	); 
end entity seg7_ctrl;