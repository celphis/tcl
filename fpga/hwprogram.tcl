proc hwclose {} {
  close_hw_target
  close_hw
}

proc hwopen {} {
  open_hw
  connect_hw_server
  # set_property PARAM.FREQUENCY 30000000 [lindex [get_hw_targets -of_objects [get_hw_servers localhost]] 0]
  open_hw_target [lindex [get_hw_targets -of_objects [get_hw_servers localhost]] 0]
}

proc hwprog {bitfile} {
  set_property PROGRAM.FILE $bitfile [lindex [get_hw_devices] 0]
  program_hw_devices [lindex [get_hw_devices] 0]
}

proc hwrefresh {} {
  current_hw_device [lindex [get_hw_devices] 0]
  refresh_hw_device -update_hw_probes false [lindex [get_hw_devices] 0]
}

proc hwprogramm {bitfile} {
  if {[file exists $bitfile] == 1} {
    puts $bitsfile
    hwopen
    hwrefresh
    hwprog {$bitfile}
    hwclose
  } else {
    puts "ERROR: Bitfile not found."
  }
}
