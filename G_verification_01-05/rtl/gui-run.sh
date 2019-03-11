#!/bin/bash
echo Simulating toptb with -do run all
echo Running vlog on *.sv
vlog *.sv
echo Run complete. Check for errors.
echo Running vsim
echo
vsim toptb
