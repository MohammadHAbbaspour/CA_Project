SetActiveLib -work
comp -include "$dsn\src\processor.vhd" 
comp -include "$dsn\src\TestBench\processor_TB.vhd" 
asim +access +r TESTBENCH_FOR_processor 
wave 
wave -noreg index
wave -noreg vr_add
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\processor_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_processor 
