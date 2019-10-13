--This is a comment,which end here
--this is a new comment
library IEEE; --makes the library IEEE visible
use IEEE.std_logic_1164.all; --makes use of the package std_logic_1164
use IEEE.numeric_std.all;    --makes use of the package numeric_std

--The entity defines all the signals in and out (inout) of the circuit
--we want to describe
--Please note: VHDL is NOT case sensitive
entity FIRST is 
  port
  (
  --Signalname : <mode> <data_type>; mode: in, out or inout
    CLK        : in  std_logic; -- Clock from switch CLK1/INP1
    RESET      : in  std_logic; -- Global Asynchronous Reset
    LOAD       : in  std_logic; -- Synchronous Reset
	  UP         : in  std_logic;
    INP        : in  std_logic_vector(3 downto 0); -- Start Value
    COUNT      : out std_logic_vector(3 downto 0); -- Counting value
	  MIN_COUNT  : out std_logic;
    MAX_COUNT  : out std_logic  -- Max counting value 
  );
end FIRST;

--The architeture describes the functionality of the entity it belongs to.
--An entity can have many architetures, whereas an architecture can only belong to one
--entity.
--The architecture below describes a 4-bits up-counter, with an asynchronous reset
--and a synchronous reset (LOAD). When the counter reaches it maximum value the signal
--MAX_COUNT goes active

--architecture <architectureName> of <Belonging entity> is
architecture MY_FIRST_ARCH of FIRST is
  
  --Area for declarations internal to the architecture
  --for example internal signals
  
  signal COUNT_I : unsigned(3 downto 0);
  --We will use the signed and/or unsigned data types for arithmetric operations
  --Examples: Arithmetric operators: +,-,* and / Comparations:>,>=,>,<, <=, = and /=
begin
  --Here starts the description
 
  COUNTER: --This is a label which will be visible inside the simulator
  process (RESET,CLK) --sensitivity list, include all input signals to the process
                      --which matters for the functionality of the process
  begin
    --Due to the inherent priority in an if-statement the RESET-signal will have 
    --priority above the CLK if both statement evaluates to TRUE.
    --That is exactly how an asynchronous reset should function.
    if(RESET  = '1') then
      COUNT_I <= "0000";
      --More general statement, which s independant of number of bits
      --COUNT_I <= (others => '0');
    elsif rising_edge(CLK) then --rising_edge(falling_edge) are functions defined in 
                                --the std_logic_1164 package 
    --elsif (CLK'event and CLK = '1') then
      -- Synchronous reset
      if LOAD = '1' then
        COUNT_I <= unsigned(INP); --Type casting from std_logic_vector to unsigned
      elsif UP = '1' then   
        COUNT_I <= COUNT_I + 1; 
	    elsif COUNT_I /= "0000" then 
	      COUNT_I <= COUNT_I - 1; 
      end if;
    end if; 
  end process COUNTER;

  --Concurrent signal assignment (CSA)
  COUNT <= std_logic_vector(COUNT_I);--Type casting from unsigned to std_logic_vector
  
  --Concurrent signal assignment (CSA)
  MAX_COUNT <= '1' when COUNT_I = "1111" else '0';
  MIN_COUNT <= '1' when COUNT_I = "0000" else '0';
  
  --This is 100% equivalent to the process below:
  --Generally a process is easier to read (and understand) if the code is indented 
  --properly, but for small statements like the one above it is ok to use a CSA.
  
  --process (COUNT_I)
  --begin
  --  if COUNT_I = "1111" then
  --      MAX_COUNT <= '1';
  --  else
  --      MAX_COUNT <= '0';
  --  end if;     
  --end process;  
  
end MY_FIRST_ARCH;
