library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Assuming SIPO shift register, as type not specified.

entity SHIFT32 is
  port(
    clk, sin  : in STD_LOGIC;
    sout      : out STD_LOGIC_VECTOR(31 downto 0)
  );

end SHIFT32;

architecture SHIFT of SHIFT32 is

component DFF is
  port(
    clk,D : in STD_LOGIC;
    Q     : out STD_LOGIC
  );

end component DFF; 

signal Z : std_logic_vector (31 downto 0);


begin
  z(0)<=sin;
  GEN_SHIFT : for i in 0 to 30 generate
    DFFx : DFF port map(clk,z(i),z(i+1));
  end generate GEN_SHIFT;

sout<=z;

end SHIFT;
