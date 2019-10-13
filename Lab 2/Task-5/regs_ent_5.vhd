library IEEE;
use IEEE.std_logic_1164.all;

entity regs is
	port (
		CLK 	: in std_logic;
		RESET	: in std_logic;
		START	: in std_logic;
		STOP 	: in std_logic;
		abcdefgdec_n : out std_logic_vector(7 downto 0); 
		a_n : out std_logic_vector(3 downto 0) 
	);

end entity;