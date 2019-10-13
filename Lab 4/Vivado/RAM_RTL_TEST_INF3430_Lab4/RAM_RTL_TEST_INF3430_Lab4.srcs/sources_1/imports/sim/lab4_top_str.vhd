
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.lab4_pck.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

architecture str of lab4_top is

-- START ADDING COMPONENT

-- COMPONENT PS + AXI INTERCONNECT
  component lab4processor_wrapper is
    port (
      ACLK              : out   STD_LOGIC;
      ARESET            : out   STD_LOGIC_VECTOR (0 to 0);
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
  end component lab4processor_wrapper;



-- COMPONENT AXI4PIFB (AXI INTERCONNECT TO PIF)
component axi4pifb
    generic (
      PIF_DATA_LENGTH    : integer;
      PIF_ADDR_LENGTH    : integer;
      C_S_AXI_DATA_WIDTH : integer;
      C_S_AXI_ADDR_WIDTH : integer);
    port (
      s_axi_aclk        : in  std_logic;
      s_axi_aresetn     : in  std_logic;
      s_axi_awaddr      : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
      s_axi_awprot      : in  std_logic_vector(2 downto 0);
      s_axi_awvalid     : in  std_logic;
      s_axi_awready     : out std_logic;
      s_axi_wdata       : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
      s_axi_wstrb       : in  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
      s_axi_wvalid      : in  std_logic;
      s_axi_wready      : out std_logic;
      s_axi_bresp       : out std_logic_vector(1 downto 0);
      s_axi_bvalid      : out std_logic;
      s_axi_bready      : in  std_logic;
      s_axi_araddr      : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
      s_axi_arprot      : in  std_logic_vector(2 downto 0);
      s_axi_arvalid     : in  std_logic;
      s_axi_arready     : out std_logic;
      s_axi_rdata       : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
      s_axi_rresp       : out std_logic_vector(1 downto 0);
      s_axi_rvalid      : out std_logic;
      s_axi_rready      : in  std_logic;
      pif_clk           : out std_logic;
      pif_rst           : out std_logic;
      pif_regcs         : out std_logic_vector(31 downto 0);
      pif_memcs         : out std_logic_vector(31 downto 0);
      pif_addr          : out std_logic_vector(PIF_ADDR_LENGTH-1 downto 0);
      pif_wdata         : out std_logic_vector(PIF_DATA_LENGTH-1 downto 0);
      pif_re            : out std_logic_vector(0 downto 0);
      pif_we            : out std_logic_vector(0 downto 0);
      pif_be            : out std_logic_vector((PIF_DATA_LENGTH/8)-1 downto 0);
      rdata_lab4reg2pif : in  std_logic_vector(PIF_DATA_LENGTH-1 downto 0);
      mdata_lab4ram2pif : in std_logic_vector(PIF_DATA_LENGTH-1 downto 0);
      ack_lab4reg2pif   : in  std_logic);
  end component;

  
  
-- COMPONENT REGISTER
component lab4_reg is
    generic (
        -- Width of PIF data bus
        PIF_DATA_LENGTH	: integer := PIF_DATA_LENGTH;
        -- Width of PIF address bus
        PIF_ADDR_LENGTH	: integer := PIF_ADDRESS_LENGTH
    );
    port (
        -- Add ports here:
          -- TBD.
          setpoint       : out std_logic_vector(7 downto 0);
        -- Add ports ends
        
        -- Do not modify the ports beyond this line   
        -- Clock Signal
        pif_clk          : in std_logic;
        -- Reset Signal. This signal is active HIGH
        pif_rst          : in std_logic;
        -- Register chip select
        pif_regcs        : in std_logic; 
        -- Write address
        pif_addr         : in std_logic_vector(PIF_ADDR_LENGTH-1 downto 0); 
        -- Write data 
        pif_wdata        : in std_logic_vector(PIF_DATA_LENGTH-1 downto 0);
        -- Read enable strobe
        pif_re	         : in std_logic_vector(0 downto 0);
        -- Write enable strobe
        pif_we	         : in std_logic_vector(0 downto 0);
        -- Write strobes. This signal indicates which byte lanes hold
        --   valid data. There is one write strobe bit for each eight
        --   bits of the write data bus.    
        pif_be	         : in std_logic_vector((PIF_DATA_LENGTH/8)-1 downto 0);
        -- Read data
        rdata_2pif	     : out std_logic_vector(PIF_DATA_LENGTH-1 downto 0);
        -- Register read and write access acknowledge
        ack_2pif         : out std_logic
    ); 
end component;

-- COMPONENT MOTOR CONTROLLER
component pos_seg7_ctrl is
    port (
        -- System Clock and Reset
        arst         : in  std_logic;       -- Reset
        sync_rst     : in  std_logic;       -- Synchronous reset 
        refclk       : in  std_logic;       -- Clock
        sp           : in  std_logic_vector(7 downto 0);  -- Set Point
        a            : in  std_logic;       -- From position sensor
        b            : in  std_logic;       -- From position sensor
        force_cw     : in  std_logic;       -- Force motor clock wise motion
        force_ccw    : in  std_logic;  -- Force motor counter clock wise motion
        motor_cw     : out std_logic;       -- Motor clock wise motion
        motor_ccw    : out std_logic;       -- Motor counter clock wise motion
        -- Interface to seven segments
        abcdefgdec_n : out std_logic_vector(7 downto 0);
        a_n          : out std_logic_vector(3 downto 0)
    );
end component;

component ram_lab4
  port (
    clka  : in  STD_LOGIC;
    rsta  : in  STD_LOGIC;
    ena   : in  STD_LOGIC;
    wea   : in  STD_LOGIC_VECTOR (3 downto 0);
    addra : in  STD_LOGIC_VECTOR (9 downto 0);
    dina  : in  STD_LOGIC_VECTOR (31 downto 0);
    douta : out STD_LOGIC_VECTOR (31 downto 0));
end component;

-- SIGNALS

signal aclk : std_logic;
signal pifb_axi_aresetn  : std_logic_vector(0 downto 0);
signal pifb_axi_awaddr   : std_logic_vector(31 downto 0);
signal pifb_axi_awprot   : std_logic_vector(2 downto 0);
signal pifb_axi_awvalid  : std_logic;
signal pifb_axi_awready  : std_logic;
signal pifb_axi_wdata    : std_logic_vector(31 downto 0);
signal pifb_axi_wstrb    : std_logic_vector(3 downto 0);
signal pifb_axi_wvalid   : std_logic;
signal pifb_axi_wready   : std_logic;
signal pifb_axi_bresp    : std_logic_vector(1 downto 0);
signal pifb_axi_bvalid   : std_logic;
signal pifb_axi_bready   : std_logic;
signal pifb_axi_araddr   : std_logic_vector(31 downto 0);
signal pifb_axi_arprot   : std_logic_vector(2 downto 0);
signal pifb_axi_arvalid  : std_logic;
signal pifb_axi_arready  : std_logic;
signal pifb_axi_rdata    : std_logic_vector(31 downto 0);
signal pifb_axi_rresp    : std_logic_vector(1 downto 0);
signal pifb_axi_rvalid   : std_logic;
signal pifb_axi_rready   : std_logic;

signal rdata_lab4reg2pif : std_logic_vector(31 downto 0);
signal mdata_lab4ram2pif : std_logic_vector(31 downto 0);
signal ack_lab4reg2pif   : std_logic;

signal pif_memcs         : std_logic_vector(31 downto 0);
signal pif_regcs         : std_logic_vector(31 downto 0);
signal pif_addr          : std_logic_vector(31 downto 0);
signal pif_wdata         : std_logic_vector(PIF_DATA_LENGTH-1 downto 0);
signal pif_re            : std_logic_vector(0 downto 0);
signal pif_we            : std_logic_vector(0 downto 0);
signal pif_be            : std_logic_vector((PIF_DATA_LENGTH/8)-1 downto 0);
signal pif_clk           : std_logic;
signal pif_rst           : std_logic;

signal rst_mclk_s1       : std_logic;
signal rst_mclk_s2       : std_logic;

signal setpoint          : std_logic_vector(7 downto 0);
signal sw_setpoint       : std_logic_vector(7 downto 0);
signal ps_setpoint       : std_logic_vector(7 downto 0);
signal setpoint_select   : std_logic;

-- END SIGNALS

begin

  -- PORT MAP PS + AXI INTERCONNECT

  lab4processor_0: lab4processor_wrapper
    port map (
      ACLK              => aclk,
      ARESET            => pifb_axi_aresetn,
      DDR_addr          => DDR_addr,
      DDR_ba            => DDR_ba,
      DDR_cas_n         => DDR_cas_n,
      DDR_ck_n          => DDR_ck_n,
      DDR_ck_p          => DDR_ck_p,
      DDR_cke           => DDR_cke,
      DDR_cs_n          => DDR_cs_n,
      DDR_dm            => DDR_dm,
      DDR_dq            => DDR_dq,
      DDR_dqs_n         => DDR_dqs_n,
      DDR_dqs_p         => DDR_dqs_p,
      DDR_odt           => DDR_odt,
      DDR_ras_n         => DDR_ras_n,
      DDR_reset_n       => DDR_reset_n,
      DDR_we_n          => DDR_we_n,
      FIXED_IO_ddr_vrn  => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp  => FIXED_IO_ddr_vrp,
      FIXED_IO_mio      => FIXED_IO_mio,
      FIXED_IO_ps_clk   => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb  => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      M00_AXI_araddr    => pifb_axi_araddr,
      M00_AXI_arprot    => pifb_axi_arprot,
      M00_AXI_arready   => pifb_axi_arready,
      M00_AXI_arvalid   => pifb_axi_arvalid,
      M00_AXI_awaddr    => pifb_axi_awaddr,
      M00_AXI_awprot    => pifb_axi_awprot,
      M00_AXI_awready   => pifb_axi_awready,
      M00_AXI_awvalid   => pifb_axi_awvalid,
      M00_AXI_bready    => pifb_axi_bready,
      M00_AXI_bresp     => pifb_axi_bresp,
      M00_AXI_bvalid    => pifb_axi_bvalid,
      M00_AXI_rdata     => pifb_axi_rdata,
      M00_AXI_rready    => pifb_axi_rready,
      M00_AXI_rresp     => pifb_axi_rresp,
      M00_AXI_rvalid    => pifb_axi_rvalid,
      M00_AXI_wdata     => pifb_axi_wdata,
      M00_AXI_wready    => pifb_axi_wready,
      M00_AXI_wstrb     => pifb_axi_wstrb,
      M00_AXI_wvalid    => pifb_axi_wvalid
    );

  -- PORT MAP AXI4PIFB
  axi4pifb_0: axi4pifb
    generic map (
      PIF_DATA_LENGTH    => PIF_DATA_LENGTH,
      PIF_ADDR_LENGTH    => PIF_ADDRESS_LENGTH,
      C_S_AXI_DATA_WIDTH => PIF_DATA_LENGTH,
      C_S_AXI_ADDR_WIDTH => PIF_ADDRESS_LENGTH)
    port map (
      s_axi_aclk        => aclk,
      s_axi_aresetn     => pifb_axi_aresetn(0),
      s_axi_awaddr      => pifb_axi_awaddr,
      s_axi_awprot      => pifb_axi_awprot,
      s_axi_awvalid     => pifb_axi_awvalid,
      s_axi_awready     => pifb_axi_awready,
      s_axi_wdata       => pifb_axi_wdata,
      s_axi_wstrb       => pifb_axi_wstrb,
      s_axi_wvalid      => pifb_axi_wvalid,
      s_axi_wready      => pifb_axi_wready,
      s_axi_bresp       => pifb_axi_bresp,
      s_axi_bvalid      => pifb_axi_bvalid,
      s_axi_bready      => pifb_axi_bready,
      s_axi_araddr      => pifb_axi_araddr,
      s_axi_arprot      => pifb_axi_arprot,
      s_axi_arvalid     => pifb_axi_arvalid,
      s_axi_arready     => pifb_axi_arready,
      s_axi_rdata       => pifb_axi_rdata,
      s_axi_rresp       => pifb_axi_rresp,
      s_axi_rvalid      => pifb_axi_rvalid,
      s_axi_rready      => pifb_axi_rready,
      pif_clk           => pif_clk,
      pif_rst           => pif_rst,
      pif_regcs         => pif_regcs,
      pif_memcs         => pif_memcs,
      pif_addr          => pif_addr,
      pif_wdata         => pif_wdata,
      pif_re            => pif_re,
      pif_we            => pif_we,
      pif_be            => pif_be,
      rdata_lab4reg2pif => rdata_lab4reg2pif,
      mdata_lab4ram2pif => mdata_lab4ram2pif,
      ack_lab4reg2pif   => ack_lab4reg2pif
    );


  -- A better solution may be to move the CRU module from the
  --   pos_seg7_ctrl module up to this level and use the reset
  --   signal from the CRU module, but then the pos_seq7_ctrl
  --   module will not be reused without changes ......
  P_LAB4_REG_RST_SYNCH :
  process(arst, mclk)
  begin    
    if arst = '1' then
      rst_mclk_s1 <= '1';
      rst_mclk_s2 <= '1';
    elsif rising_edge(mclk) then
      rst_mclk_s1 <= '0';
      rst_mclk_s2 <= rst_mclk_s1;
    end if;
  end process P_LAB4_REG_RST_SYNCH;
  
    
  lab4_reg_0: lab4_reg
    generic map (
        PIF_DATA_LENGTH => PIF_DATA_LENGTH,
        PIF_ADDR_LENGTH => PIF_ADDRESS_LENGTH)
    port map (
        setpoint    => ps_setpoint,
        pif_clk     => mclk,
        pif_rst     => rst_mclk_s2,
        pif_regcs   => pif_regcs(0),      
        pif_addr    => pif_addr,          
        pif_wdata   => pif_wdata,         
        pif_re      => pif_re,            
        pif_we      => pif_we,            
        pif_be      => pif_be,            
        rdata_2pif  => rdata_lab4reg2pif, 
        ack_2pif    => ack_lab4reg2pif
    );

  -- Instantiation of ram module
  ram_lab4_0: ram_lab4
    port map (
      clka  => pif_clk,
      rsta  => pif_rst,
      ena   => pif_memcs(0),
      wea   => pif_be,
      addra => pif_addr(11 downto 2), -- Word adressing; removing (2 lsb) byte address bits.
      dina  => pif_wdata,
      douta => mdata_lab4ram2pif);

  pos_seq7_ctrl_0: pos_seg7_ctrl
    port map (
        arst => arst,
        sync_rst => sync_rst,
        refclk => mclk,
        sp => setpoint,
        a => a,
        b => b,
        force_cw => force_cw,
        force_ccw => force_ccw,
        motor_cw => motor_cw,
        motor_ccw => motor_ccw,
        abcdefgdec_n => abcdefgdec_n,
        a_n => a_n
    );

  -- Concurrent statements

  -- Select processor (i.e PS) setpoint if external switch bit 7
  --   is equal '1' (i.e. (sw(7)='1') else use external switch
  --   bit 6 downto 0 with unused bit 7 set to '0'.
  setpoint_select <= sw(7);
  sw_setpoint <= '0' & sw(6 downto 0);
  setpoint <= ps_setpoint when setpoint_select='1' else sw_setpoint;

end str;
