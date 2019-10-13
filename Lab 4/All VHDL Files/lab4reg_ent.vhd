
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.lab4_pck.all;

entity lab4_reg is
  generic (
    -- Width of PIF data bus
    PIF_DATA_LENGTH	: integer := PIF_DATA_LENGTH;
    -- Width of PIF address bus
    PIF_ADDR_LENGTH	: integer := PIF_ADDRESS_LENGTH
    );
	
  port (
    -- Add ports here:
    setpoint         : out std_logic_vector(7 downto 0);
	
	-- Henriktk: added these two outputvectors.
	
	setpoint16		 : out std_logic_vector(15 downto 0);
	setpoint32		 : out std_logic_vector(31 downto 0);
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
    pif_re	     : in std_logic_vector(0 downto 0);
    -- Write enable strobe
    pif_we	     : in std_logic_vector(0 downto 0);
    -- Write strobes. This signal indicates which byte lanes hold
    --   valid data. There is one write strobe bit for each eight
    --   bits of the write data bus.    
    pif_be	     : in std_logic_vector((PIF_DATA_LENGTH/8)-1 downto 0);
    -- Read data
    rdata_2pif	     : out std_logic_vector(PIF_DATA_LENGTH-1 downto 0);
    -- Register read and write access acknowledge
    ack_2pif         : out std_logic

  );
  
end lab4_reg;

