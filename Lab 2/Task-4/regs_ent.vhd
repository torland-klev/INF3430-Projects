library IEEE;
use IEEE.std_logic_1164.all;

entity regs is
	port (
		CLK 	: in std_logic;
		RESET	: in std_logic;
		LOAD	: in std_logic;
		INP		: in std_logic_vector(3 downto 0);
		SEL		: in std_logic_vector(1 downto 0);
		abcdefgdec_n : out std_logic_vector(7 downto 0); 
		a_n : out std_logic_vector(3 downto 0) 
	);

end entity;