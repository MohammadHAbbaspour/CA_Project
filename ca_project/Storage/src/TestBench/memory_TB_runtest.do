SetActiveLib -work
comp -include "$dsn\src\memory.vhd" 
comp -include "$dsn\src\TestBench\memory_TB.vhd" 
asim +access +r TESTBENCH_FOR_memory 
wave 
wave -noreg r_bit
wave -noreg w_bit
wave -noreg ph_add
wave -noreg write_data_from_disk
wave -noreg read_data
wave -noreg ppnout
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\memory_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_memory 
