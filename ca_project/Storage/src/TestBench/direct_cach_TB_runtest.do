SetActiveLib -work
comp -include "$dsn\src\cache.vhd" 
comp -include "$dsn\src\TestBench\direct_cach_TB.vhd" 
asim +access +r TESTBENCH_FOR_direct_cach 
wave 
wave -noreg r_bit
wave -noreg w_bit
wave -noreg ph_add
wave -noreg write_data_from_memory
wave -noreg read_data
wave -noreg hit
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\direct_cach_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_direct_cach 
