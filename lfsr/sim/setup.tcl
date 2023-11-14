# This file sets up the simulation environment.
create_project -part xc7a100tcsg324-2 -force proj
set_property target_language Verilog [current_project]
set_property "default_lib" "work" [current_project]
create_fileset -simset simset

#read_ip ../tac_ila/tac_ila.xci
#generate_target {simulation} [get_ips *]

read_verilog -sv ../lfsr.sv
read_verilog -sv ../lfsr_tb.sv

add_files -fileset sim_1 -norecurse ./lfsr_tb_behav.wcfg

close_project


