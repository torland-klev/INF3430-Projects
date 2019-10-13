create_clock -period 10.000 -name CLK -waveform {0.000 5.000} [get_ports CLK]

set_property IOSTANDARD LVCMOS33 [get_ports {SEL[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEL[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {INP[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {INP[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {INP[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {INP[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {abcdefgdec_n[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {abcdefgdec_n[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {abcdefgdec_n[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {abcdefgdec_n[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {abcdefgdec_n[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {abcdefgdec_n[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {abcdefgdec_n[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {abcdefgdec_n[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {a_n[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {a_n[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {a_n[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {a_n[0]}]

set_property PACKAGE_PIN M15 [get_ports {SEL[1]}]
set_property PACKAGE_PIN H17 [get_ports {SEL[0]}]
set_property PACKAGE_PIN F21 [get_ports {INP[3]}]
set_property PACKAGE_PIN H22 [get_ports {INP[2]}]
set_property PACKAGE_PIN G22 [get_ports {INP[1]}]
set_property PACKAGE_PIN F22 [get_ports {INP[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports CLK]
set_property IOSTANDARD LVCMOS33 [get_ports LOAD]
set_property IOSTANDARD LVCMOS33 [get_ports RESET]
set_property PACKAGE_PIN V12 [get_ports {abcdefgdec_n[7]}]
set_property PACKAGE_PIN W12 [get_ports {abcdefgdec_n[6]}]
set_property PACKAGE_PIN W10 [get_ports {abcdefgdec_n[5]}]
set_property PACKAGE_PIN W11 [get_ports {abcdefgdec_n[4]}]
set_property PACKAGE_PIN V9 [get_ports {abcdefgdec_n[3]}]
set_property PACKAGE_PIN V10 [get_ports {abcdefgdec_n[2]}]
set_property PACKAGE_PIN V8 [get_ports {abcdefgdec_n[1]}]
set_property PACKAGE_PIN W8 [get_ports {abcdefgdec_n[0]}]
set_property PACKAGE_PIN AA8 [get_ports {a_n[3]}]
set_property PACKAGE_PIN AB9 [get_ports {a_n[2]}]
set_property PACKAGE_PIN AB10 [get_ports {a_n[1]}]
set_property PACKAGE_PIN AB11 [get_ports {a_n[0]}]
set_property PACKAGE_PIN N15 [get_ports LOAD]
set_property PACKAGE_PIN R18 [get_ports RESET]
set_property PACKAGE_PIN Y9 [get_ports CLK]
