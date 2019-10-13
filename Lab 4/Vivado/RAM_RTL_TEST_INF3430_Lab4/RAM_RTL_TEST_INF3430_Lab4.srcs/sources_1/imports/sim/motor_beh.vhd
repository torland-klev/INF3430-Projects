library ieee;
use ieee.std_logic_1164.all;

architecture motor_beh of motor is

begin

  motor_moving : process
  begin

    a <= '0';
    b <= '0';

    while run='1' loop      
      if motor_cw = '1' and motor_ccw = '0' then
        a <= '0';
        wait for phase90;
        b <= '1';
        wait for phase90;
        a <= '1';
        wait for phase90;
        b <= '0';
      elsif motor_ccw = '1' and motor_cw = '0' then
        a <= '1';
        wait for phase90;
        b <= '1';
        wait for phase90;
        a <= '0';
        wait for phase90;
        b <= '0';
      end if;
      wait for phase90;
    end loop;

    wait;

  end process;
  
end architecture motor_beh;
