
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.lab4_pck.all;

architecture rtl of axi4pifb is

  type fsm_state_type is (IDLE,
                          WR_ACCESS, WR_WAIT, WR_ACCESS_DONE, WR_COMPLETE,
                          RD_ACCESS, RD_DATA_WAIT, RD_ACCESS_DONE, RD_COMPLETE);  
  signal fsm_state : fsm_state_type;  

  -- AXI4LITE signals
  signal axi_awaddr	 : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
  signal axi_awready     : std_logic;
  signal axi_wready	 : std_logic;
  signal axi_wdata	 : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
  signal axi_wstrb       : std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
  signal axi_bresp	 : std_logic_vector(1 downto 0);
  signal axi_bvalid	 : std_logic;
  signal axi_araddr	 : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
  signal axi_arready     : std_logic;
  signal axi_rdata	 : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
  signal axi_rresp	 : std_logic_vector(1 downto 0);
  signal axi_rvalid	 : std_logic;

  -- Register read and write access acknowledge synch signals
  signal ack_2pif_s1, ack_2pif_s2 : std_logic;
  signal ack_2pif_d1, ack_2pif_str : std_logic;
  
  -- Reset synch signals
  signal pif_rst_s1, pif_rst_s2 : std_logic;

  -- Internal signals
  signal pif_regcs_i    : std_logic_vector(31 downto 0); 
  signal pif_memcs_str  : std_logic_vector(31 downto 0);  
  signal pif_addr_i     : std_logic_vector(PIF_ADDR_LENGTH-1 downto 0); 
  signal pif_re_i       : std_logic_vector(0 downto 0);
  signal pif_we_i       : std_logic_vector(0 downto 0);
  signal ack_2pif       : std_logic; 
  signal mem_ack_rd     : std_logic; 
  signal mem_ack_wr     : std_logic; 
  signal mem_ack_d1     : std_logic; 
  signal mem_ack_str    : std_logic;
  signal mem_ack_str_d1 : std_logic;
           
begin

  P_RST_SYNCH_AXI_ACLK : process( s_axi_aclk, s_axi_aresetn )
  begin
    if s_axi_aresetn='0' then
      pif_rst_s1 <= '1';
      pif_rst_s2 <= '1';
    elsif rising_edge(s_axi_aclk) then
      pif_rst_s1 <= '0';
      pif_rst_s2 <= pif_rst_s1;
    end if;
  end process P_RST_SYNCH_AXI_ACLK;

  
  -- Synchronize the register chip select signal
  P_SYNCH_REGCS: process ( s_axi_aclk, s_axi_aresetn )
  begin
    if s_axi_aresetn='0' then
      ack_2pif_s1  <= '0';
      ack_2pif_s2  <= '0';
      ack_2pif_d1  <= '0';
      ack_2pif_str <= '0';
    elsif rising_edge(s_axi_aclk) then
      ack_2pif_s1  <= ack_2pif;
      ack_2pif_s2  <= ack_2pif_s1;       
      ack_2pif_d1  <= ack_2pif_s2;
      ack_2pif_str <= (ack_2pif_s2 and (not ack_2pif_d1)) or mem_ack_str_d1;
    end if;
  end process;
  

  P_MEM_ACK_STR: process ( s_axi_aclk, s_axi_aresetn )
  begin
    if s_axi_aresetn='0' then
      mem_ack_d1     <= '0';
      mem_ack_str    <= '0';
      mem_ack_str_d1 <= '0';
    elsif rising_edge(s_axi_aclk) then
      mem_ack_d1     <= mem_ack_rd or mem_ack_wr;
      mem_ack_str    <= (mem_ack_rd or mem_ack_wr) and not mem_ack_d1;       
      mem_ack_str_d1 <= mem_ack_str;           
    end if;
  end process;


  P_AXI4LITE_BRIDGE_FSM:
  process ( s_axi_aclk, s_axi_aresetn ) is
    variable pif_memcs_i  : std_logic_vector(31 downto 0); 
    variable pif_addr_sel : std_logic_vector(4 downto 0);
  begin
    if ( s_axi_aresetn = '0') then
      axi_awready <= '0';
      axi_awaddr  <= (others => '0');
      axi_wready  <= '0';
      axi_wdata   <= (others => '0');
      axi_wstrb   <= (others => '0');
      axi_arready <= '0';
      axi_araddr  <= (others => '1');
      axi_bvalid  <= '0';
      axi_bresp   <= "00";
      axi_rvalid  <= '0';
      axi_rresp   <= "00";
      axi_rdata   <= (others => '0');
      
      pif_regcs_i   <= (others => '0');
      pif_memcs_i   := (others => '0');
      pif_memcs_str <= (others => '0');
      pif_addr_i    <= (others => '0');
      pif_wdata     <= (others => '0');
      -- Single bit, but vector type due to Xilinx generated RAM has vector type we signal.
      pif_we_i      <= (others => '0');
      -- Write strobes. This signal indicates which byte lanes hold
      --   valid data. There is one write strobe bit for each eight
      --   bits of the write data bus.    
      pif_be	    <= (others => '0');        
      mem_ack_wr    <= '0';
      pif_re_i      <= (others => '0');
      mem_ack_rd    <= '0';

      fsm_state <= IDLE;

    elsif rising_edge( s_axi_aclk ) then

      -- Default values
      axi_awready <= '0';
      axi_wready  <= '0';
      axi_arready <= '0';
     
      case fsm_state is

        when IDLE  =>
          if (s_axi_awvalid = '1' and s_axi_wvalid = '1' and ack_2pif_s2='0') then
            axi_awready <= '1';
            axi_awaddr  <= s_axi_awaddr;
            axi_wready  <= '1';
            axi_wdata   <= s_axi_wdata;
            axi_wstrb   <= s_axi_wstrb;
            fsm_state   <= WR_ACCESS;
          elsif (s_axi_arvalid = '1' and ack_2pif_s2='0') then  
            axi_arready <= '1';
            axi_araddr  <= s_axi_araddr;           
            fsm_state   <= RD_ACCESS;            
          end if;
          
                            
        when  WR_ACCESS=>
          pif_addr_i   <= axi_awaddr(PIF_ADDR_LENGTH-1 downto 0);
          pif_wdata    <= axi_wdata(PIF_DATA_LENGTH-1 downto 0);
          pif_we_i     <= (others => '1');
          pif_be       <= axi_wstrb;
          pif_regcs_i  <= (others => '0');
          pif_memcs_i  := (others => '0');
          mem_ack_wr   <= '0';
          if axi_awaddr(25 downto 21)="00000" then
            pif_addr_sel:= axi_awaddr(20 downto 16);
            
            case pif_addr_sel is
              when LAB4REG_BASE_ADDRESS(20 downto 16) => pif_regcs_i(0) <= '1';
              when others =>
                mem_ack_wr <= '1'; 
                pif_regcs_i <= (others => '0');
            end case;
          else
            mem_ack_wr <= '1';
            pif_addr_sel:= axi_awaddr(25 downto 21);
            case pif_addr_sel is
              when LAB4RAM_BASE_ADDRESS(25 downto 21) => pif_memcs_i(0) := '1';
              when others =>  pif_memcs_i := (others => '0');
            end case;           
          end if;         
          fsm_state<= WR_WAIT;
          

        when WR_WAIT =>         
          if (ack_2pif_str='1') then 
            pif_regcs_i  <= (others => '0');
            pif_memcs_i  := (others => '0');
            pif_addr_i   <= (others => '0'); 
            pif_we_i     <= (others => '0');
            pif_be       <= (others => '0');        
            mem_ack_wr   <= '0';
            axi_bvalid   <= '1';
            axi_bresp    <= "00"; 
            fsm_state    <= WR_ACCESS_DONE;            
          end if;
          

        when WR_ACCESS_DONE =>         
          if (s_axi_bready = '1') then
            axi_bvalid <= '0';            
            fsm_state  <= WR_COMPLETE;
          end if;


        when WR_COMPLETE =>                   
          if (s_axi_arvalid = '1' and ack_2pif_s2='0') then
            axi_arready <= '1';
            axi_araddr  <= s_axi_araddr;           
            fsm_state   <= RD_ACCESS;            
          else
            fsm_state   <= IDLE;
          end if;
          

        when RD_ACCESS =>
          pif_addr_i   <= axi_araddr(PIF_ADDR_LENGTH-1 downto 0);
          pif_re_i     <= (others => '1');
          pif_regcs_i  <= (others => '0');
          pif_memcs_i  := (others => '0');
          mem_ack_rd   <= '0';
          if axi_araddr(25 downto 21)="00000" then
            pif_addr_sel:= axi_araddr(20 downto 16);
            case pif_addr_sel is
              when LAB4REG_BASE_ADDRESS(20 downto 16) => pif_regcs_i(0) <= '1';
              when others =>
                mem_ack_rd    <= '1'; 
                pif_regcs_i  <= (others => '0');
            end case;
          else
            mem_ack_rd    <= '1';
            pif_addr_sel:= axi_araddr(25 downto 21);
            case pif_addr_sel is
              when LAB4RAM_BASE_ADDRESS(25 downto 21) => pif_memcs_i(0) := '1';              
              when others =>  pif_memcs_i := (others => '0');
            end case;          
          end if;          
          fsm_state<= RD_DATA_WAIT;
          

        when RD_DATA_WAIT =>         
          if (ack_2pif_str='1') then 
            pif_regcs_i  <= (others => '0');
            pif_memcs_i  := (others => '0');
            pif_addr_i   <= (others => '0'); 
            pif_re_i     <= (others => '0');
            mem_ack_rd   <= '0';
            if axi_araddr(25 downto 21)="00000" then
              pif_addr_sel:= axi_araddr(20 downto 16);
              axi_rdata <= rdata_lab4reg2pif;
              case pif_addr_sel is
                when LAB4REG_BASE_ADDRESS(20 downto 16) => axi_rdata <= rdata_lab4reg2pif;
                when others =>  axi_rdata <= (others => '0');
              end case;
            else
              pif_addr_sel:= axi_araddr(25 downto 21);
              case pif_addr_sel is
                when LAB4RAM_BASE_ADDRESS(25 downto 21) => axi_rdata <= mdata_lab4ram2pif;
                when others  => axi_rdata <= (others => '0');
              end case;            
            end if;
            axi_rvalid <= '1';
            axi_rresp  <= "00"; -- 'OK' response
            fsm_state  <= RD_ACCESS_DONE;                       
          end if;
  
          
        when RD_ACCESS_DONE =>          
          if (s_axi_rready = '1') then            
	    -- Read data is accepted by the master
            axi_rvalid <= '0';
            axi_rdata  <= (others => '0');
            fsm_state  <= RD_COMPLETE;
          end if;


        when RD_COMPLETE =>                     
          if (s_axi_awvalid = '1' and s_axi_wvalid = '1' and ack_2pif_s2='0') then
            axi_awready <= '1';
            axi_awaddr  <= s_axi_awaddr;
            axi_wready  <= '1';
            axi_wdata   <= s_axi_wdata;
            axi_wstrb   <= s_axi_wstrb;
            fsm_state   <= WR_ACCESS;                       
          else
            fsm_state   <= IDLE;
          end if;
          
      end case;            

      -- Memory chip select is a strobe due FIFO read/write access
      for i in 0 to 31 loop
        pif_memcs_str(i) <= pif_memcs_i(i) and mem_ack_str;     
      end loop;
      
    end if;
    
  end process P_AXI4LITE_BRIDGE_FSM;

  -- Concurrent statements

  -- Read and write input acknowledge for register modules
  ack_2pif  <=  ack_lab4reg2pif;
  
  -- Concurrent I/O connections assignments
  s_axi_awready	<= axi_awready;
  s_axi_wready	<= axi_wready;
  s_axi_bresp	<= axi_bresp;
  s_axi_bvalid	<= axi_bvalid;
  s_axi_arready	<= axi_arready;
  s_axi_rdata	<= axi_rdata;
  s_axi_rresp	<= axi_rresp;
  s_axi_rvalid	<= axi_rvalid;
  

  -- Concurrent statements 
  pif_clk   <= s_axi_aclk;
  pif_rst   <= pif_rst_s2;
  pif_regcs <= pif_regcs_i; 
  pif_memcs <= pif_memcs_str; 
  pif_addr  <= pif_addr_i;
  pif_re    <= pif_re_i;
  pif_we    <= pif_we_i;
  
end rtl;
