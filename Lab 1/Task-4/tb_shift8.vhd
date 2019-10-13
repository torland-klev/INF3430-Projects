library ieee;
use ieee.std_logic_1164.all;

entity tb_shift8 is
  -- empty;
end tb_shift8;

architecture shift of tb_shift8 is

  component shift8
    port (
      clk    : in  std_logic;
      sin    : in  std_logic;
      sout   : out std_logic_vector(7 downto 0));
  end component;
  
  signal mclk    : std_logic;
  signal indata  : std_logic;
  signal outdata : std_logic_vector(7 downto 0);
  
begin

  UUT : shift8
    port map (mclk, indata, outdata);
  
  P_CLK_0: process
  begin
    mclk <= '0';
    wait for 10 ns;
    mclk <= '1';
    wait for 10 ns;    
  end process P_CLK_0;

  indata  <= '1', '0' after 40 ns, '1' after 80 ns, '0' after 120 ns, '1' after 140 ns, '0' after 200 ns;

end shift;
