
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_regs is
	-- empty;
end tb_regs;

architecture beh1 of tb_regs is

	component regs is
		port
		(
		CLK          : in std_logic;
		Load         : in std_logic;
		Reset        : in std_logic;
		SEL          : in std_logic_vector(1 downto 0);
		INP          : in std_logic_vector(3 downto 0);
		abcdefgdec_n : out std_logic_vector(7 downto 0);
		a_n          : out std_logic_vector(3 downto 0)
		);
	end component regs;
	
	signal CLK          : std_logic := '0';
	signal Load         : std_logic := '0';
	signal Reset        : std_logic := '0';
	signal SEL          : std_logic_vector(1 downto 0) := "00";
	signal INP          : std_logic_vector(3 downto 0) := "0000";
	signal abcdefgdec_n : std_logic_vector(7 downto 0);
	signal a_n          : std_logic_vector(3 downto 0);
	
	begin
		UUT: entity work.regs
			port map (CLK => CLK,
				Load => Load,
				Reset => Reset,
				SEL => SEL,
				INP => INP,
				abcdefgdec_n => abcdefgdec_n,
				a_n => a_n );
				
	P_CLK_0: process
	begin
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
	end process P_CLK_0;
	
	process begin
		Load <= '0', '1' after 50 ns;
		SEL <= "00";
		INP <= "0011";
		wait for 70 ns;
		SEL <= "01";
		INP <= "1100";
		wait for 40 ns;
		SEL <= "10";
		INP <= "0010";
		wait for 40 ns;
		SEL <= "11";
		INP <= "1010";
		wait for 40 ns;
		Reset <= '1';
		SEL <= "10";
		INP <= "1001";
		wait for 40 ns;
		Reset <= '0';
		wait;
	end process;
end beh1;