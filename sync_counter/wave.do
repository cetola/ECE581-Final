onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_sync_counter_fe/rst
add wave -noupdate /tb_sync_counter_fe/cntrlAB
add wave -noupdate /tb_sync_counter_fe/cntrlCD
add wave -noupdate /tb_sync_counter_fe/di
add wave -noupdate /tb_sync_counter_fe/clkA
add wave -noupdate /tb_sync_counter_fe/clkB
add wave -noupdate /tb_sync_counter_fe/clkC
add wave -noupdate /tb_sync_counter_fe/clkD
add wave -noupdate /tb_sync_counter_fe/dco
add wave -noupdate /tb_sync_counter_fe/clkAB
add wave -noupdate /tb_sync_counter_fe/clkCD
add wave -noupdate /tb_sync_counter_fe/Result_pass
add wave -noupdate /tb_sync_counter_fe/f_dco
add wave -noupdate /tb_sync_counter_fe/f_dao
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {126 ns}
