# This file sets up the simulation environment.
create_project -part xc7a100tcsg324-2 -force proj
set_property target_language Verilog [current_project]
set_property "default_lib" "work" [current_project]
create_fileset -simset simset

#read_ip ../amc_ila/amc_ila.xci
#generate_target {simulation} [get_ips *]

read_verilog -sv ../lfsr/lfsr.sv
read_verilog -sv ../prng.sv
read_verilog -sv ../prng_tb.sv

add_files -fileset sim_1 -norecurse ./prng_tb_behav.wcfg

close_project


