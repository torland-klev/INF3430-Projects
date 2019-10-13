library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package SUBPROG_PCK is
  
  	procedure parity   (indata : in std_logic_vector(15 downto 0); par : inout std_logic);
	                    
	procedure parity   (indata : in unsigned(15 downto 0); par : inout std_logic);
	                    
	function parity (indata : in std_logic_vector(15 downto 0)) return std_logic;
		
	function parity (indata : in unsigned(15 downto 0)) return std_logic;
	
	function hex2seg7 (indata : in std_logic_vector) return std_logic_vector;
	
end package SUBPROG_PCK;

package body SUBPROG_PCK is
	-- First procedure using 'not' 
	procedure parity   (indata : in std_logic_vector(15 downto 0);
	                    par : inout std_logic) is
	begin
		for i in indata'range loop
			if indata(i) = '1' then
				par := not par;
			end if;
		end loop;
	end procedure parity;
	
	-- Second procedure using 'xor'
	procedure parity   (indata : in unsigned(15 downto 0);
	                    par : inout std_logic) is
	begin
		for i in indata'range loop
			if indata(i) = '1' then
				par := par xor indata(i);
			end if;
		end loop;
	end procedure parity;
	
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
	
	-- function hex2seg
	function hex2seg7 (indata : std_logic_vector(3 downto 0)) 
		return std_logic_vector is variable output : std_logic_vector(7 downto 0);
	begin
		case indata is
			when "0000" => output := "00000011"; -- 0
			when "0001" => output := "10011111"; -- 1
			when "0010" => output := "00100101"; -- 2
			when "0011" => output := "00001101"; -- 3
			when "0100" => output := "10011001"; -- 4
			when "0101" => output := "01001001"; -- 5
			when "0110" => output := "01000001"; -- 6
			when "0111" => output := "00011111"; -- 7
			when "1000" => output := "00000001"; -- 8
			when "1001" => output := "00011001"; -- 9
			when "1010" => output := "00010001"; -- A
			when "1011" => output := "11000001"; -- B
			when "1100" => output := "01100011"; -- C
			when "1101" => output := "10000101"; -- D
			when "1110" => output := "01100001"; -- E
			when "1111" => output := "01110001"; -- F
			when others => null;
			-- when others => output <= "11111111";
		end case;
		return output;
	end function hex2seg7;
end package body SUBPROG_PCK;

