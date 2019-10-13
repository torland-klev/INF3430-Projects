library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl1 of p_ctrl is
-- component instantiations
	signal err : signed(7 downto 0):= (others => '0');
	
begin
	process (clk, rst) is
		type state_type is (idle_st, sampel_st, motor_st);
		variable state: state_type;
	begin
		if (rst = '1') then
			state := idle_st;
		
		elsif (rising_edge(clk)) then
			case state is
				when idle_st =>
					motor_cw <= '0';
					motor_ccw <= '0';
					--sp <= "00000000";
					--pos <= "00000000";
					
					err <= "00000000";
					state := sampel_st;
					
				when sampel_st =>
					err <= sp-pos;
					state := motor_st;
					
				when motor_st =>
					if (err > "00000000") then
						motor_cw <= '1';
						motor_ccw <= '0';
						state := sampel_st;
					elsif (err < "00000000") then
						motor_cw <= '0';
						motor_ccw <= '1';
						state := sampel_st;
					else
						motor_cw <= '0';
						motor_ccw <= '0';
						state := sampel_st;
					end if;
			
			end case;
		end if;
		
	end process;
end architecture rtl1;