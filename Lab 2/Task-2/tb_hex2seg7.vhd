library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use work.subprog_pck.all;

entity tb_hex2seg7 is
  -- empty;
end tb_hex2seg7;

architecture count of tb_hex2seg7 is
	
	component seg7model
		port (
			a_n           : in  std_logic_vector(3 downto 0);
			abcdefgdec_n  : in  std_logic_vector(7 downto 0);
			disp3         : out std_logic_vector(3 downto 0);
			disp2         : out std_logic_vector(3 downto 0);
			disp1         : out std_logic_vector(3 downto 0);
			disp0         : out std_logic_vector(3 downto 0)
		);
	end component seg7model;
  
  signal a_n : std_logic_vector(3 downto 0) := "0000";
  signal abcdefgdec_n : std_logic_vector(7 downto 0) := "00000000";
  signal disp3 : std_logic_vector(3 downto 0);
  signal disp2 : std_logic_vector(3 downto 0);
  signal disp1 : std_logic_vector(3 downto 0);
  signal disp0 : std_logic_vector(3 downto 0);
  
begin
	
	UUT : entity work.seg7model
		port map(
			a_n => a_n,
			abcdefgdec_n => abcdefgdec_n,
			disp3 => disp3,
			disp2 => disp2,
			disp1 => disp1,
			disp0 => disp0
		);

	TB : process
	begin
		for i in 0 to 12 loop
			a_n <= "0111";
			abcdefgdec_n <= hex2seg7(conv_std_logic_vector(i,4));
			wait for 50 ns;
			a_n <= "1011";
			abcdefgdec_n <= hex2seg7(conv_std_logic_vector(i+1,4));
			wait for 50 ns;
			a_n <= "1101";
			abcdefgdec_n <= hex2seg7(conv_std_logic_vector(i+2,4));
			wait for 50 ns;
			a_n <= "1110";
			abcdefgdec_n <= hex2seg7(conv_std_logic_vector(i+3,4));
			wait for 50 ns;
		end loop;
		wait;
	end process TB;
		
end architecture count;