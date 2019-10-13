library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl1 of pos_meas is
-- component instantiations	
	signal pos_temp : signed(7 downto 0):= (others => '0');
	signal a_i, b_i, sync_rst_i : std_logic := '0';
	
begin
	process (clk, rst, sync_rst) is
		type state_type is (start_up_st, wait_a1_st, wait_a0_st, up_down_st, count_up_st, count_down_st);
		variable state: state_type;
	begin
		if (rst = '1') then
			state := start_up_st;						-- go to idle
			
		elsif (rising_edge(clk)) then
		a_i <= a;
		b_i <= b;
		sync_rst_i <= sync_rst;
			case state is
				when start_up_st =>
					pos_temp <= "00000000";					-- resetting pos_temp value
					if (sync_rst_i = '1') and (sync_rst = sync_rst_i) then
						state := start_up_st;
					elsif (a_i = '0') and (a = a_i) then
						state := wait_a1_st;
					else 
						state := wait_a0_st;
					end if;
					
				when wait_a1_st =>
					if (sync_rst_i = '1') and (sync_rst = sync_rst_i) then
						state := start_up_st;
					elsif (a_i = '0') and (a = a_i) then
						state := wait_a1_st;
					else state := wait_a0_st;
					end if;
					
				when wait_a0_st =>
					if (sync_rst_i = '1') and (sync_rst = sync_rst_i) then
						state := start_up_st;
					elsif (a_i = '0') and (a = a_i) then
						state := up_down_st;
					else state := wait_a0_st;
					end if;
					
				when up_down_st =>
					if (sync_rst_i = '1') and (sync_rst = sync_rst_i) then
						state := start_up_st;
					elsif (b_i = '0') and (b = b_i) then
						state := count_up_st;
					else state := count_down_st;
					end if;
					
				when count_up_st =>
					if (sync_rst_i = '1') and (sync_rst = sync_rst_i) then
						state := start_up_st;
					else
						if (pos_temp < 127) then
							pos_temp <= pos_temp + 1;	
						end if;
						state := wait_a1_st;
						
					end if;
					
				when count_down_st =>
					if (sync_rst_i = '1') and (sync_rst = sync_rst_i) then
						state := start_up_st;
					else
						if (pos_temp > 0) then
							pos_temp <= pos_temp - 1;
						end if;
						state := wait_a1_st;
					end if;
			end case;
			pos <= pos_temp;
		end if;
	
	end process;
end architecture rtl1;