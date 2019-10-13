# ----------------------------------------------------------------------------
# Clock Source - Bank 13
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN Y9 [get_ports refclk]

# ----------------------------------------------------------------------------
# User Push Buttons - Bank 34
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN P16 [get_ports sync_rst]
set_property PACKAGE_PIN R16 [get_ports arst]
set_property PACKAGE_PIN N15 [get_ports force_ccw]
set_property PACKAGE_PIN R18 [get_ports force_cw]
#set_property PACKAGE_PIN T18 [get_ports {BTNU}];  # "BTNU"

# ----------------------------------------------------------------------------
# User DIP Switches - Bank 35
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN F22 [get_ports {sp[0]}]
set_property PACKAGE_PIN G22 [get_ports {sp[1]}]
set_property PACKAGE_PIN H22 [get_ports {sp[2]}]
set_property PACKAGE_PIN F21 [get_ports {sp[3]}]
set_property PACKAGE_PIN H19 [get_ports {sp[4]}]
set_property PACKAGE_PIN H18 [get_ports {sp[5]}]
set_property PACKAGE_PIN H17 [get_ports {sp[6]}]
set_property PACKAGE_PIN M15 [get_ports {sp[7]}]

# ----------------------------------------------------------------------------
# Motordriver board connections
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN Y11 [get_ports motor_cw]
set_property PACKAGE_PIN AA11 [get_ports motor_ccw]
set_property PACKAGE_PIN Y10 [get_ports a]
set_property PACKAGE_PIN AA9 [get_ports b]

# ----------------------------------------------------------------------------
# Seven segment display
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN AB11 [get_ports {a_n[3]}]
set_property PACKAGE_PIN AB10 [get_ports {a_n[2]}]
set_property PACKAGE_PIN AB9 [get_ports {a_n[1]}]
set_property PACKAGE_PIN AA8 [get_ports {a_n[0]}]
set_property PACKAGE_PIN V12 [get_ports {abcdefgdec_n[7]}]
set_property PACKAGE_PIN W12 [get_ports {abcdefgdec_n[6]}]
set_property PACKAGE_PIN W10 [get_ports {abcdefgdec_n[5]}]
set_property PACKAGE_PIN W11 [get_ports {abcdefgdec_n[4]}]
set_property PACKAGE_PIN V9 [get_ports {abcdefgdec_n[3]}]
set_property PACKAGE_PIN V10 [get_ports {abcdefgdec_n[2]}]
set_property PACKAGE_PIN V8 [get_ports {abcdefgdec_n[1]}]
set_property PACKAGE_PIN W8 [get_ports {abcdefgdec_n[0]}]

# ----------------------------------------------------------------------------
# IOSTANDARD Constraints
#
# Note that these IOSTANDARD constraints are applied to all IOs currently
# assigned within an I/O bank.  If these IOSTANDARD constraints are
# evaluated prior to other PACKAGE_PIN constraints being applied, then
# the IOSTANDARD specified will likely not be applied properly to those
# pins.  Therefore, bank wide IOSTANDARD constraints should be placed
# within the XDC file in a location that is evaluated AFTER all
# PACKAGE_PIN constraints within the target bank have been evaluated.
#
# Un-comment one or more of the following IOSTANDARD constraints according to
# the bank pin assignments that are required within a design.
# ----------------------------------------------------------------------------

# Note that the bank voltage for IO Bank 33 is fixed to 3.3V on ZedBoard.
#set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]]

# Set the bank voltage for IO Bank 34 to 1.8V by default.
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 34]]

# Set the bank voltage for IO Bank 35 to 1.8V by default.
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 35]]

# Note that the bank voltage for IO Bank 13 is fixed to 3.3V on ZedBoard.
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]]

# Constrain combinatorial path: 
set_max_delay -from [get_ports sp] -to [get_ports abcdefgdec_n] -datapath_only 20.0
