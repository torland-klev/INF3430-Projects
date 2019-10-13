
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.lab4_pck.all;


architecture rtl of lab4_reg is

  -- Internal registers
  signal pif_regcs_s1, pif_regcs_s2 : std_logic;
  signal reg_data_out	: std_logic_vector(PIF_DATA_LENGTH-1 downto 0);

  -- Register read and write access acknowledge
  signal regrdack_2pif  : std_logic;
  signal regwrack_2pif  : std_logic;

  -- Internal registers
  signal rwtest_i       : std_logic_vector(31 downto 0);
  signal setpoint_i     : std_logic_vector(7 downto 0);
  
  -- Henriktk: added these two internal signal
  signal setpoint16_i	: std_logic_vector(15 downto 0);
  signal setpoint32_i	: std_logic_vector(31 downto 0);

begin
  
  -- Synchronize the register chip select signal
  P_SYNCH_REGCS: process (pif_rst, pif_clk)
  begin
    if pif_rst='1' then
      pif_regcs_s1 <= '0';
      pif_regcs_s2 <= '0';
    elsif rising_edge(pif_clk) then
      pif_regcs_s1 <= pif_regcs;
      pif_regcs_s2 <= pif_regcs_s1;       
    end if;
  end process;
  
  -- Memory mapped register write logic      
  P_WRITE: process (pif_rst, pif_clk)
  begin
      if pif_rst = '1' then 
       
          regwrack_2pif  <= '0';
          rwtest_i       <= (others => '0');
          setpoint_i     <= (others => '0');
		  setpoint16_i	 <= (others => '0');
		  setpoint32_i	 <= (others => '0');
         
      elsif rising_edge(pif_clk) then

        -- Default values
        -- TBD.
        
        if (pif_regcs_s2='1' and pif_we(0) = '1') then

          -- Register write acknowledge
          regwrack_2pif <= '1';          

          if pif_be(0)='1' then
            if pif_addr(15 downto 2) = LAB4REG_RWTEST(15 downto 2) then
              rwtest_i(7 downto 0) <=  pif_wdata(7 downto 0);
            end if;
            if pif_addr(15 downto 2) = LAB4REG_SETPOINT(15 downto 2) then
              setpoint_i(7 downto 0) <=  pif_wdata(7 downto 0);
            end if;
			-- Henriktk: if address is address of 16 or 32 bit register, then
			--			 then place first byte from wdata into 16 or 32 bit register
			if pif_addr(15 downto 2) = LAB4REG_SETPOINT16 (15 downto 2) then
				setpoint16_i(7 downto 0) <= pif_wdata(7 downto 0);
			end if;
			if pif_addr(15 downto 2) = LAB4REG_SETPOINT32(15 downto 2) then
				setpoint32_i(7 downto 0) <= pif_wdata(7 downto 0);
			end if;
          end if;
          
          if pif_be(1)='1' then
            if pif_addr(15 downto 2) = LAB4REG_RWTEST(15 downto 2) then
              rwtest_i(15 downto 8) <=  pif_wdata(15 downto 8);
            end if;
			
			-- Henriktk: if address is address of 16 or 32 bit register, then
			--			 then place second byte from wdata into 16 or 32 bit register
			if pif_addr(15 downto 2) = LAB4REG_SETPOINT16(15 downto 2) then
				setpoint16_i(15 downto 8) <= pif_wdata(15 downto 8);
			end if;
			if pif_addr(15 downto 2) = LAB4REG_SETPOINT32(15 downto 2) then
				setpoint32_i(15 downto 8) <= pif_wdata(15 downto 8);
			end if;
          end if;
          
          if pif_be(2)='1' then
            if pif_addr(15 downto 2) = LAB4REG_RWTEST(15 downto 2) then
              rwtest_i(23 downto 16) <=  pif_wdata(23 downto 16);
			end if;  
			-- Henriktk: if address is address of 32 bit register, then
			--			 place third byte from wdata into 32 bit register
			if pif_addr(15 downto 2) = LAB4REG_SETPOINT32(15 downto 2) then
				setpoint32_i(23 downto 16) <= pif_wdata(23 downto 16);
            end if;
          end if;
          
          if pif_be(3)='1' then
            if pif_addr(15 downto 2) = LAB4REG_RWTEST(15 downto 2) then
              rwtest_i(31 downto 24) <=  pif_wdata(31 downto 24);
            end if;
			
			-- Henriktk: if address is address of 32 bit register, then
			--			 place fourth byte from wdata into 32 bit register
			if pif_addr(15 downto 2) = LAB4REG_SETPOINT32(15 downto 2) then
				setpoint32_i(31 downto 24) <= pif_wdata(31 downto 24);
			end if;
          end if;
          
        elsif (pif_regcs_s2='0') then
          regwrack_2pif <= '0';
        end if;
      end if;
      
  end process; 


  -- Combinational memory mapped register read logic
  P_READ: process (pif_regcs_s2, pif_re, pif_addr,
                   rwtest_i, setpoint_i, setpoint16_i, setpoint32_i)
    begin
      -- Address decoding for reading registers
      if ( pif_regcs_s2='1' and pif_re(0)='1' ) then

	reg_data_out  <= (others => '0');

        if pif_addr(15 downto 2) = LAB4REG_RWTEST(15 downto 2) then
          reg_data_out <= rwtest_i;
        end if;
  
        if pif_addr(15 downto 2) = LAB4REG_SETPOINT(15 downto 2) then
          reg_data_out(7 downto 0) <= setpoint_i;
        end if;
		
		--Henriktk: if address is address of 16 or 32 bit register,
		-- 			then read from the respective one
		if pif_addr(15 downto 2) = LAB4REG_SETPOINT16(15 downto 2) then
          reg_data_out(15 downto 0) <= setpoint16_i;
        end if;
		if pif_addr(15 downto 2) = LAB4REG_SETPOINT32(15 downto 2) then
          reg_data_out(31 downto 0) <= setpoint32_i;
        end if;

      else
        reg_data_out  <= (others => '0');
      end if;      
  end process P_READ;

  
  -- Read register output
  P_READ_OUT: process( pif_rst, pif_clk ) is
  begin
    if ( pif_rst = '1' ) then
      rdata_2pif  <= (others => '0');
      regrdack_2pif <= '0';
    elsif (rising_edge (pif_clk)) then
      if (pif_regcs_s2 = '1' and pif_re(0) = '1') then
        -- Register read data 
        rdata_2pif <= reg_data_out;
        -- Register read acknowledge          
        regrdack_2pif <= '1';          
      elsif (pif_regcs_s2 = '0') then
        rdata_2pif  <= (others => '0');
        regrdack_2pif <= '0';
      end if;   
    end if;
  end process P_READ_OUT;

  
  -- Concurrent statements

  ack_2pif <= regrdack_2pif or regwrack_2pif;

  setpoint <= setpoint_i;
  
  -- Henriktk: mapped the internal signals to their outputs
  setpoint16 <= setpoint16_i;
  setpoint32 <= setpoint32_i;
  

end rtl;
