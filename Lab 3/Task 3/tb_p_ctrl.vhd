-- task 3

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_p_ctrl is
  -- empty;
end tb_p_ctrl;

architecture rtl1 of tb_p_ctrl is

component p_ctrl is
    port
	  (
		rst       : in  std_logic;           -- Reset
		clk       : in  std_logic;           -- Clock
		sp        : in  signed(7 downto 0);  -- Set Point
		pos       : in  signed(7 downto 0);  -- Measured position
		motor_cw  : out std_logic;           --Motor Clock Wise direction
		motor_ccw : out std_logic            --Motor Counter Clock Wise direction
	  );
  end component p_ctrl;
    
    signal rst       :   std_logic;
    signal clk       :   std_logic;
    signal sp        :   signed(7 downto 0) := "00000000";
    signal pos       :   signed(7 downto 0) := "00000000";
    signal motor_cw  :   std_logic := '0';
    signal motor_ccw :   std_logic := '0';
  
  begin

  UUT: entity work.p_ctrl(rtl1)
    port map (rst => rst,
			clk => clk,
			sp   => sp,
			pos => pos,
			motor_cw => motor_cw,    
			motor_ccw => motor_ccw);
    
  P_CLK_0: process
  begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;    
  end process P_CLK_0;
  
  process begin
	rst  <= '1', '0' after 100 ns;
	wait for 40 ns;
	sp <= "00001010";
	pos <= "00000000";
	wait for 100 ns;
	pos <= "00001100";
	wait for 100 ns;
	pos <= "00001010";
	wait for 100 ns;
	rst <= '1';
	wait for 100 ns;
	wait;
  end process;
  
end rtl1;
