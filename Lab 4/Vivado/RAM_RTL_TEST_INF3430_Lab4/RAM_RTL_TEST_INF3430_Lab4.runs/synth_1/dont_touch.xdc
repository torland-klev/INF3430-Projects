# This file is automatically generated.
# It contains project source information necessary for synthesis and implementation.

# XDC: imports/constraints/constraints_lab4.xdc

# Block Designs: M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/INF3430_Lab4/INF3430_Lab4.srcs/sources_1/bd/lab4processor/lab4processor.bd
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==lab4processor || ORIG_REF_NAME==lab4processor}]

# IP: M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/INF3430_Lab4/INF3430_Lab4.srcs/sources_1/bd/lab4processor/ip/lab4processor_processing_system7_0_0/lab4processor_processing_system7_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==lab4processor_processing_system7_0_0 || ORIG_REF_NAME==lab4processor_processing_system7_0_0}]

# IP: M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/INF3430_Lab4/INF3430_Lab4.srcs/sources_1/bd/lab4processor/ip/lab4processor_proc_sys_reset_0_0/lab4processor_proc_sys_reset_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==lab4processor_proc_sys_reset_0_0 || ORIG_REF_NAME==lab4processor_proc_sys_reset_0_0}]

# IP: M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/INF3430_Lab4/INF3430_Lab4.srcs/sources_1/bd/lab4processor/ip/lab4processor_axi_interconnect_0_0/lab4processor_axi_interconnect_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==lab4processor_axi_interconnect_0_0 || ORIG_REF_NAME==lab4processor_axi_interconnect_0_0}]

# IP: M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/INF3430_Lab4/INF3430_Lab4.srcs/sources_1/bd/lab4processor/ip/lab4processor_auto_pc_0/lab4processor_auto_pc_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==lab4processor_auto_pc_0 || ORIG_REF_NAME==lab4processor_auto_pc_0}]

# XDC: m:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/INF3430_Lab4/INF3430_Lab4.srcs/sources_1/bd/lab4processor/ip/lab4processor_processing_system7_0_0/lab4processor_processing_system7_0_0.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==lab4processor_processing_system7_0_0 || ORIG_REF_NAME==lab4processor_processing_system7_0_0}] {/inst }]/inst ]]

# XDC: m:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/INF3430_Lab4/INF3430_Lab4.srcs/sources_1/bd/lab4processor/ip/lab4processor_proc_sys_reset_0_0/lab4processor_proc_sys_reset_0_0_board.xdc
#dup# set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==lab4processor_proc_sys_reset_0_0 || ORIG_REF_NAME==lab4processor_proc_sys_reset_0_0}]

# XDC: m:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/INF3430_Lab4/INF3430_Lab4.srcs/sources_1/bd/lab4processor/ip/lab4processor_proc_sys_reset_0_0/lab4processor_proc_sys_reset_0_0.xdc
#dup# set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==lab4processor_proc_sys_reset_0_0 || ORIG_REF_NAME==lab4processor_proc_sys_reset_0_0}]

# XDC: m:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/INF3430_Lab4/INF3430_Lab4.srcs/sources_1/bd/lab4processor/ip/lab4processor_proc_sys_reset_0_0/lab4processor_proc_sys_reset_0_0_ooc.xdc

# XDC: m:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/INF3430_Lab4/INF3430_Lab4.srcs/sources_1/bd/lab4processor/ip/lab4processor_auto_pc_0/lab4processor_auto_pc_0_ooc.xdc

# XDC: M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/INF3430_Lab4/INF3430_Lab4.srcs/sources_1/bd/lab4processor/lab4processor_ooc.xdc
