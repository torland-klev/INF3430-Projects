
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_clock is
	-- empty;
end tb_clock;

architecture beh1 of tb_clock is

	component clock is
		port
		(
		CLK            : in std_logic;
		Stop           : in std_logic;
		Reset          : in std_logic;
		Start          : in std_logic;
		D3, D2, D1, D0 : out std_logic_vector(3 downto 0)
		);
	end component clock;
	
	signal CLK            : std_logic := '0';
	signal Stop           : std_logic := '0';
	signal Reset          : std_logic := '0';
	signal Start          : std_logic := '0';
	signal D3, D2, D1, D0 : std_logic_vector(3 downto 0) := "ZZZZ";
	
	begin
		UUT: entity work.clock
			port map (CLK => CLK,
				Stop => Stop,
				Reset => Reset,
				Start => Start,
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
	
	-- Change the time before simulation
	process begin
		Start <= '0', '1' after 2000000000 ns; -- 2 sekunder
		wait for 15000000000 ns; -- teller i 15 sek
		Stop <= '1', '0' after 2000000000 ns; -- pause i 2 sek
		Start <= '1';
		wait for 5000000000 ns;
		Reset <= '1', '0' after 2000000000 ns;
		wait;
	end process;
end beh1;