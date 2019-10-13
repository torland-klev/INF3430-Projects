library IEEE;
use IEEE.std_logic_1164.all;

entity clock is
	port (
		CLK 				: in std_logic; -- 100 MHz clock
		Reset 				: in std_logic; -- Active high asynchronous reset
		Start				: in std_logic; -- Press once to start
		Stop				: in std_logic; -- Press once to stop, asynchronous
		D3, D2, D1, D0, DEC	: out std_logic_vector(3 downto 0)
	);
end entity;
