library ieee;
use ieee.std_logic_1164.all;

library work;
use work.all;
use work.base_pck.all;
use work.lab4_tb_pck.all;

architecture dmy of lab4processor is
  signal clk_125m          : std_logic;        -- AXI4 clock 125 MHz
  signal cycle_no          : natural   := 0;   -- cycle count 40 MHz. 
  signal run               : std_logic := '1'; -- Run forever 
begin

    ACLK              <= clk_125m;
    DDR_addr          <= (others => '0');
    DDR_ba            <= (others => '0');
    DDR_cas_n         <= '1';
    DDR_ck_n          <= '1';
    DDR_ck_p          <= '0';
    DDR_cke           <= '0';
    DDR_cs_n          <= '1';
    DDR_dm            <= (others => '0');
    DDR_dq            <= (others => '0');
    DDR_dqs_n         <= (others => '1');
    DDR_dqs_p         <= (others => '0');
    DDR_odt           <= '0';
    DDR_ras_n         <= '1';
    DDR_reset_n       <= '1';
    DDR_we_n          <= '1';
    FIXED_IO_ddr_vrn  <= '1';
    FIXED_IO_ddr_vrp  <= '0';
    FIXED_IO_mio      <= (others => '0');
    FIXED_IO_ps_clk   <= '0';
    FIXED_IO_ps_porb  <= '0';
    FIXED_IO_ps_srstb <= '0';
    
    -- AXI4 clock
    CLK_GEN_125M: clk_gen(
      clk      => clk_125m,
      cycle_no => cycle_no,
      run      => run,
      period   => T_125M,
      high     => T_HIGH_125M,
      offset   => T_OFFSET_125M
    );  

end dmy;
