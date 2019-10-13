vcom -work work -93 -explicit -vopt M:/pc/Desktop/INF3430/Lab-1/Task-1/first.vhd
vcom -work work -93 -explicit -vopt M:/pc/Desktop/INF3430/Lab-1/Task-1/tb_first.vhd
vsim work.test_first
add wave sim:/test_first/*
run 1us