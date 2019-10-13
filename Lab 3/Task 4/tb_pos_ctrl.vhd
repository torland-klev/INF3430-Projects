library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pos_ctrl is
end tb_pos_ctrl;

architecture rtl1 of tb_pos_ctrl is

-- Components needed are POS_CTRL and MOTOR
-- Component declarations

component motor is
	generic ( phase90 : time := 20 ns);
	port (
		motor_cw  : in  std_logic;
		motor_ccw : in  std_logic;
		a         : out std_logic;
		b         : out std_logic );  
end component;  

component pos_ctrl is
  port (
    rst       : in  std_logic;          		  -- Reset
    rst_div   : in  std_logic;          		  -- Reset
    mclk      : in  std_logic;          		  -- Clock
    mclk_div  : in  std_logic;          		  -- Clock to p_reg
    sync_rst  : in  std_logic;          		  -- Synchronous reset
    sp        : in  signed(7 downto 0);  		  -- Setpoint (wanted position)
    a         : in  std_logic;          		  -- From position sensor
    b         : in  std_logic;          		  -- From position sensor
    pos       : out std_logic_vector(7 downto 0); -- Measured Position
    force_cw  : in  std_logic;          		  -- Force motor clock wise motion
    force_ccw : in  std_logic;  				  -- Force motor counter clock wise motion
    motor_cw  : out std_logic;          		  -- Motor clock wise motion
    motor_ccw : out std_logic           		  -- Motor counter clock wise motion
    );      
end component;

-- Signal declarations

-- INPUTS
	signal mclk, mclk_div 			: std_logic := '0';
	signal rst_div, rst, sync_rst	: std_logic := '0';
	signal force_cw, force_ccw		: std_logic := '0';

	signal sp						: signed(7 downto 0) := (others => '0');
	
	signal a_i, b_i					: std_logic;
	
-- OUTPUTS	
	signal motor_cw_i, motor_ccw_i	: std_logic := '0';
	signal pos 						: std_logic_vector(7 downto 0) := (others => '0');
	
	constant mclk_half_period		: time := 5 ns;
	constant mclk_period 	 		: time := 10 ns;
	constant mclk_div_half_period	: time := 640 ns;
	constant mclk_div_period		: time := 1280 ns;

begin
	
	-- Port mapping
	MOTOR_0: motor 
	generic map(phase90 => 20 ns)
	port map(
		motor_cw => motor_cw_i,
		motor_ccw => motor_ccw_i,
		a => a_i,
		b => b_i
	);
	
	POS_CONTROL: pos_ctrl port map(
		force_cw => force_cw,
		force_ccw => force_ccw,
		rst_div => rst_div,
		mclk_div => mclk_div,
		sp => sp,
		rst => rst,
		mclk => mclk,
		sync_rst => sync_rst,
		a => a_i,
		b => b_i,
		motor_cw => motor_cw_i,
		motor_ccw => motor_ccw_i,
		pos => pos
	);
	
	-- Clock processes
	CLOCK: process
	begin
		mclk <= '0';
		wait for mclk_half_period;
		mclk <= '1';
		wait for mclk_half_period;
	end process CLOCK;
	
	CLOCK_DIV: process
	begin
		mclk_div <= '0';
		wait for mclk_div_half_period;
		mclk_div <= '1';
		wait for mclk_div_half_period;
	end process CLOCK_DIV;
	
	-- Stimuli
	STIMULI: process 
	begin
		sp <= "00011100";
		wait for mclk_div_period*40;
		force_cw <= '1';
		wait for mclk_div_period*10;
		force_ccw <= '1';
		wait for mclk_div_period*3;
		force_cw <= '0';
		wait for mclk_div_period*10;
		force_ccw <= '0';
		wait for mclk_div_period*15;
		sp <= "01110011";
		wait;
	end process STIMULI;
	
end rtl1;