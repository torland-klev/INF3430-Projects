
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_seg7ctrl is
  -- empty;
end tb_seg7ctrl;

architecture beh1 of tb_seg7ctrl is

  component seg7ctrl is
    port
	  (
		mclk          : in std_logic;
		reset         : in std_logic;
		a_n           : out  std_logic_vector(3 downto 0);
		abcdefgdec_n  : out  std_logic_vector(7 downto 0);
		d3            : in std_logic_vector(3 downto 0);
		d2            : in std_logic_vector(3 downto 0);
		d1            : in std_logic_vector(3 downto 0);
		d0            : in std_logic_vector(3 downto 0);
		dec           : in std_logic_vector(3 downto 0)
	  );
  end component seg7ctrl;
    
  signal mclk         : std_logic;
  signal reset        : std_logic;
  signal a_n          : std_logic_vector(3 downto 0);
  signal abcdefgdec_n : std_logic_vector(7 downto 0);
  signal d3 		  : std_logic_vector(3 downto 0);
  signal d2           : std_logic_vector(3 downto 0);
  signal d1           : std_logic_vector(3 downto 0);
  signal d0           : std_logic_vector(3 downto 0);
  signal dec          : std_logic_vector(3 downto 0) := "0000";
  
begin

  UUT: entity work.seg7ctrl
    port map (mclk => mclk,
			reset => reset,
			a_n   => a_n,   
            abcdefgdec_n => abcdefgdec_n,    
			d3 => d3,
			d2 => d2,
			d1 => d1,
			d0 => d0,
			dec => dec );    
    
  P_CLK_0: process
  begin
    mclk <= '0';
    wait for 10 ns;
    mclk <= '1';
    wait for 10 ns;    
  end process P_CLK_0;
  
  process begin
	reset  <= '1', '0' after 100 ns;
	d0 <= "1011";
	d1 <= "1010";
	d2 <= "0011";
	d3 <= "1100";
	wait for 300 ns;
	dec <= "1111";
	d0 <= "1100";
	d1 <= "1011";
	d2 <= "0100";
	d3 <= "1101";
  wait;
  end process;
  
end beh1;
