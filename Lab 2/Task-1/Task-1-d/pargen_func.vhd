
library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.subprog_pck.all;

entity pargen is 
  port (
    rst_n        : in  std_logic;
    mclk         : in  std_logic;
    indata1      : in  std_logic_vector(15 downto 0);
    indata2      : in  unsigned(15 downto 0);
    par          : out std_logic);  
end pargen;

architecture rtl1 of pargen is 
			
begin  

	process(rst_n, mclk)
	begin
		if (rst_n = '0') then
			par <= '0';
		elsif rising_edge(mclk) then
			par <= parity(indata1) xor parity(indata2);
		end if;
	end process;

end rtl1;