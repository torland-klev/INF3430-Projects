library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ram_lab4 is
  Port ( 
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 9 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end ram_lab4;

architecture rtl of ram_lab4 is
begin

  memory: process (rsta, clka) is
    type memory_array is array (0 to 1023) of std_logic_vector(31 downto 0);
    variable lab4_memory : memory_array;
  begin
    if rsta='1' then
      lab4_memory := (others => x"DEADBEEF");
      douta <= (others => '0');
    elsif rising_edge(clka) then
      if ena='1' then
        if wea /= "0000" then
           if wea(0)='1' then
             lab4_memory(to_integer(unsigned(addra)))(7 downto 0) := dina(7 downto 0);
           end if;
           if wea(1)='1' then
             lab4_memory(to_integer(unsigned(addra)))(15 downto 8) := dina(15 downto 8);
           end if;
           if wea(2)='1' then
             lab4_memory(to_integer(unsigned(addra)))(23 downto 16) := dina(23 downto 16);
           end if;
           if wea(3)='1' then
             lab4_memory(to_integer(unsigned(addra)))(31 downto 24) := dina(31 downto 24);
           end if;
         else
           douta <= lab4_memory(to_integer(unsigned(addra)))(31 downto 0);
         end if;                       
      end if;      
    end if;   
  end process memory;
end;
