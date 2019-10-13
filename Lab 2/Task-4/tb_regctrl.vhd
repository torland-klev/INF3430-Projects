
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_regctrl is
	-- empty;
end tb_regctrl;

architecture beh1 of tb_regctrl is

	component regctrl is
		port
		(
		CLK    : in std_logic;
		Load   : in std_logic;
		Reset  : in std_logic;
		Sel    : in std_logic_vector(1 downto 0);
		Input  : in std_logic_vector(3 downto 0);
		D3     : out std_logic_vector(3 downto 0);
		D2     : out std_logic_vector(3 downto 0);
		D1     : out std_logic_vector(3 downto 0);
		D0     : out std_logic_vector(3 downto 0)
		);
	end component regctrl;
	
	signal CLK   : std_logic := '0';
	signal Load  : std_logic := '0';
	signal Reset : std_logic := '0';
	signal Sel   : std_logic_vector(1 downto 0) := "00";
	signal Input : std_logic_vector(3 downto 0) := "0000";
	signal D3    : std_logic_vector(3 downto 0);
	signal D2    : std_logic_vector(3 downto 0);
	signal D1    : std_logic_vector(3 downto 0);
	signal D0    : std_logic_vector(3 downto 0);
	
begin

	UUT: entity work.regctrl
		port map (CLK => CLK,
				Load => Load,
				Reset => Reset,
				Sel => Sel,
				Input => Input,
				D3 => D3,
				D2 => D2,
				D1 => D1,
				D0 => D0 );
				
	P_CLK_0: process
	begin
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
	end process P_CLK_0;
	
	process begin
		Load <= '0', '1' after 50 ns;
		Sel <= "00";
		Input <= "0011";
		wait for 70 ns;
		Sel <= "01";
		Input <= "1100";
		wait for 40 ns;
		Sel <= "10";
		Input <= "0010";
		wait for 40 ns;
		Sel <= "11";
		Input <= "1010";
		wait for 40 ns;
		Sel <= "10";
		Input <= "1001";
		wait for 10 ns;
		Reset <= '1';
		wait for 40 ns;
		Reset <= '0';
	  wait;
	end process;
end beh1;