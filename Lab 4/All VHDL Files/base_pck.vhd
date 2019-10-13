use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

--library novalib;
--use novalib.nova_pck.all;

library std_developerskit;
use std_developerskit.all;

package base_pck is
  
  constant ADDRESS_LENGTH : natural:= 32;
  constant DATA_LENGTH    : natural:= 32;

  type sl_ptr is access std_logic;
  type slv_ptr is access std_logic_vector;
   
  function hex (data : std_logic_vector; n : integer) return std_logic_vector;
  function lv2str (data : std_logic_vector) return string;
  function lv2strx (data : std_logic_vector; n : integer) return string;
  function strip (data : string) return string;
  procedure writef (file log : text; constant cycle : in integer; msg : in string);
  procedure writef (file log : text; constant cycle : in integer;
                    msg : in string; constant error_no : in integer);
  procedure writef (file log : text;
                    msg : in string; constant error_no : in integer);
  procedure writef (file log : text; msg : in string);
  procedure clk_gen (signal clk : out std_logic;
		     signal cycle_no : inout natural; 
		     signal run : in std_logic;
		     constant period : in time;
		     constant high   : in time;
		     constant offset : in time);
  procedure clk_gen_changing (signal clk : out std_logic;
		     signal cycle_no : inout natural; 
		     signal run : in std_logic;
		     signal period : in  time;
		     signal high   : in  time;
		     constant offset : in  time);
  procedure clk_gen_np (signal clk_p : out std_logic;
			signal clk_n : out std_logic;
		        signal cycle_no : inout natural; 
		        signal run : in std_logic;
		        constant period : in  time;
		        constant high   : in  time;
		        constant offset : in  time);
  procedure str_gen (signal str_n : out std_logic;
		     signal rst_n : in std_logic;
		     signal clk   : in std_logic;
		     signal run   : in std_logic;
		     constant str_time : in natural;
		     constant period_length : in natural);
  procedure str_gen_n (signal str_n : out std_logic;
		       signal rst_n : in std_logic;
		       signal clk   : in std_logic;
		       signal run   : in std_logic;
		       constant str_time : in natural;
		       constant period_length : in natural);
  procedure str_gen_np (signal str_p : out std_logic;
             signal str_n : out std_logic;            
		       signal rst_n : in std_logic;
		       signal clk   : in std_logic;
		       signal run   : in std_logic;
		       constant str_time : in natural;
		       constant period_length : in natural);
  procedure random_gen (signal rst_n       : in std_logic;
			signal clk         : in std_logic;
			signal run_random  : in std_logic;
			signal random_data : out std_logic;
			signal run         : in std_logic);
  procedure random_gen (constant WIDTH : in natural range 2 to 32;
         signal seed        : in std_logic_vector;
         signal loopmode    : in boolean;
         signal rst_n       : in std_logic;
			signal clk         : in std_logic;
			signal run_random  : in std_logic;
			signal random_data : out std_logic;
			signal run         : in std_logic);
  function power(size : natural) return natural;
  
------------------------------------------------
-- This procedure removes leading spaces
------------------------------------------------
  procedure rm_space (l : inout line);
  
-----------------------------------------------------------
--  This procedure read a word from line and returns a
--    string containing the word until first ' ', NBSP or HT
--  The actual length of the word is returned and
--    the string word is converted to lower.
-----------------------------------------------------------
  procedure readword ( l        : inout line;
		                 l_width  : out natural;
		                 word     : out string);

---------------------------------------------------------------
-- This procedure returns the length of the line; max 40 
---------------------------------------------------------------
  procedure string_length(l : inout line; value : out natural);

---------------------------------------------------------------
-- This procedure removes char up to the specified character
---------------------------------------------------------------
  procedure find_char(l : inout line;
                      constant char : character);
  
end package base_pck;



















