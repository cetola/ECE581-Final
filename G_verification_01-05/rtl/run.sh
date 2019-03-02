#!/bin/bash
echo Well, here we go
echo
vlog *.sv
echo I hope that worked
echo
vsim -c toptb -do "run -all;exit"
