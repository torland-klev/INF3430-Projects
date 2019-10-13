----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Olivier FAVIERES
-- 
-- Create Date: 07/04/2017 12:04:51 PM
-- Module Name: lab4_top - Structural
-- Tool Versions: 
-- Description: 
-- 
-- Revision 0.02 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.lab4_pck.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab4_top is
    port (
          arst : in std_logic;
          sync_rst : in std_logic;
          mclk : in std_logic;
          a : in std_logic;
          b : in std_logic;
          force_cw : in std_logic;
          force_ccw : in std_logic;
          motor_cw : out std_logic;
          motor_ccw : out std_logic;
          a_n : out std_logic_vector(3 downto 0)    ;     
          abcdefgdec_n : out std_logic_vector(7 downto 0);
          sw : in std_logic_vector(7 downto 0);
          
          DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
          DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
          DDR_cas_n : inout STD_LOGIC;
          DDR_ck_n : inout STD_LOGIC;
          DDR_ck_p : inout STD_LOGIC;
          DDR_cke : inout STD_LOGIC;
          DDR_cs_n : inout STD_LOGIC;
          DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
          DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
          DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
          DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
          DDR_odt : inout STD_LOGIC;
          DDR_ras_n : inout STD_LOGIC;
          DDR_reset_n : inout STD_LOGIC;
          DDR_we_n : inout STD_LOGIC;
          FIXED_IO_ddr_vrn : inout STD_LOGIC;
          FIXED_IO_ddr_vrp : inout STD_LOGIC;
          FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
          FIXED_IO_ps_clk : inout STD_LOGIC;
          FIXED_IO_ps_porb : inout STD_LOGIC;
          FIXED_IO_ps_srstb : inout STD_LOGIC);
end lab4_top;
