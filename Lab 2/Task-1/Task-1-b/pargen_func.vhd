
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pargen is 
  port (
    rst_n        : in  std_logic;
    mclk         : in  std_logic;
    indata1      : in  std_logic_vector(15 downto 0);
    indata2      : in  unsigned(15 downto 0);
    par          : out std_logic);  
end pargen;

architecture rtl1 of pargen is 
-- Signal- and function declarations

-- function function_name (parameter_list) return type is
--	 declarations
-- begin
--	 sequential statements
-- end function_name;


	-- First function using 'not' 
	function parity (indata : in std_logic_vector(15 downto 0)) 
		return std_logic is variable par : std_logic;
	begin
		par := '0';
		for i in indata'range loop
			if indata(i) = '1' then
				par := not par;
			end if;
		end loop;
		return par;
	end function parity;
	
	-- Second function using 'xor'
	function parity (indata : in unsigned(15 downto 0)) 
		return std_logic is variable par : std_logic;
	begin
		par := '0';
		for i in indata'range loop
			if indata(i) = '1' then
				par := par xor indata(i);
			end if;
		end loop;
		return par;
	end function parity;
			
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