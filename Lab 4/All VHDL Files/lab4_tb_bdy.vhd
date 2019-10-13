library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

use std.textio.all;

package body lab4_tb_pck is
  
  constant T_100M           : time := 10 ns;        -- 100MHz clock period
  constant T_OFFSET_100M    : time := 0 ns;         -- time of positive edge clk i.r.t begining of cycle
  constant T_HIGH_100M      : time := 0.5 * T_100M; -- duration of clock being high

  constant T_125M           : time := 8 ns;         -- 125MHz clock period
  constant T_OFFSET_125M    : time := 4 ns;         -- time of positive edge clk i.r.t begining of cycle
  constant T_HIGH_125M      : time := 0.5 * T_125M; -- duration of clock being high
  
  -- wait n T cycles
  procedure Tcycle(n : natural) is
  begin
    wait for n * T_100M;  -- wait n cycles
  end Tcycle;

  -- perform chip reset
  procedure Reset (
    signal rst_n : out std_logic;
    file log : text;
    constant cycle : in integer) is
  begin
    writef(log, cycle,"Reset Performed");
    rst_n <= '0';
    Tcycle(10); -- wait 10 cycles
    rst_n <= '1';
  end Reset;


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
    signal   error_no         : inout natural) is
      variable data_slv : std_logic_vector(31 downto 0);
      variable s00_axi_bvalid_eq1 : boolean;
  begin
    error_found:= FALSE;
    s00_axi_bvalid_eq1 := FALSE;
        
    wait until rising_edge(s00_axi_aclk);

    if tsize=BYTE and data'length=8 then
      data_slv(7 downto 0)   := data;
      data_slv(15 downto 8)  := data;
      data_slv(23 downto 16) := data;
      data_slv(31 downto 24) := data;
    elsif tsize=HALFWORD and data'length=16 then
      data_slv(15 downto 0)  := data;
      data_slv(31 downto 16) := data;
    elsif tsize=SINGLE and data'length=32 then
      data_slv := data;
    else
      error_no <= error_no + 1;
      error_found:= TRUE;
      writef(log, cycle,"AXI4Lite write access aborted: Illegal data length");
      return;      
    end if;
    
    if (tsize=BYTE and addr(1 downto 0)="00") then      
      s00_axi_wstrb<= force "0001";
      writef(log, cycle,"AXI4Lite byte 0 write to AXI4PIFB               " & " @ " &
           lv2strx(addr,32) & " <= " & lv2strx(data_slv(7 downto 0),8));
    elsif (tsize=BYTE and addr(1 downto 0)="01") then      
      s00_axi_wstrb<= force "0010";
      writef(log, cycle,"AXI4Lite byte 1 write to AXI4PIFB               " & " @ " &
           lv2strx(addr,32) & " <= " & lv2strx(data_slv(15 downto 8),8));
    elsif (tsize=BYTE and addr(1 downto 0)="10") then      
      s00_axi_wstrb<= force "0100";
      writef(log, cycle,"AXI4Lite byte 2 write to AXI4PIFB               " & " @ " &
           lv2strx(addr,32) & " <= " & lv2strx(data_slv(23 downto 16),8));
    elsif (tsize=BYTE and addr(1 downto 0)="11") then      
      s00_axi_wstrb<= force "1000";
      writef(log, cycle,"AXI4Lite byte 3 write to AXI4PIFB               " & " @ " &
           lv2strx(addr,32) & " <= " & lv2strx(data_slv(31 downto 24),8));
    elsif (tsize=HALFWORD and addr(1 downto 0)="00") then      
      s00_axi_wstrb <= force "0011";
      writef(log, cycle,"AXI4Lite halfword lower bytes write to AXI4PIFB " & " @ " &
           lv2strx(addr,32) & " <= " & lv2strx(data_slv(15 downto 0),16));
    elsif (tsize=HALFWORD and addr(1 downto 0)="10") then      
      s00_axi_wstrb<= force "1100";
      writef(log, cycle,"AXI4Lite halfword upper bytes write to AXI4PIFB " & " @ " &
           lv2strx(addr,32) & " <= " & lv2strx(data_slv(31 downto 16),16));
    elsif (tsize=SINGLE and addr(1 downto 0)="00") then      
      s00_axi_wstrb<= force "1111";
      writef(log, cycle,"AXI4Lite single word write to AXI4PIFB          " & " @ " &
           lv2strx(addr,32) & " <= " & lv2strx(data_slv,32));
    else
      error_no <= error_no + 1;
      error_found:= TRUE;
      writef(log, cycle,"AXI4Lite write access aborted: Unaligned register address.");
      return;
    end if;

    s00_axi_awaddr <= force addr;
    s00_axi_awprot <= force "000";
    s00_axi_awvalid<= force '1'; 
    s00_axi_wdata  <= force data_slv;
    s00_axi_wvalid <= force '1';
    s00_axi_bready <= force '1';

    wait until rising_edge(s00_axi_awready) for 2 us;

    if s00_axi_wready='1' then
      if s00_axi_bvalid='1' then
        s00_axi_bvalid_eq1:= TRUE;
      end if;
      wait until rising_edge(s00_axi_aclk);      
      s00_axi_awaddr <= force (others => '0');
      s00_axi_awprot <= force "000";
      s00_axi_awvalid<= force '0'; 
      s00_axi_wdata  <= force (others => '0');
      s00_axi_wvalid <= force '0';
    else
      wait until rising_edge(s00_axi_wready) for 2 us;
      if s00_axi_bvalid='1' then
        s00_axi_bvalid_eq1:= TRUE;
      end if;
      s00_axi_awaddr <= force (others => '0');
      s00_axi_awprot <= force "000";
      s00_axi_awvalid<= force '0'; 
      wait until rising_edge(s00_axi_aclk);
      s00_axi_wdata  <= force (others => '0');
      s00_axi_wvalid <= force '0';      
    end if;

    if s00_axi_bvalid='0' and not s00_axi_bvalid_eq1 then
      wait until rising_edge(s00_axi_bvalid) for 2 us;
    end if;
    
    wait until falling_edge(s00_axi_aclk);
 
    if (s00_axi_bvalid/='1' and (not s00_axi_bvalid_eq1)) or s00_axi_bresp/="00" then      
      error_no <= error_no + 1;
      error_found:= TRUE;
      writef(log, cycle,"AXI4Lite write access aborted: Write access timeout.");      
    end if;
    
    wait until rising_edge(s00_axi_aclk);
    s00_axi_bready<= force '0';
    
    wait until rising_edge(s00_axi_aclk);
    
  end ;

 
  procedure AXI4LiteCheck (
    constant tsize            : in  transaction_size;
    constant addr             : in  std_logic_vector(31 downto 0);
    variable data             : in  std_logic_vector;

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
    signal   error_no         : inout natural) is
      variable rdata          : std_logic_vector(data'length-1 downto 0); -- data read
      variable error_found_i  : boolean;
      variable error_no_i     : natural;

  begin

    if ((tsize=BYTE and data'length/=8) or
        (tsize=HALFWORD and data'length/=16) or
        (tsize=SINGLE and data'length/=32)) then
      error_no <= error_no + 1;
      error_found:= TRUE;
      writef(log, cycle,"AXI4Lite check access aborted: Illegal data length");
      return;      
    end if;
      
    AXI4LiteRead(tsize            => tsize, 
                 addr             => addr,
                 data             => rdata,
                 s00_axi_aclk     => s00_axi_aclk,         
                 s00_axi_araddr   => s00_axi_araddr,   
                 s00_axi_arprot   => s00_axi_arprot,   
                 s00_axi_arvalid  => s00_axi_arvalid,  
                 s00_axi_arready  => s00_axi_arready,  
                 s00_axi_rdata    => s00_axi_rdata,    
                 s00_axi_rresp    => s00_axi_rresp,    
                 s00_axi_rvalid   => s00_axi_rvalid,   
                 s00_axi_rready   => s00_axi_rready,   
                 log              => log,
                 cycle            => cycle,
                 error_found      => error_found_i,
                 error_no         => error_no_i);

    if not error_found_i then
      if (tsize=BYTE and addr(1 downto 0)="00" and rdata /= data) then
        writef(log, cycle,"  ERROR! byte 0 data read: " & lv2strx(rdata,8) &
                    ", expected : " & lv2strx(data,8));    
        error_no    <= error_no + 1;
        error_found := TRUE;
      elsif (tsize=BYTE and addr(1 downto 0)="01" and rdata /= data) then
        writef(log, cycle,"  ERROR! byte 1 data read: " & lv2strx(rdata,8) &
               ", expected : " & lv2strx(data,8));      
        error_no    <= error_no + 1;
        error_found := TRUE;
      elsif (tsize=BYTE and addr(1 downto 0)="10" and rdata /= data) then
        writef(log, cycle,"  ERROR! byte 2 data read: " & lv2strx(rdata,8) &
               ", expected : " & lv2strx(data,8));      
        error_no    <= error_no + 1;
        error_found := TRUE;
      elsif (tsize=BYTE and addr(1 downto 0)="11" and rdata /= data) then
        writef(log, cycle,"  ERROR! byte 3 data read: " & lv2strx(rdata,8) &
               ", expected : " & lv2strx(data,8));      
        error_no    <= error_no + 1;
        error_found := TRUE;
      elsif (tsize=HALFWORD and addr(1 downto 0)="00" and rdata /= data) then
        writef(log, cycle,"  ERROR! Halfword lower bytes data read: " & lv2strx(rdata,16) &
                    ", expected : " & lv2strx(data,16));
        error_no    <= error_no + 1;
        error_found := TRUE;
      elsif (tsize=HALFWORD and addr(1 downto 0)="10" and rdata /= data) then
        writef(log, cycle,"  ERROR! Halfword upper bytes data read: " & lv2strx(rdata,16) &
                    ", expected : " & lv2strx(data,16));
        error_no    <= error_no + 1;
        error_found := TRUE;
      elsif (tsize=SINGLE and addr(1 downto 0)="00" and rdata /= data) then
        writef(log, cycle,"  ERROR! Word data read: " & lv2strx(rdata,32) &
                    ", expected : " & lv2strx(data,32));
        error_no    <= error_no + 1;
        error_found := TRUE;
      end if;
    else
        error_no    <= error_no + 1;
        error_found := TRUE;
    end if;
  
  end procedure AXI4LiteCheck;
  
  
  -- AXI4Lite Data Read
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
    variable error_no         : inout natural) is
  begin
    error_found:= FALSE;

    if ((tsize=BYTE and data'length/=8) or
        (tsize=HALFWORD and data'length/=16) or
        (tsize=SINGLE and data'length/=32)) then
      error_no := error_no + 1;
      error_found:= TRUE;
      writef(log, cycle,"AXI4Lite read access aborted: Illegal data length");
      return;      
    end if;
    
    wait until rising_edge(s00_axi_aclk);

    s00_axi_arvalid <= force '1';
    s00_axi_araddr  <= force addr;
    s00_axi_arprot  <= force "000";
    s00_axi_rready  <= force '1';

    wait until rising_edge(s00_axi_arready) for 2 us;
    
    wait until rising_edge(s00_axi_aclk);
    s00_axi_arvalid <= force '0';
    s00_axi_araddr  <= force (others => '0');

    if s00_axi_rvalid='0' then
     wait until rising_edge(s00_axi_rvalid) for 2 us;     
    end if;

    wait until falling_edge(s00_axi_aclk);
  
    if s00_axi_rvalid/='1' or s00_axi_rresp/="00" then
      data := x"00";
      error_no := error_no + 1;
      error_found:= TRUE;
      writef(log, cycle,"AXI4Lite read access aborted: Read access timeout.");
    else

      if (tsize=BYTE and addr(1 downto 0)="00") then      
        data := s00_axi_rdata(7 downto 0);
        writef(log, cycle,"AXI4Lite byte 0 read from AXI4PIFB              " & " @ " &
             lv2strx(addr,32) & " <= " & lv2strx(s00_axi_rdata(7 downto 0),8));
      elsif (tsize=BYTE and addr(1 downto 0)="01") then       
        data := s00_axi_rdata(15 downto 8);
        writef(log, cycle,"AXI4Lite byte 1 read from AXI4PIFB              " & " @ " &
             lv2strx(addr,32) & " <= " & lv2strx(s00_axi_rdata(15 downto 8),8));
      elsif (tsize=BYTE and addr(1 downto 0)="10") then      
        data := s00_axi_rdata(23 downto 16);
        writef(log, cycle,"AXI4Lite byte 2 read from AXI4PIFB              " & " @ " &
             lv2strx(addr,32) & " <= " & lv2strx(s00_axi_rdata(23 downto 16),8));
      elsif (tsize=BYTE and addr(1 downto 0)="11") then      
        data := s00_axi_rdata(31 downto 24);
        writef(log, cycle,"AXI4Lite byte 3 read from AXI4PIFB              " & " @ " &
             lv2strx(addr,32) & " <= " & lv2strx(s00_axi_rdata(31 downto 24),8));
      elsif (tsize=HALFWORD and addr(1 downto 0)="00") then      
        data := s00_axi_rdata(15 downto 0);
        writef(log, cycle,"AXI4Lite halfword lower bytes read from AXI4PIFB" & " @ " &
             lv2strx(addr,32) & " <= " & lv2strx(s00_axi_rdata(15 downto 0),16));
      elsif (tsize=HALFWORD and addr(1 downto 0)="10") then      
        data := s00_axi_rdata(31 downto 16);
        writef(log, cycle,"AXI4Lite halfword upper bytes read from AXI4PIFB" & " @ " &
             lv2strx(addr,32) & " <= " & lv2strx(s00_axi_rdata(31 downto 16),16));
      elsif (tsize=SINGLE and addr(1 downto 0)="00") then      
        data := s00_axi_rdata(31 downto 0);
        writef(log, cycle,"AXI4Lite single word read from AXI4PIFB         " & " @ " &
             lv2strx(addr,32) & " <= " & lv2strx(s00_axi_rdata,32));
      else
        error_no := error_no + 1;
        error_found:= TRUE;
        writef(log, cycle,"Illegal AXI4Lite read access: Unaligned register address.");
      end if;
    end if;
    
    wait until rising_edge(s00_axi_aclk);
    s00_axi_rready<= force '0';

    wait until rising_edge(s00_axi_aclk);
    
  end ;
  
end package body lab4_tb_pck;
