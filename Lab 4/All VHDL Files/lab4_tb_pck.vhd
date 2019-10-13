library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

library work;
use work.base_pck.all;

package lab4_tb_pck is

  type transaction_size is (BYTE, HALFWORD, SINGLE, DOUBLE);

  -- clk timing
  constant T_100M         : time;
  constant T_OFFSET_100M  : time;
  constant T_HIGH_100M    : time;

  -- AXI4lite clk timing
  constant T_125M          : time;
  constant T_OFFSET_125M   : time;
  constant T_HIGH_125M     : time;
    
  procedure Tcycle (n : natural);

  procedure Reset (
    signal   rst_n : out std_logic;
    file     log   :     text;
    constant cycle : in  integer
  );
     
  procedure AXI4LiteWrite (
    constant tsize            : in  transaction_size;
    constant addr             : in  std_logic_vector(31 downto 0);
    constant data             : in  std_logic_vector;

    -- AXI4Lite clock
    signal  s00_axi_aclk      : in  std_logic;

    -- Write Address Channel
    signal  s00_axi_awaddr    : out std_logic_vector(31 downto 0);
    signal  s00_axi_awprot    : out std_logic_vector(2 downto 0);
    signal  s00_axi_awvalid   : out std_logic;
    signal  s00_axi_awready   : in  std_logic;

    -- Write Data Channel
    signal  s00_axi_wdata     : out std_logic_vector(31 downto 0);
    signal  s00_axi_wstrb     : out std_logic_vector(3 downto 0);
    signal  s00_axi_wvalid    : out std_logic;
    signal  s00_axi_wready    : in  std_logic;

    -- Write Respons Channel
    signal  s00_axi_bresp     : in  std_logic_vector(1 downto 0);
    signal  s00_axi_bvalid    : in  std_logic;
    signal  s00_axi_bready    : out std_logic;
    
    file     log              :       text;
    constant cycle            : in    natural;
    variable error_found      : out   boolean;
    signal   error_no         : inout natural
  );
  
  procedure AXI4LiteRead (
    constant tsize            : in  transaction_size;
    constant addr             : in  std_logic_vector(31 downto 0);
    variable data             : out std_logic_vector;

    -- AXI4Lite clock
    signal  s00_axi_aclk      : in  std_logic;

    -- Read Address Channel
    signal  s00_axi_araddr    : out std_logic_vector(31 downto 0);
    signal  s00_axi_arprot    : out std_logic_vector(2 downto 0);
    signal  s00_axi_arvalid   : out std_logic;
    signal  s00_axi_arready   : in  std_logic;

    -- Read Data Channel
    signal  s00_axi_rdata     : in  std_logic_vector(31 downto 0);
    signal  s00_axi_rresp     : in  std_logic_vector(1 downto 0);
    signal  s00_axi_rvalid    : in  std_logic;
    signal  s00_axi_rready    : out std_logic;
    
    file     log              :       text;
    constant cycle            : in    natural;
    variable error_found      : out   boolean;
    variable error_no         : inout natural
  );

  procedure AXI4LiteCheck (
    constant tsize            : in  transaction_size;
    constant addr             : in  std_logic_vector(31 downto 0);
    variable data             : in std_logic_vector;

    -- AXI4Lite clock
    signal  s00_axi_aclk      : in  std_logic;

    -- Read Address Channel
    signal  s00_axi_araddr    : out std_logic_vector(31 downto 0);
    signal  s00_axi_arprot    : out std_logic_vector(2 downto 0);
    signal  s00_axi_arvalid   : out std_logic;
    signal  s00_axi_arready   : in  std_logic;

    -- Read Data Channel
    signal  s00_axi_rdata     : in  std_logic_vector(31 downto 0);
    signal  s00_axi_rresp     : in  std_logic_vector(1 downto 0);
    signal  s00_axi_rvalid    : in  std_logic;
    signal  s00_axi_rready    : out std_logic;
  
    file     log              :       text;
    constant cycle            : in    natural;
    variable error_found      : out   boolean;
    signal   error_no         : inout natural
  );
  
end package lab4_tb_pck;
