## TCL SCRIPT STUB
# Not complete, just a rough outline of what
# it might look like.

# List all current designs
set this_design [ list_designs ]

# If there are existing designs reset/remove them
if { $this_design != 0 } {
  # To reset the earlier designs
  reset_design
  remove_design -designs
}

set search_path ""
lappend search_path "/pkgs/synopsys/2016/libs/SAED32_EDK/lib/stdcell_hvt/db_nldm"
lappend search_path "/pkgs/synopsys/2016/libs/SAED32_EDK/lib/stdcell_rvt/db_nldm"
lappend search_path "/pkgs/synopsys/2016/libs/SAED32_EDK/lib/stdcell_lvt/db_nldm"
lappend search_path "/pkgs/synopsys/2016/libs/SAED32_EDK/lib/io_std/db_nldm"
lappend search_path "/pkgs/synopsys/2016/libs/SAED32_EDK/lib/sram/db_nldm"

set synthetic_library dw_foundation.sldb
set target_library "saed32lvt_ss0p75v125c.db saed32rvt_ss0p75v125c.db"
set link_library "* saed32hvt_ss0p75v125c.db saed32lvt_ss0p75v125c.db saed32rvt_ss0p75v125c.db saed32io_wb_ss0p95v125c_2p25v.db \
 saed32sram_ss0p95v125c.db dw_foundation.sldb"


# Analyzing the current design
analyze -format sverilog ../rtl/top.sv


# Elaborate the design
elaborate top 

current_design top
link

# 1 GHz fast clock
create_clock -name "fastClk" -period 1.0 -waveform {0.0 0.5} wclk

# Constrain the overall data path of the design.
# 50% or so of the clock period is good.
set_max_transition 0.5 [current_design ]
# Set to 0.  It will give constraint errors, but this is ok
set_max_area 0

#set_wire_load_mode enclosed
#set_wire_load_model -name 8000
set_operating_conditions ss0p75v125c

group_path -name INPUTS -from [ get_ports -filter "direction==in&&full_name!~*clk*" ]
group_path -name OUTPUTS -to [ get_ports -filter "direction==out" ]
group_path -name FEEDTHROUGH -from [all_inputs ] -to [all_outputs] 

#compile map the sequential cell exactly as in the rtl
compile -exact_map 

echo report_timing command
report_timing > ../reports/report_timing.rpt
echo check_timing command
check_timing -include {no_driving_cell no_input_delay partial_input_delay unconstrained_endpoints } > ../reports/check_timing.rpt
echo report_qor command
report_qor -sig 3 > ../reports/qor.rpt
echo report_constraint command (PWR-6, PWR-414, PWR-415 Warnings are ok)
report_constraint -all_violators -verbose -sig 3 > ../reports/constraint.rpt
report_power > ../reports/power.rpt
write -hier -format verilog -output top.vg

