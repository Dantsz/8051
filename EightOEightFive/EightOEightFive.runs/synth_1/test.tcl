# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
set_msg_config -id {Common 17-41} -limit 10000000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /mnt/390FE82F60C53228/Hardware/8051/EightOEightFive/EightOEightFive.cache/wt [current_project]
set_property parent.project_path /mnt/390FE82F60C53228/Hardware/8051/EightOEightFive/EightOEightFive.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
set_property ip_output_repo /mnt/390FE82F60C53228/Hardware/8051/EightOEightFive/EightOEightFive.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  /mnt/390FE82F60C53228/Hardware/8051/EightOEightFive/EightOEightFive.srcs/sources_1/new/debouncer.vhd
  /mnt/390FE82F60C53228/Hardware/8051/EightOEightFive/EightOEightFive.srcs/sources_1/new/test.vhd
}
read_vhdl -vhdl2008 -library xil_defaultlib {
  /mnt/390FE82F60C53228/Hardware/8051/EightOEightFive/EightOEightFive.srcs/sources_1/new/alu.vhd
  /mnt/390FE82F60C53228/Hardware/8051/EightOEightFive/EightOEightFive.srcs/sources_1/new/display.vhd
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /mnt/390FE82F60C53228/Hardware/8051/EightOEightFive/EightOEightFive.srcs/constrs_1/new/urtc.xdc
set_property used_in_implementation false [get_files /mnt/390FE82F60C53228/Hardware/8051/EightOEightFive/EightOEightFive.srcs/constrs_1/new/urtc.xdc]

read_xdc /mnt/390FE82F60C53228/Hardware/8051/EightOEightFive/EightOEightFive.srcs/constrs_1/new/test.xdc
set_property used_in_implementation false [get_files /mnt/390FE82F60C53228/Hardware/8051/EightOEightFive/EightOEightFive.srcs/constrs_1/new/test.xdc]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top test -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef test.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file test_utilization_synth.rpt -pb test_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
