library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture str of pos_seg7_ctrl is 

-- Component instantiations
component cru
	port (
		arst 	 : in std_logic;
		refclk	 : in std_logic;
		rst		 : out std_logic;
		rst_div  : out std_logic;
		mclk	 : out std_logic;
		mclk_div : out std_logic
	);
end component;

component pos_ctrl
	port (
		rst, rst_div, mclk, mclk_div, sync_rst, a, b, force_cw, force_ccw : in std_logic;
		sp : in std_logic_vector (7 downto 0);
		motor_cw, motor_ccw : out std_logic;
		pos : out std_logic_vector(7 downto 0)
	);
end component;

component seg7_ctrl
	port (
		mclk, rst : in std_logic;
		pos1 : in std_logic_vector(7 downto 0);
		sp  : in std_logic_vector (7 downto 0);
		dec : in std_logic_vector (3 downto 0);
		abcdefgdec_n : out std_logic_vector(7 downto 0);
		a_n : out std_logic_vector(3 downto 0)
	);
end component;

signal rst_i, rst_div_i, mclk_i, mclk_div_i : std_logic := '0';
signal pos_i : std_logic_vector(7 downto 0) := (others => '0');
signal dec_i : std_logic_vector(3 downto 0) := (others => '0');

begin
	
	CLOCK_RESET_UNIT: 
	cru port map (
		arst => arst,
		refclk => refclk,
		rst => rst_i,
		rst_div => rst_div_i,
		mclk => mclk_i,
		mclk_div => mclk_div_i
	);
	
	POS_CONTROL: 
	pos_ctrl port map (
		rst => rst_i,
		rst_div => rst_div_i,
		mclk => mclk_i,
		mclk_div => mclk_div_i,
		sync_rst => sync_rst,
		sp => sp,
		a => a,
		b => b,
		pos => pos_i,
		force_cw => force_cw,
		force_ccw => force_ccw,
		motor_cw => motor_cw,
		motor_ccw => motor_ccw
	);

	
	SEG7_CONTROL: 
	seg7_ctrl port map(
		mclk => mclk_i,
		rst => rst_i,
		pos1 => pos_i,
		sp => sp,
		dec => dec_i,
		abcdefgdec_n => abcdefgdec_n,
		a_n => a_n
	);
	
	
end str;