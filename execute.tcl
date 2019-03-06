# This is for FE

# Make sure to look at the right time scale of simulation

vlib work
vmap work
vlog "sync_counter_fe.sv"
vlog "tb_sync_counter_fe.sv"

# To view schematic:

vsim -debugDB tb_sync_counter_fe

# To view waveforms: uncomment the following

vsim -novopt tb_sync_counter_fe
add wave -position end sim:/tb_sync_counter_fe/*
run 200ns


