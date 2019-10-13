library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pos_meas is
  -- empty;
end tb_pos_meas;

architecture rtl1 of tb_pos_meas is

component pos_meas is
    port
	  (
		rst      : in  std_logic;           -- Reset
		clk      : in  std_logic;           -- Clock
		sync_rst : in  std_logic;           -- Sync reset
		a        : in  std_logic;           -- From position sensor
		b        : in  std_logic;           -- From position sensor
		pos      : out signed(7 downto 0)   -- Measured position
	  );
  end component pos_meas;
    
	signal rst      :   std_logic;
    signal clk      :   std_logic;
    signal sync_rst :   std_logic := '0';
    signal a        :   std_logic := '0';
    signal b        :   std_logic := '0';
    signal pos      :   signed(7 downto 0) := "00000000";
  
  begin

  UUT: entity work.pos_meas(rtl1)
    port map (rst => rst,
			clk => clk,
			sync_rst   => sync_rst,   
            a => a,    
			b => b,
			pos => pos);    
    
  P_CLK_0: process
  begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;    
  end process P_CLK_0;
  
  process begin
	rst  <= '1', '0' after 100 ns;
	wait for 100 ns;
	a <= '0';
	b <= '0';
	wait for 20 ns;
	b <= '1';   -- skal ikke skje noe
	wait for 20 ns;
	a <= '1';
	wait for 20 ns;
	a <= '0';	-- count down, already at zero
	wait for 20 ns;
	a <= '1';
	b <= '0';
	wait for 20 ns;
	a <= '0';
	wait for 20 ns;
	a <= '1';
	wait for 20 ns;
	a <= '0';
	wait for 20 ns;
	a <= '1';
	wait for 20 ns;
	a <= '0';
	wait for 20 ns;
	a <= '1';
	b <= '1';
	wait for 20 ns;
	a <= '1';
	wait for 20 ns;
	a <= '0';
	wait for 20 ns;
	a <= '1';
	wait for 20 ns;
	a <= '0';	
	wait;
  end process;
  
end rtl1;
