# create the work library
vlib work 

# compilation  
# vlog ../../rtl/Single_Cycle_top.v
vlog ../../tb/testbench.v

# simulation 
vsim -debugDB -voptargs="+acc" work.tb

# add signlas to waveform viewer
# after running the code , remove add wave - r and write do wave.do 
# add wave -r *
# Instead of dumping everything, call our custom layout
do wave.do

# execute the simulator
run -all 

# open the schematic viewer
view schematic

# draw the schematic of the mentioned module
add schematic /tb/DUT
