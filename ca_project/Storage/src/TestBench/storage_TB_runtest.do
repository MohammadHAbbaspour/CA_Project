SetActiveLib -work
comp -include "$dsn\src\hard disk.vhd" 
comp -include "$dsn\src\TestBench\storage_TB.vhd" 
asim +access +r TESTBENCH_FOR_storage 
wave 
wave -noreg r_bit
wave -noreg storage_add
wave -noreg page
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\storage_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_storage 
