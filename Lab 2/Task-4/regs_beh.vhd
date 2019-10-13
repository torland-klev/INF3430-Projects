library IEEE;
library work;
use IEEE.std_logic_1164.all;
use work.subprog_pck.all;

architecture beh of regs is
-- Component Instantiations

Component regctrl 
	port (
		CLK, Reset, Load 	: in std_logic;
		Sel 				: in std_logic_vector(1 downto 0);
		Input				: in std_logic_vector(3 downto 0);
		D3, D2, D1, D0		: out std_logic_vector(3 downto 0)
		);
end component; 

component seg7ctrl
	port (
		MCLK, Reset			: in std_logic;
		D3, D2, D1, D0, DEC	: in std_logic_vector(3 downto 0);
		a_n					: out std_logic_vector(3 downto 0);
		abcdefgdec_n		: out std_logic_vector(7 downto 0)
	);
end component;

-- Internal Signal Declarations
signal D3i, D2i, D1i, D0i 	: std_logic_vector(3 downto 0);
signal Dec 					: std_logic_vector(3 downto 0) := "0000";

-- Behaviour

begin
	REGISTER_CONTROL: 
	regctrl port map(
		CLK => CLK,
		Reset => Reset,
		Load => Load,
		Sel => Sel,
		Input => INP,
		D3 => D3i,
		D2 => D2i,
		D1 => D1i,
		D0 => D0i
	);
	
	SEGMENT_CONTROL:
	seg7ctrl port map(
		MCLK => CLK,
		Reset => Reset,
		D3 => D3i,
		D2 => D2i,
		D1 => D1i,
		D0 => D0i,
		Dec => Dec,
		abcdefgdec_n => abcdefgdec_n,
		a_n => a_n
	);

end architecture;