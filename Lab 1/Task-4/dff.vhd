library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DFF is
  port
    (
      CLK : in  std_logic;
      D   : in  std_logic;
      Q   : out std_logic
      );
end entity DFF;

architecture RTL_DFF of DFF is
begin
  process(CLK)
  begin
    if rising_edge(CLK) then
      Q <= D;
    end if;
  end process;
end architecture RTL_DFF;




