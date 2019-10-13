library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lab4processor is

  port (
    ACLK              : out   STD_LOGIC;
    ARESET            : out   STD_LOGIC_VECTOR(0 downto 0);
    DDR_addr          : inout STD_LOGIC_VECTOR (14 downto 0);
    DDR_ba            : inout STD_LOGIC_VECTOR (2 downto 0);
    DDR_cas_n         : inout STD_LOGIC;
    DDR_ck_n          : inout STD_LOGIC;
    DDR_ck_p          : inout STD_LOGIC;
    DDR_cke           : inout STD_LOGIC;
    DDR_cs_n          : inout STD_LOGIC;
    DDR_dm            : inout STD_LOGIC_VECTOR (3 downto 0);
    DDR_dq            : inout STD_LOGIC_VECTOR (31 downto 0);
    DDR_dqs_n         : inout STD_LOGIC_VECTOR (3 downto 0);
    DDR_dqs_p         : inout STD_LOGIC_VECTOR (3 downto 0);
    DDR_odt           : inout STD_LOGIC;
    DDR_ras_n         : inout STD_LOGIC;
    DDR_reset_n       : inout STD_LOGIC;
    DDR_we_n          : inout STD_LOGIC;
    FIXED_IO_ddr_vrn  : inout STD_LOGIC;
    FIXED_IO_ddr_vrp  : inout STD_LOGIC;
    FIXED_IO_mio      : inout STD_LOGIC_VECTOR (53 downto 0);
    FIXED_IO_ps_clk   : inout STD_LOGIC;
    FIXED_IO_ps_porb  : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    M00_AXI_araddr    : out   STD_LOGIC_VECTOR (31 downto 0);
    M00_AXI_arprot    : out   STD_LOGIC_VECTOR (2 downto 0);
    M00_AXI_arready   : in    STD_LOGIC;
    M00_AXI_arvalid   : out   STD_LOGIC;
    M00_AXI_awaddr    : out   STD_LOGIC_VECTOR (31 downto 0);
    M00_AXI_awprot    : out   STD_LOGIC_VECTOR (2 downto 0);
    M00_AXI_awready   : in    STD_LOGIC;
    M00_AXI_awvalid   : out   STD_LOGIC;
    M00_AXI_bready    : out   STD_LOGIC;
    M00_AXI_bresp     : in    STD_LOGIC_VECTOR (1 downto 0);
    M00_AXI_bvalid    : in    STD_LOGIC;
    M00_AXI_rdata     : in    STD_LOGIC_VECTOR (31 downto 0);
    M00_AXI_rready    : out   STD_LOGIC;
    M00_AXI_rresp     : in    STD_LOGIC_VECTOR (1 downto 0);
    M00_AXI_rvalid    : in    STD_LOGIC;
    M00_AXI_wdata     : out   STD_LOGIC_VECTOR (31 downto 0);
    M00_AXI_wready    : in    STD_LOGIC;
    M00_AXI_wstrb     : out   STD_LOGIC_VECTOR (3 downto 0);
    M00_AXI_wvalid    : out   STD_LOGIC);

end lab4processor;
