use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library std_developerskit;
use std_developerskit.std_iopak.all;

package body base_pck is

  -- convert hex of type x"AF" to shorter vectors
  function hex (data : std_logic_vector;
                n : integer)
    return std_logic_vector is      
    variable ptr : slv_ptr;
    variable local_data : std_logic_vector(data'range) := data;
  begin
    assert (n <= local_data'length)
      report "Initialization vector too short"
      severity ERROR;
      
    ptr := new std_logic_vector'(local_data((local_data'length - n) to (local_data'length - 1)));
    return ptr.all;
  end hex;
  
  -- Rounds value up to neareast length multiple of 4; i.e. 4*round_up_val>=n
  function round_up4 (n : integer)
    return integer is
    variable round_up_val : integer:= n/4;
  begin
    if (n rem 4) /= 0 then
      round_up_val := round_up_val+1;
    end if;
    return round_up_val;
  end round_up4;

  -- convert std_logic_vector to string

  function lv2str (data : std_logic_vector)
    return string is
    variable local_data : std_logic_vector(data'range) := data;
    variable str : string(local_data'length downto 1);
  begin
    for i in 1 to local_data'length loop
      case local_data(i-1) is 
        when 'U' => str(i) := 'U';
        when 'X' => str(i) := 'X';
        when '0' => str(i) := '0';
        when '1' => str(i) := '1';
        when 'Z' => str(i) := 'Z';
        when 'W' => str(i) := 'W';
        when 'L' => str(i) := 'L';
        when 'H' => str(i) := 'H';
        when '-' => str(i) := '-';                      
        when others => str(i) := '?';
      end case;
    end loop;
    return str;
  end lv2str;

  -- convert std_logic_vector to string in hex format
  function lv2strx (data : std_logic_vector;
                    n : integer)
    return string is
    variable m : integer:= round_up4(n);
    variable local_data : std_logic_vector(data'range) := data;
    variable str    : string(m downto 1); 
    variable vector : std_logic_vector((m*4)-1 downto 0);
    variable nibble : std_logic_vector(3 downto 0);
  begin
    vector := (others => '0'); --clear data
    vector(local_data'length-1 downto 0) := local_data;
    
    for i in 1 to m loop
      nibble := vector(i*4-1 downto (i-1)*4);
      
      case nibble is
        when "0000" => str(i) := '0';
        when "0001" => str(i) := '1';
        when "0010" => str(i) := '2';
        when "0011" => str(i) := '3';
        when "0100" => str(i) := '4';
        when "0101" => str(i) := '5';
        when "0110" => str(i) := '6';
        when "0111" => str(i) := '7';
        when "1000" => str(i) := '8';
        when "1001" => str(i) := '9';
        when "1010" => str(i) := 'A';
        when "1011" => str(i) := 'B';
        when "1100" => str(i) := 'C';
        when "1101" => str(i) := 'D';
        when "1110" => str(i) := 'E';
        when "1111" => str(i) := 'F';
        when others => str(i) := 'X';
      end case;
    end loop;
    return str;
  end lv2strx;

  -- remove blank tail characters
  function strip (data : string)
    return string is
    variable index : natural:= 1;
  begin
    for i in data'length downto 1 loop
      if data(i)/=' ' then
        index:= i;
        exit;
      end if;     
    end loop;
    return data(1 to index);
  end strip;

  -- Write message to logfile
  procedure writef (file log : text;
                    constant cycle : in integer;
                    msg : in string) is
    variable BufLine : line;
  begin
    write(BufLine,cycle,right,5);
    write(Bufline,string'(" "));
    write(BufLine,msg); -- write message into buffer
    writeline(log,Bufline); -- exit buffer to standard output
  end writef;
  
  procedure writef (file log : text;
                    constant cycle : in integer;
                    msg : in string;
		    constant error_no : in integer) is
    variable BufLine : line;
  begin
    write(BufLine,cycle,right,5);
    write(Bufline,string'(" "));
    write(BufLine,msg); -- write message into buffer
    write(BufLine,error_no,right,5);    
    writeline(log,Bufline); -- exit buffer to standard output
  end writef;
  
   procedure writef (file log : text;
                    msg : in string;
		    constant error_no : in integer) is
    variable BufLine : line;
  begin
    write(BufLine,msg); -- write message into buffer
    write(BufLine,error_no,right,5);    
    writeline(log,Bufline); -- exit buffer to standard output
  end writef;
 
  -- Write message to logfile
  procedure writef (file log : text;
                    msg : in string) is
    variable BufLine : line;
  begin
    write(BufLine,msg); -- write message into buffer
    writeline(log,Bufline); -- exit buffer to standard output
  end writef;

  procedure clk_gen (signal clk : out std_logic;
		     signal cycle_no : inout natural; 
		     signal run : in std_logic;
		     constant period : in  time;
		     constant high   : in  time;
		     constant offset : in  time ) is
    constant low : time:= period - offset - high;
  begin
    loop 
      cycle_no<= cycle_no + 1; 
      wait for offset;
      clk <= '1';
      wait for high;
      clk <= '0';
      wait for low;
      if (run = '0') then
        wait;
      end if;
    end loop;
  end procedure clk_gen;
  
  procedure clk_gen_changing (signal clk : out std_logic;
		     signal cycle_no : inout natural; 
		     signal run : in std_logic;
		     signal period : in  time;
		     signal high   : in  time;
		     constant offset : in  time ) is
  begin
    loop 
      cycle_no<= cycle_no + 1; 
      wait for offset;
      clk <= '1';
      wait for high;
      clk <= '0';
      wait for period-offset-high;
      if (run = '0') then
        wait;
      end if;
    end loop;
  end procedure clk_gen_changing;
  
  
  procedure clk_gen_np (signal clk_p : out std_logic;
			signal clk_n : out std_logic;
		        signal cycle_no : inout natural; 
		        signal run : in std_logic;
		        constant period : in  time;
		        constant high   : in  time;
		        constant offset : in  time ) is
    constant low : time:= period - offset - high;
  begin
    loop
      cycle_no<= cycle_no + 1; 
      wait for offset;
      clk_p <= '1';
      clk_n <= '0';
      wait for high;
      clk_p <= '0';
      clk_n <= '1';
      wait for low;
      if (run = '0') then
        wait;
      end if;
    end loop;
  end procedure clk_gen_np;
  

  procedure str_gen (signal str_n : out std_logic;
		     signal rst_n : in std_logic;
		     signal clk   : in std_logic;
		     signal run   : in std_logic;
		     constant str_time : in natural;
		     constant period_length : in natural) is
    
    constant str_time_i : unsigned(power(period_length)-1 downto 0):=
                          to_unsigned(str_time, power(period_length));
    variable clk_cnt: unsigned(power(period_length)-1 downto 0);
    
  begin
    loop
      wait until rising_edge(clk);
      if rst_n='0' then
	str_n <= '0';
	clk_cnt := (others => '0');
      else
        if clk_cnt = str_time_i then
  	  str_n <= '1';
        else
          str_n <= '0'; 
        end if;
	clk_cnt := clk_cnt+1;
      end if;
      if (run = '0') then
        wait;
      end if;
    end loop;
  end procedure str_gen;

  
  procedure str_gen_n (signal str_n : out std_logic;
		       signal rst_n : in std_logic;
		       signal clk   : in std_logic;
		       signal run   : in std_logic;
		       constant str_time : in natural;
		       constant period_length : in natural) is
    
    constant str_time_i : unsigned(power(period_length)-1 downto 0):=
                          to_unsigned(str_time, power(period_length));
    variable clk_cnt: unsigned(power(period_length)-1 downto 0);
    
  begin
    loop
      wait until rising_edge(clk);
      if rst_n='0' then
	str_n <= '1';
	clk_cnt := (others => '0');
      else
        if clk_cnt = str_time_i then
  	  str_n <= '0';
        else
          str_n <= '1'; 
        end if;
	clk_cnt := clk_cnt+1;
      end if;
      if (run = '0') then
        wait;
      end if;
    end loop;
  end procedure str_gen_n;

  procedure str_gen_np (signal str_p : out std_logic;
             signal str_n : out std_logic;           
		       signal rst_n : in std_logic;
		       signal clk   : in std_logic;
		       signal run   : in std_logic;
		       constant str_time : in natural;
		       constant period_length : in natural) is
    
    constant str_time_i : unsigned(power(period_length)-1 downto 0):=
                          to_unsigned(str_time, power(period_length));
    variable clk_cnt: unsigned(power(period_length)-1 downto 0);
    
  begin
    loop
      wait until rising_edge(clk);
      if rst_n='0' then
        str_p <= '0';
        str_n <= '1';
	     clk_cnt := (others => '0');
      else
        if clk_cnt = str_time_i then
          str_p <= '1';
  	       str_n <= '0';
        else
          str_p <= '0'; 
          str_n <= '1'; 
        end if;
  	     clk_cnt := clk_cnt+1;
      end if;
      if (run = '0') then
        wait;
      end if;
    end loop;
  end procedure str_gen_np;


  procedure random_gen (signal rst_n       : in std_logic;
			signal clk         : in std_logic;
			signal run_random  : in std_logic;
			signal random_data : out std_logic;
			signal run         : in std_logic ) is
    
  type taps_array_type is array (2 to 32) of std_logic_vector(31 downto 0);
  
  constant TAPS_ARRAY : taps_array_type :=
    (2  => (0|1       => '1', others => '0'),
     3  => (0|2       => '1', others => '0'),
     4  => (0|3       => '1', others => '0'),
     5  => (1|4       => '1', others => '0'),
     6  => (0|5       => '1', others => '0'),
     7  => (0|6       => '1', others => '0'),
     8  => (1|2|3|7   => '1', others => '0'),
     9  => (3|8       => '1', others => '0'),
     10 => (2|9       => '1', others => '0'),
     11 => (1|10      => '1', others => '0'),
     12 => (0|3|5|11  => '1', others => '0'),
     13 => (0|2|3|12  => '1', others => '0'),
     14 => (0|2|4|13  => '1', others => '0'),
     15 => (0|14      => '1', others => '0'),
     16 => (1|2|4|15  => '1', others => '0'),
     17 => (2|16      => '1', others => '0'),
     18 => (6|17      => '1', others => '0'),
     19 => (0|1|14|18 => '1', others => '0'),
     20 => (2|19      => '1', others => '0'),
     21 => (1|20      => '1', others => '0'),
     22 => (0|21      => '1', others => '0'),
     23 => (4|22      => '1', others => '0'),
     24 => (0|2|3|23  => '1', others => '0'),
     25 => (2|24      => '1', others => '0'),
     26 => (0|1|15|25 => '1', others => '0'),
     27 => (0|1|14|26 => '1', others => '0'),
     28 => (2|27      => '1', others => '0'),
     29 => (1|28      => '1', others => '0'),
     30 => (0|3|5|29  => '1', others => '0'),
     31 => (2|30      => '1', others => '0'),
     32 => (1|5|6|31  => '1', others => '0'));
    
    constant WIDTH : natural := 32;
    constant SEED  : natural := 21;

    variable bits0_nminus2_zero : std_logic;
    variable feedback           : std_logic;
    
    variable taps : std_logic_vector(WIDTH - 1 downto 0);
    variable lfsr_reg : std_logic_vector(WIDTH - 1 downto 0);
    variable lfsr_reg_temp : std_logic_vector(WIDTH - 1 downto 0);

  begin
    
    taps := TAPS_ARRAY(WIDTH)(WIDTH - 1 downto 0);

    loop
      
      if run='0' then
	wait;     
      elsif rst_n = '0' then
        random_data<= '0';
        lfsr_reg := std_logic_vector(to_unsigned(SEED, WIDTH));
        lfsr_reg_temp := (others => '0');
      elsif falling_edge(clk) then
        if run_random = '1' then
          bits0_nminus2_zero := '0';
          for n in 0 to WIDTH - 2 loop
            bits0_nminus2_zero := bits0_nminus2_zero or lfsr_reg(n);
          end loop;
          feedback := lfsr_reg(WIDTH - 1) xor (not bits0_nminus2_zero);
          for n in 1 to WIDTH - 1 loop
            if (taps(n - 1) = '1') then	  
              lfsr_reg_temp(n) := lfsr_reg(n - 1) xor feedback;
            else
              lfsr_reg_temp(n) := lfsr_reg(n - 1);
            end if;
          end loop;      
          random_data <= lfsr_reg(0);
          lfsr_reg_temp(0) := feedback;
          lfsr_reg := lfsr_reg_temp;
       end if;   
      end if;

      wait until falling_edge(clk);
   
   end loop;
      
  end procedure random_gen;      

  procedure random_gen (constant WIDTH : in natural range 2 to 32;
         signal seed        : in std_logic_vector;
         signal loopmode    : in boolean;
         signal rst_n       : in std_logic;
			signal clk         : in std_logic;
			signal run_random  : in std_logic;
			signal random_data : out std_logic;
			signal run         : in std_logic) is      
    
  type taps_array_type is array (2 to 32) of std_logic_vector(31 downto 0);
  
  constant TAPS_ARRAY : taps_array_type :=
    (2  => (0|1       => '1', others => '0'),
     3  => (0|2       => '1', others => '0'),
     4  => (0|3       => '1', others => '0'),
     5  => (1|4       => '1', others => '0'),
     6  => (0|5       => '1', others => '0'),
     7  => (0|6       => '1', others => '0'),
     8  => (1|2|3|7   => '1', others => '0'),
     9  => (3|8       => '1', others => '0'),
     10 => (2|9       => '1', others => '0'),
     11 => (1|10      => '1', others => '0'),
     12 => (0|3|5|11  => '1', others => '0'),
     13 => (0|2|3|12  => '1', others => '0'),
     14 => (0|2|4|13  => '1', others => '0'),
     15 => (0|14      => '1', others => '0'),
     16 => (1|2|4|15  => '1', others => '0'),
     17 => (2|16      => '1', others => '0'),
     18 => (6|17      => '1', others => '0'),
     19 => (0|1|14|18 => '1', others => '0'),
     20 => (2|19      => '1', others => '0'),
     21 => (1|20      => '1', others => '0'),
     22 => (0|21      => '1', others => '0'),
     23 => (4|22      => '1', others => '0'),
     24 => (0|2|3|23  => '1', others => '0'),
     25 => (2|24      => '1', others => '0'),
     26 => (0|1|15|25 => '1', others => '0'),
     27 => (0|1|14|26 => '1', others => '0'),
     28 => (2|27      => '1', others => '0'),
     29 => (1|28      => '1', others => '0'),
     30 => (0|3|5|29  => '1', others => '0'),
     31 => (2|30      => '1', others => '0'),
     32 => (1|5|6|31  => '1', others => '0'));
    
    variable bits0_nminus2_zero : std_logic;
    variable feedback           : std_logic;
    
    variable taps : std_logic_vector(WIDTH - 1 downto 0);
    variable lfsr_reg : std_logic_vector(WIDTH - 1 downto 0);
    variable lfsr_reg_temp : std_logic_vector(WIDTH - 1 downto 0);

  begin
    
    taps := TAPS_ARRAY(WIDTH)(WIDTH-1 downto 0);

    loop
      
      if run='0' then
   	  exit;
      elsif rst_n = '0' then
        random_data<= '0';
        lfsr_reg := SEED;
        lfsr_reg_temp := (others => '0');
      elsif falling_edge(clk) then
        if run_random = '1' then
          if loopmode then
            lfsr_reg := lfsr_reg(WIDTH-2 downto 0) & lfsr_reg(WIDTH-1);
            random_data <= lfsr_reg(0);
          else
            bits0_nminus2_zero := '0';
            for n in 0 to WIDTH - 2 loop
              bits0_nminus2_zero := bits0_nminus2_zero or lfsr_reg(n);
            end loop;
            feedback := lfsr_reg(WIDTH - 1) xor (not bits0_nminus2_zero);
            for n in 1 to WIDTH - 1 loop
              if (taps(n - 1) = '1') then	  
                lfsr_reg_temp(n) := lfsr_reg(n - 1) xor feedback;
              else
                lfsr_reg_temp(n) := lfsr_reg(n - 1);
              end if;
            end loop;      
            random_data <= lfsr_reg(0);
            lfsr_reg_temp(0) := feedback;
            lfsr_reg := lfsr_reg_temp;
          end if;
        end if; 
      end if;

      wait until falling_edge(clk);

    end loop;

    wait;
      
  end procedure random_gen;

  function power(size : natural) return natural is
    variable x : natural;
    variable remainder : natural;
    variable cnt : natural;
  begin
    x := Size;
    cnt := 0;

    for i in size downto 0 loop
      remainder:= x rem 2;
      x := (x / 2) + remainder;
      cnt := cnt + 1;
      if x <= 1 then
        return cnt;
      end if;
    end loop;
  end power;
  
---------------------------------------------------------------
-- This procedure removes leading spaces
---------------------------------------------------------------
  procedure rm_space(l : inout line) is
    variable l_tmp : line:= l;
    variable skipchar : character;
    variable index : natural;
  begin
    index:= l'low;
    while l'length>0 and index<=l'high loop
       if l_tmp(index)=' ' or
          l(index)=character'val(160) or
          l(index)=HT then
         index:= index+1;
       else
         exit;
       end if;
    end loop;
    if l'length=0 or index>l'high then
      l:= null;
    else
      l:= new string'(l_tmp(index to l_tmp'high));
    end if;
    deallocate(l_tmp);
  end procedure rm_space;
        
----------------------------------------------------------------
--  This procedure read a word from line and returns
--    a string containing the word until first ' ', NBSP, HT or +
--  The actual length of the word is returned and
--    the string word is converted to lower.
----------------------------------------------------------------
  procedure readword(l        : inout line;
		               l_width  : out natural;
		               word     : out string) is
    variable word_tmp    : string(word'range); -- range given by word
    variable char_tmp    : character;
    variable l_width_tmp : natural;
    
  begin
    word_tmp := (others => ' ');
    l_width_tmp:= 0;
    rm_space(l);
    if (l /= NULL) then
      l_width_tmp:= word_tmp'left;
      while l'length>0 and
            not (l(l'left)=' ' or
                 l(l'left)=character'val(160) or -- Non Blank SPace
                 l(l'left)=HT or
                 l(l'left)='+') loop
        read(l,word_tmp(l_width_tmp));
        l_width_tmp:= l_width_tmp+1;        
      end loop;
    end if;
    l_width := l_width_tmp-1;
    word := to_lower(word_tmp);  -- std_iopak
    
  end procedure readword;     

---------------------------------------------------------------
-- This procedure returns the length of the line; max 40 
---------------------------------------------------------------
  procedure string_length(l : inout line; value : out natural) is
  begin
    if l'high<40 then
      value:= l'high;
    else
      value:= 40;
    end if;
  end procedure string_length;

---------------------------------------------------------------
-- This procedure removes char up to the specified character
---------------------------------------------------------------
  procedure find_char(l : inout line;
                      constant char : character) is
    variable l_tmp : line:= l;
    variable skipchar : character;
    variable index : natural;
  begin
    index:= l'low;
    while l'length>0 and index<=l'high loop
      if l_tmp(index)=char then
        index:= index+1;
        exit;
      end if;
      index:= index+1;
     end loop;
    if l'length=0 or index>l'high then
      l:= null;
    else
      l:= new string'(l_tmp(index to l_tmp'high));
    end if;
    deallocate(l_tmp);
  end procedure find_char;
  
---------------------------------------------------------------
-- This procedure removes char up to the specified character
--   and also returns the character before searched character
---------------------------------------------------------------
  procedure find_char(l : inout line;
                      constant char : character;
                      lastchar : out character) is
    variable l_tmp : line:= l;
    variable skipchar : character;
    variable index : natural;
  begin
    index:= l'low;
    lastchar:= ' ';
    while l'length>0 and index<=l'high loop
      if l_tmp(index)=char then
        lastchar:= l_tmp(index-1);
        index:= index+1;
        exit;
      end if;
      index:= index+1;
     end loop;
    if l'length=0 or index>l'high then
      l:= null;
    else
      l:= new string'(l_tmp(index to l_tmp'high));
    end if;
    deallocate(l_tmp);
  end procedure find_char;
        
end package body base_pck;
