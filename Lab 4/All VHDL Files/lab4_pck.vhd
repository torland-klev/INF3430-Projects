
library ieee;
use ieee.std_logic_1164.all;

package lab4_pck is
 
  -- ---------------------------------------------------------------------------
  --            GENERAL
  -- ---------------------------------------------------------------------------

  constant PIF_ADDRESS_LENGTH                : natural :=  32;
  constant PIF_DATA_LENGTH                   : natural :=  32;

  constant LAB4REG_REV_STATUS_V              : std_logic_vector(7 downto 0) := x"50";  -- RO U8,8
  constant LAB4REG_REV_LETTER_1_V            : std_logic_vector(7 downto 0) := x"31";  -- RO U8,8
  constant LAB4REG_REV_LETTER_2_V            : std_logic_vector(7 downto 0) := x"31";  -- RO U8,8

  -- ---------------------------------------------------------------------------
  --            RAM BASE ADDRESSES
  -- ---------------------------------------------------------------------------

  constant LAB4RAM_BASE_ADDRESS             : std_logic_vector(31 downto 0) := x"40400000";  -- RW U8,8

  
  -- ---------------------------------------------------------------------------
  --            REGISTER ADDRESSES
  -- ---------------------------------------------------------------------------

  constant LAB4REG_BASE_ADDRESS              : std_logic_vector(31 downto 0) := x"40000000";  --MODULE ADDRESS SPACE START

  -- LAB4REG register module addresses
  constant LAB4REG_REV_STATUS                : std_logic_vector(31 downto 0) := x"40000000";  -- RO U8,8
  constant LAB4REG_REV_LETTER_1              : std_logic_vector(31 downto 0) := x"40000004";  -- RO U8,8
  constant LAB4REG_REV_LETTER_2              : std_logic_vector(31 downto 0) := x"40000008";  -- RO U8,8
  constant LAB4REG_RWTEST                    : std_logic_vector(31 downto 0) := x"4000000C";  -- RW U32,32
  
  constant LAB4REG_SETPOINT                  : std_logic_vector(31 downto 0) := x"40000010";  -- RW U8,8
  
  -- Henriktk: added addresses for new registers
  constant LAB4REG_SETPOINT16                : std_logic_vector(31 downto 0) := x"40000014";  -- RW U16,16
  constant LAB4REG_SETPOINT32                : std_logic_vector(31 downto 0) := x"40000018";  -- RW U32,32

end lab4_pck;
