use std.textio.all;
use std.env.all; -- Defines finish(0) function etc. 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library std_developerskit;
use std_developerskit.std_iopak.all;

library modelsim_lib;
use modelsim_lib.util.all;

library work;
use work.all;
use work.base_pck.all;
use work.lab4_tb_pck.all;

library work;
use work.lab4_pck.all;

architecture beh of tb_lab4 is
    
  -- Logfile Declarations
  file tb_lab4_log : text open write_mode is "tb_lab4.log";

  component motor is
    generic (
      phase90 : time);
    port (
      run       : in  std_logic;
      motor_cw  : in  std_logic;
      motor_ccw : in  std_logic;
      a         : out std_logic;
      b         : out std_logic);
  end component motor;
  
  component lab4_top
    port (
      arst              : in    std_logic;
      sync_rst          : in    std_logic;
      mclk              : in    std_logic;
      a                 : in    std_logic;
      b                 : in    std_logic;
      force_cw          : in    std_logic;
      force_ccw         : in    std_logic;
      motor_cw          : out   std_logic;
      motor_ccw         : out   std_logic;
      a_n               : out   std_logic_vector(3 downto 0);
      abcdefgdec_n      : out   std_logic_vector(7 downto 0);
      sw                : in    std_logic_vector(7 downto 0);
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
      FIXED_IO_ps_srstb : inout STD_LOGIC);
  end component;

  signal mclk              : std_logic;        -- Master testbench clock TBD MHz
  signal clk_125m          : std_logic;        -- AXI4 clock 125 MHz
  signal s_axi_aclk        : std_logic;        -- AXI4 clock
  signal clk_125m_cycle_no : natural   := 0;   -- cycle count 125MHz. 
  signal cycle_no          : natural   := 0;   -- cycle count 40 MHz. 
  signal error_no          : natural   := 0;   -- Error count 

  signal run               : std_logic := '1'; -- Setting to '0' will terminate simulation

  signal arst              : std_logic;
  signal sync_rst          : std_logic;
  signal a                 : std_logic;
  signal b                 : std_logic;
  signal force_cw          : std_logic;
  signal force_ccw         : std_logic;
  signal motor_cw          : std_logic;
  signal motor_ccw         : std_logic;
  signal a_n               : std_logic_vector(3 downto 0);
  signal abcdefgdec_n      : std_logic_vector(7 downto 0);
  signal sw                : std_logic_vector(7 downto 0);
  signal DDR_addr          : STD_LOGIC_VECTOR (14 downto 0);
  signal DDR_ba            : STD_LOGIC_VECTOR (2 downto 0);
  signal DDR_cas_n         : STD_LOGIC;
  signal DDR_ck_n          : STD_LOGIC;
  signal DDR_ck_p          : STD_LOGIC;
  signal DDR_cke           : STD_LOGIC;
  signal DDR_cs_n          : STD_LOGIC;
  signal DDR_dm            : STD_LOGIC_VECTOR (3 downto 0);
  signal DDR_dq            : STD_LOGIC_VECTOR (31 downto 0);
  signal DDR_dqs_n         : STD_LOGIC_VECTOR (3 downto 0);
  signal DDR_dqs_p         : STD_LOGIC_VECTOR (3 downto 0);
  signal DDR_odt           : STD_LOGIC;
  signal DDR_ras_n         : STD_LOGIC;
  signal DDR_reset_n       : STD_LOGIC;
  signal DDR_we_n          : STD_LOGIC;
  signal FIXED_IO_ddr_vrn  : STD_LOGIC;
  signal FIXED_IO_ddr_vrp  : STD_LOGIC;
  signal FIXED_IO_mio      : STD_LOGIC_VECTOR (53 downto 0);
  signal FIXED_IO_ps_clk   : STD_LOGIC;
  signal FIXED_IO_ps_porb  : STD_LOGIC;
  signal FIXED_IO_ps_srstb : STD_LOGIC;
 
begin

  motor_1: motor
    generic map (
      phase90 => 50 us)
    port map (
      run       => run,
      motor_cw  => motor_cw,
      motor_ccw => motor_ccw,
      a         => a,
      b         => b);

  DUT: lab4_top
    port map (
      arst              => arst,
      sync_rst          => sync_rst,
      mclk              => mclk,
      a                 => a,
      b                 => b,
      force_cw          => force_cw,
      force_ccw         => force_ccw,
      motor_cw          => motor_cw,
      motor_ccw         => motor_ccw,
      a_n               => a_n,
      abcdefgdec_n      => abcdefgdec_n,
      sw                => sw,
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
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb);

  
  -- Core design clock
  CLK_GEN_100M: clk_gen(
    clk      => mclk,
    cycle_no => cycle_no,
    run      => run,
    period   => T_100M,
    high     => T_HIGH_100M,
    offset   => T_OFFSET_100M
  );

  -- AXI4 clock
  CLK_GEN_125M: clk_gen(
    clk      => clk_125m,
    cycle_no => clk_125m_cycle_no,
    run      => run,
    period   => T_125M,
    high     => T_HIGH_125M,
    offset   => T_OFFSET_125M
  );  

  -- Clock assignments to core
  s_axi_aclk <= clk_125m;
  
  TB_STIM: -- Testbench stimuli process
  process

    
    alias ARESET          is <<signal .tb_lab4.DUT.lab4processor_0.ARESET         : std_logic_vector(0 to 0)>>;
    alias s_axi_araddr    is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_araddr : std_logic_vector(31 downto 0)>>;
    alias s_axi_arprot    is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_arprot : std_logic_vector(2 downto 0)>>;
    alias s_axi_arready   is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_arready: std_logic>>;
    alias s_axi_arvalid   is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_arvalid: std_logic>>;
    alias s_axi_awaddr    is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_awaddr : std_logic_vector(31 downto 0)>>;
    alias s_axi_awprot    is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_awprot : std_logic_vector(2 downto 0)>>;
    alias s_axi_awready   is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_awready: std_logic>>;
    alias s_axi_awvalid   is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_awvalid: std_logic>>;
    alias s_axi_bready    is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_bready : std_logic>>;
    alias s_axi_bresp     is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_bresp  : std_logic_vector(1 downto 0)>>;
    alias s_axi_bvalid    is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_bvalid : std_logic>>;
    alias s_axi_rdata     is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_rdata  : std_logic_vector(31 downto 0)>>;
    alias s_axi_rready    is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_rready : std_logic>>;
    alias s_axi_rresp     is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_rresp  : std_logic_vector(1 downto 0)>>;
    alias s_axi_rvalid    is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_rvalid : std_logic>>;
    alias s_axi_wdata     is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_wdata  : std_logic_vector(31 downto 0)>>;
    alias s_axi_wready    is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_wready : std_logic>>;
    alias s_axi_wstrb     is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_wstrb  : std_logic_vector(3 downto 0)>>;
    alias s_axi_wvalid    is <<signal .tb_lab4.DUT.lab4processor_0.M00_AXI_wvalid : std_logic>>;

    -- setting axi_clk_run signal to '0' will terminate simulation
    alias axi_clk_run    is <<signal .tb_lab4.DUT.lab4processor_0.run : std_logic>>;
    
    -- Zynq uP Write
    procedure MW (      
      constant tsize    : in transaction_size;
      constant addr     : in std_logic_vector(ADDRESS_LENGTH-1 downto 0);
--      constant data     : in std_logic_vector(DATA_LENGTH-1 downto 0)) is
      constant data     : in std_logic_vector) is
        variable error_found : boolean;
    begin
     
      AXI4LiteWrite(tsize            => tsize, 
                    addr             => addr,
                    data             => data,
                    s00_axi_aclk     => s_axi_aclk,    
                    s00_axi_awaddr   => s_axi_awaddr, 
                    s00_axi_awprot   => s_axi_awprot, 
                    s00_axi_awvalid  => s_axi_awvalid,
                    s00_axi_awready  => s_axi_awready,
                    s00_axi_wdata    => s_axi_wdata,  
                    s00_axi_wstrb    => s_axi_wstrb,  
                    s00_axi_wvalid   => s_axi_wvalid, 
                    s00_axi_wready   => s_axi_wready, 
                    s00_axi_bresp    => s_axi_bresp,  
                    s00_axi_bvalid   => s_axi_bvalid, 
                    s00_axi_bready   => s_axi_bready,  
                    log              => tb_lab4_log,
                    cycle            => cycle_no,
                    error_found      => error_found,
                    error_no         => error_no);
           
      wait until rising_edge(mclk);
      
    end procedure MW;

    -- Zynq uP Read
    procedure MR ( 
      constant tsize    : in  transaction_size;
      constant addr     : in  std_logic_vector(ADDRESS_LENGTH-1 downto 0);
      variable data     : out std_logic_vector) is
        variable error_found : boolean;
        variable error_no_i  : natural;
    begin
      
      AXI4LiteRead(tsize            => tsize, 
                   addr             => addr,
                   data             => data,
                   s00_axi_aclk     => s_axi_aclk,         
                   s00_axi_araddr   => s_axi_araddr,   
                   s00_axi_arprot   => s_axi_arprot,   
                   s00_axi_arvalid  => s_axi_arvalid,  
                   s00_axi_arready  => s_axi_arready,  
                   s00_axi_rdata    => s_axi_rdata,    
                   s00_axi_rresp    => s_axi_rresp,    
                   s00_axi_rvalid   => s_axi_rvalid,   
                   s00_axi_rready   => s_axi_rready,     
                   log              => tb_lab4_log,
                   cycle            => cycle_no,
                   error_found      => error_found,
                   error_no         => error_no_i);

      if error_found then
        error_no <= error_no + error_no_i;
      end if;
             
      wait until rising_edge(mclk);
      
   end procedure MR;
    
   --  Zynq uP Check
   procedure MC (
     constant tsize    : in  transaction_size;
     constant addr     : in  std_logic_vector(ADDRESS_LENGTH-1 downto 0);
     constant data     : in  std_logic_vector) is      
       variable data_i      : std_logic_vector(data'length-1 downto 0);     
       variable error_found : boolean;
   begin

     data_i := data;
   
     AXI4LiteCheck(tsize            => tsize, 
                   addr             => addr,
                   data             => data_i,
                   s00_axi_aclk     => s_axi_aclk,         
                   s00_axi_araddr   => s_axi_araddr,   
                   s00_axi_arprot   => s_axi_arprot,   
                   s00_axi_arvalid  => s_axi_arvalid,  
                   s00_axi_arready  => s_axi_arready,  
                   s00_axi_rdata    => s_axi_rdata,    
                   s00_axi_rresp    => s_axi_rresp,    
                   s00_axi_rvalid   => s_axi_rvalid,   
                   s00_axi_rready   => s_axi_rready,   
                   log              => tb_lab4_log,
                   cycle            => cycle_no,
                   error_found      => error_found,
                   error_no         => error_no);
         
     wait until rising_edge(mclk);
   end procedure MC;

   variable bvalue   : std_logic_vector(7 downto 0);
   variable hvalue   : std_logic_vector(15 downto 0);
   variable wvalue   : std_logic_vector(31 downto 0);
   variable ramaddr  : std_logic_vector(31 downto 0);
   variable wdata    : std_logic_vector(31 downto 0);
  
   begin

     -- Initializing signals
     -- NOTE: Remove a and b signal init when using motor model.
     -- a             <= '0';
     -- b             <= '0';
     -----------------------------------------------------------
     force_cw      <= '0';
     force_ccw     <= '0';
     sw(7)         <= '0';        -- Select switches (i.e. sw(6:0) as setpoint initially  
     sw(6 downto 0) <= "1011101"; -- Switch value selected
     
     s_axi_araddr  <= (others => '0');
     s_axi_arprot  <= (others => '0');
     s_axi_arvalid <= '0';
     s_axi_awaddr  <= (others => '0');
     s_axi_awprot  <= (others => '0');
     s_axi_awvalid <= '0';
     s_axi_bready  <= '0';
     s_axi_rready  <= '0';
     s_axi_wdata   <= (others => '0');
     s_axi_wstrb   <= (others => '0');
     s_axi_wvalid  <= '0';

     -- Setting reset signals for 10 cycles
     ARESET(0) <= '0';
     arst      <= '1';
     sync_rst  <= '1';
     
     Tcycle(10);
     
     ARESET(0) <= '1';
     arst      <= '0';
     sync_rst  <= '0';

     Tcycle(10);

     -- Reset complete; perform simulation
     -- Perform 32-bit r/w access of the LAB4REG_RWTEST register
     wdata := x"12345678";
     MW(SINGLE, LAB4REG_RWTEST, wdata);  
     MR(SINGLE, LAB4REG_RWTEST, wvalue);    
     writef(tb_lab4_log, cycle_no, "Read value in testbench : " & lv2strx(wvalue,32));
     MC(SINGLE, LAB4REG_RWTEST, x"12345678");    

     wdata := x"ABCDEF98";
     MW(SINGLE, LAB4REG_RWTEST, wdata);  
     MR(SINGLE, LAB4REG_RWTEST, wvalue);    
     writef(tb_lab4_log, cycle_no, "Read value in testbench : " & lv2strx(wvalue,32));
     MC(SINGLE, LAB4REG_RWTEST, x"ABCDEF98");

     -- Switch to processor register LAB4REG_SETPOINT as setpoint
	 Tcycle(5);
     sw(7) <= '1';
	 Tcycle(5);
	 
	 -- <Add register accesses here > 
	 writef(tb_lab4_log, cycle_no, "Begin testing register: ");
	 MW(BYTE, LAB4REG_SETPOINT, x"B0");
	 MR(BYTE, LAB4REG_SETPOINT, bvalue);
     writef(tb_lab4_log, cycle_no, "Read value in testbench : " & lv2strx(bvalue,8));
	 MC(BYTE, LAB4REG_SETPOINT, x"B0");
	 
	 -- Henriktk: added these test to 16- and 32-bit registers
	 writef(tb_lab4_log, cycle_no, "Begin testing register 16: ");
	 writef(tb_lab4_log, cycle_no, "Should error: ");
	 MW(BYTE, LAB4REG_SETPOINT16, x"BEEF");
	 MR(BYTE, LAB4REG_SETPOINT16, bvalue);
     writef(tb_lab4_log, cycle_no, "Read value in testbench : " & lv2strx(bvalue,16));
	 MC(BYTE, LAB4REG_SETPOINT16, x"BEEF");
	 
	 writef(tb_lab4_log, cycle_no, "Should work: ");
	 MW(HALFWORD, LAB4REG_SETPOINT16, x"1234");
	 MR(HALFWORD, LAB4REG_SETPOINT16, hvalue);
     writef(tb_lab4_log, cycle_no, "Read value in testbench : " & lv2strx(hvalue,16));
	 MC(HALFWORD, LAB4REG_SETPOINT16, x"1234");
	 MC(SINGLE, LAB4REG_SETPOINT16, x"00001234");
	 writef(tb_lab4_log, cycle_no, "Should error: ");
	 MC(HALFWORD, LAB4REG_SETPOINT16, x"BEEF");
	 MC(SINGLE, LAB4REG_SETPOINT16, x"10001234");
	 
	 writef(tb_lab4_log, cycle_no, "Begin testing register 32: ");
	 writef(tb_lab4_log, cycle_no, "Should work: ");	 
	 MW(SINGLE, LAB4REG_SETPOINT32, x"DEADBEEF");
	 MR(SINGLE, LAB4REG_SETPOINT32, wvalue);
     writef(tb_lab4_log, cycle_no, "Read value in testbench : " & lv2strx(wvalue,32));
	 MC(SINGLE, LAB4REG_SETPOINT32, x"DEADBEEF");
	 
	 -- Henriktk: added these test to RAM
	 writef(tb_lab4_log, cycle_no, "Begin testing RAM: ");
	 MW(SINGLE, std_logic_vector(unsigned(LAB4RAM_BASE_ADDRESS) + 4), x"10061995");
	 MC(SINGLE, std_logic_vector(unsigned(LAB4RAM_BASE_ADDRESS) + 4), x"10061995");

	 
	 
	 
	 -- Example RAM accesses when comments removed:

      MC(SINGLE, LAB4RAM_BASE_ADDRESS, x"DEADBEEF");  -- Reset value in RAM simulation model 
     
     MW(SINGLE, LAB4RAM_BASE_ADDRESS, x"12345678");
     ramaddr:= std_logic_vector(unsigned(LAB4RAM_BASE_ADDRESS) + 4);
     MW(SINGLE, ramaddr, x"87654321");  
     ramaddr:= std_logic_vector(unsigned(LAB4RAM_BASE_ADDRESS) + 8);
     MW(SINGLE, ramaddr, x"ABCDEF98");  

     MC(SINGLE, LAB4RAM_BASE_ADDRESS, x"12345678");
     ramaddr:= std_logic_vector(unsigned(LAB4RAM_BASE_ADDRESS) + 4);
     MC(SINGLE, ramaddr, x"87654321");  
     ramaddr:= std_logic_vector(unsigned(LAB4RAM_BASE_ADDRESS) + 8);
     MC(SINGLE, ramaddr, x"ABCDEF98");

     
	 MW(HALFWORD, LAB4RAM_BASE_ADDRESS, x"1234");
     ramaddr:= std_logic_vector(unsigned(LAB4RAM_BASE_ADDRESS) + 2);
     MW(HALFWORD, ramaddr, x"5678");  

     MC(HALFWORD, LAB4RAM_BASE_ADDRESS, x"1234");
     ramaddr:= std_logic_vector(unsigned(LAB4RAM_BASE_ADDRESS) + 2);
     MC(HALFWORD, ramaddr, x"5678");  
     
     MC(SINGLE, LAB4RAM_BASE_ADDRESS, x"56781234");

     
     MW(BYTE, LAB4RAM_BASE_ADDRESS, x"01");
     ramaddr:= std_logic_vector(unsigned(LAB4RAM_BASE_ADDRESS) + 1);
     MW(BYTE, ramaddr, x"02");  
     ramaddr:= std_logic_vector(unsigned(LAB4RAM_BASE_ADDRESS) + 2);
     MW(BYTE, ramaddr, x"03");  
     ramaddr:= std_logic_vector(unsigned(LAB4RAM_BASE_ADDRESS) + 3);
     MW(BYTE, ramaddr, x"04");  

     MC(BYTE, LAB4RAM_BASE_ADDRESS, x"01");
     ramaddr:= std_logic_vector(unsigned(LAB4RAM_BASE_ADDRESS) + 1);
     MC(BYTE, ramaddr, x"02");  
     ramaddr:= std_logic_vector(unsigned(LAB4RAM_BASE_ADDRESS) + 2);
     MC(BYTE, ramaddr, x"03");  
     ramaddr:= std_logic_vector(unsigned(LAB4RAM_BASE_ADDRESS) + 3);
     MC(BYTE, ramaddr, x"04");  
     
     MC(SINGLE, LAB4RAM_BASE_ADDRESS, x"04030201");

	 
     Tcycle(100000); -- Run to let the position signals from motor model change ...
     
     run <= '0';
     axi_clk_run <= '0';
     
     -- Write error result
     if (error_no > 0) then
       writef(tb_lab4_log, cycle_no,"  ERROR: Simulation failed! Number of errors: " & to_string(error_no));
       assert (false) report "ERROR: Simulation failed! Number of errors: " & to_string(error_no)
         severity note;
     else
       writef(tb_lab4_log, cycle_no, "  NOTE: Testbench simulation successful!");
       assert (false)
         report "Testbench simulation successful!"
         severity note;
     end if;
     
     wait; -- Terminate the process

  end process;
  
end architecture beh;

