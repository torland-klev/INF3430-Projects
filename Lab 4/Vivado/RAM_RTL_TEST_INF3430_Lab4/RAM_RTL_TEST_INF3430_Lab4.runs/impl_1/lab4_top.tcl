proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {Common-41} -limit 4294967295
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  debug::add_scope template.lib 1
  create_project -in_memory -part xc7z020clg484-1
  set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/RAM_RTL_TEST_INF3430_Lab4/RAM_RTL_TEST_INF3430_Lab4.cache/wt [current_project]
  set_property parent.project_path M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/RAM_RTL_TEST_INF3430_Lab4/RAM_RTL_TEST_INF3430_Lab4.xpr [current_project]
  set_property ip_repo_paths m:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/RAM_RTL_TEST_INF3430_Lab4/RAM_RTL_TEST_INF3430_Lab4.cache/ip [current_project]
  set_property ip_output_repo m:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/RAM_RTL_TEST_INF3430_Lab4/RAM_RTL_TEST_INF3430_Lab4.cache/ip [current_project]
  add_files -quiet M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/RAM_RTL_TEST_INF3430_Lab4/RAM_RTL_TEST_INF3430_Lab4.runs/synth_1/lab4_top.dcp
  read_xdc -ref lab4processor_processing_system7_0_0 -cells inst m:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/INF3430_Lab4/INF3430_Lab4.srcs/sources_1/bd/lab4processor/ip/lab4processor_processing_system7_0_0/lab4processor_processing_system7_0_0.xdc
  set_property processing_order EARLY [get_files m:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/INF3430_Lab4/INF3430_Lab4.srcs/sources_1/bd/lab4processor/ip/lab4processor_processing_system7_0_0/lab4processor_processing_system7_0_0.xdc]
  read_xdc -prop_thru_buffers -ref lab4processor_proc_sys_reset_0_0 m:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/INF3430_Lab4/INF3430_Lab4.srcs/sources_1/bd/lab4processor/ip/lab4processor_proc_sys_reset_0_0/lab4processor_proc_sys_reset_0_0_board.xdc
  set_property processing_order EARLY [get_files m:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/INF3430_Lab4/INF3430_Lab4.srcs/sources_1/bd/lab4processor/ip/lab4processor_proc_sys_reset_0_0/lab4processor_proc_sys_reset_0_0_board.xdc]
  read_xdc -ref lab4processor_proc_sys_reset_0_0 m:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/INF3430_Lab4/INF3430_Lab4.srcs/sources_1/bd/lab4processor/ip/lab4processor_proc_sys_reset_0_0/lab4processor_proc_sys_reset_0_0.xdc
  set_property processing_order EARLY [get_files m:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/INF3430_Lab4/INF3430_Lab4.srcs/sources_1/bd/lab4processor/ip/lab4processor_proc_sys_reset_0_0/lab4processor_proc_sys_reset_0_0.xdc]
  read_xdc M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/RAM_RTL_TEST_INF3430_Lab4/RAM_RTL_TEST_INF3430_Lab4.srcs/constrs_1/imports/constraints/constraints_lab4.xdc
  link_design -top lab4_top -part xc7z020clg484-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force lab4_top_opt.dcp
  catch {report_drc -file lab4_top_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file lab4_top.hwdef}
  place_design 
  write_checkpoint -force lab4_top_placed.dcp
  catch { report_io -file lab4_top_io_placed.rpt }
  catch { report_utilization -file lab4_top_utilization_placed.rpt -pb lab4_top_utilization_placed.pb }
  catch { report_control_sets -verbose -file lab4_top_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force lab4_top_routed.dcp
  catch { report_drc -file lab4_top_drc_routed.rpt -pb lab4_top_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file lab4_top_timing_summary_routed.rpt -rpx lab4_top_timing_summary_routed.rpx }
  catch { report_power -file lab4_top_power_routed.rpt -pb lab4_top_power_summary_routed.pb }
  catch { report_route_status -file lab4_top_route_status.rpt -pb lab4_top_route_status.pb }
  catch { report_clock_utilization -file lab4_top_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

