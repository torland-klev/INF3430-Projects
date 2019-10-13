vcom -work work -2002 -explicit -novopt M:/pc/Desktop/INF3430/Lab-1/Task-2/decoder.vhd
vcom -work work -2002 -explicit -novopt M:/pc/Desktop/INF3430/Lab-1/Task-2/tb_decoder.vhd
vsim -voptargs=+acc work.test_decoder
add wave sim:/test_decoder/*
run 1us