SetActiveLib -work
comp -include "$dsn\src\io.vhd" 
comp -include "$dsn\src\TestBench\io_TB.vhd" 
asim +access +r TESTBENCH_FOR_io 
wave 
wave -noreg idxin
wave -noreg dataout
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\io_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_io 
