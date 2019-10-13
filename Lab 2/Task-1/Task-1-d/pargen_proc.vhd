
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
		-- Variables to store temp values
		variable par1, par2 : std_logic;
	begin
		if (rst_n = '0') then
			par <= '0';
		elsif rising_edge(mclk) then
			-- Changing the variable using the procedures
			parity(indata1, par1); 
			parity(indata2, par2);
			
			-- Setting the output signal using the stored values
			par <= par1 xor par2;
		end if;
	end process;

end rtl1;
