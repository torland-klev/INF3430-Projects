set_property PACKAGE_PIN U21 [get_ports {COUNT[3]}]
set_property PACKAGE_PIN U22 [get_ports {COUNT[2]}]
set_property PACKAGE_PIN T21 [get_ports {COUNT[1]}]
set_property PACKAGE_PIN T22 [get_ports {COUNT[0]}]
set_property PACKAGE_PIN F21 [get_ports {INP[3]}]
set_property PACKAGE_PIN H22 [get_ports {INP[2]}]
set_property PACKAGE_PIN G22 [get_ports {INP[1]}]
set_property PACKAGE_PIN F22 [get_ports {INP[0]}]
set_property PACKAGE_PIN T18 [get_ports CLK]
set_property PACKAGE_PIN M15 [get_ports LOAD]
set_property PACKAGE_PIN U14 [get_ports MAX_COUNT]
set_property PACKAGE_PIN P16 [get_ports RESET]
set_property PACKAGE_PIN H17 [get_ports UP]
set_property PACKAGE_PIN U19 [get_ports MIN_COUNT]

#set_property IOSTANDARD LVCMOS33 [get_ports {COUNT[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {COUNT[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {COUNT[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {COUNT[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {INP[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {INP[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {INP[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {INP[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports CLK]
#set_property IOSTANDARD LVCMOS33 [get_ports LOAD]
#set_property IOSTANDARD LVCMOS33 [get_ports MAX_COUNT]
#set_property IOSTANDARD LVCMOS33 [get_ports RESET]
#set_property IOSTANDARD LVCMOS33 [get_ports UP]
#set_property IOSTANDARD LVCMOS33 [get_ports MIN_COUNT]

set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]];
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 34]];
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 35]];
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CLK]

create_clock -period 20.000 -waveform {0.000 10.000} [get_ports CLK]

