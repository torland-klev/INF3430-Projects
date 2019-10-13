# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z020clg484-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/managed_ip_project/managed_ip_project.cache/wt [current_project]
set_property parent.project_path M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/managed_ip_project/managed_ip_project.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
read_ip M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/ram_lab4/ram_lab4.xci
set_property used_in_implementation false [get_files -all m:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/ram_lab4/ram_lab4.dcp]
set_property is_locked true [get_files M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/ram_lab4/ram_lab4.xci]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
synth_design -top ram_lab4 -part xc7z020clg484-1 -mode out_of_context
rename_ref -prefix_all ram_lab4_
write_checkpoint -noxdef ram_lab4.dcp
catch { report_utilization -file ram_lab4_utilization_synth.rpt -pb ram_lab4_utilization_synth.pb }
if { [catch {
  file copy -force M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/managed_ip_project/managed_ip_project.runs/ram_lab4_synth_1/ram_lab4.dcp M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/ram_lab4/ram_lab4.dcp
} _RESULT ] } { 
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}
if { [catch {
  write_verilog -force -mode synth_stub M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/ram_lab4/ram_lab4_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}
if { [catch {
  write_vhdl -force -mode synth_stub M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/ram_lab4/ram_lab4_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}
if { [catch {
  write_verilog -force -mode funcsim M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/ram_lab4/ram_lab4_funcsim.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}
if { [catch {
  write_vhdl -force -mode funcsim M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/ram_lab4/ram_lab4_funcsim.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}