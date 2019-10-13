library IEEE;
use IEEE.std_logic_1164.all;

entity regctrl is
	port (
		CLK 	: in std_logic; -- 100 MHz clock
		Reset 	: in std_logic; -- Active high asynchronous reset
		Load 	: in std_logic; -- Active high asynchronous
		Sel		: in std_logic_vector(1 downto 0); -- Select, controled by SW7 and SW6
		Input	: in std_logic_vector(3 downto 0); -- Input to be stored, chosen by SW3-SW0
		D3		: out std_logic_vector(3 downto 0);
		D2		: out std_logic_vector(3 downto 0);
		D1		: out std_logic_vector(3 downto 0);
		D0		: out std_logic_vector(3 downto 0)
	);
end entity;


