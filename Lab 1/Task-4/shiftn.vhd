library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Assuming SIPO shift register, as type not specified.

entity SHIFTN is
  generic (N : integer);
  port(
    clk, sin  : in STD_LOGIC;
    sout      : out STD_LOGIC_VECTOR(N-1 downto 0)
  );

end SHIFTN;

architecture SHIFT of SHIFTN is

component DFF is
  port(
    clk,D : in STD_LOGIC;
    Q     : out STD_LOGIC
  );

end component DFF; 

signal Z: std_logic_vector (N-1 downto 0);


begin
  z(0)<=sin;
  GEN_SHIFT : for i in 0 to N-2 generate
    DFFx : DFF port map(clk,z(i),z(i+1));
  end generate GEN_SHIFT;

sout<=z;

end SHIFT;
