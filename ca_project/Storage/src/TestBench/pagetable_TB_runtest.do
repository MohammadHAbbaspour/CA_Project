SetActiveLib -work
comp -include "$dsn\src\page table.vhd" 
comp -include "$dsn\src\TestBench\pagetable_TB.vhd" 
asim +access +r TESTBENCH_FOR_pagetable 
wave 
wave -noreg w_bit
wave -noreg vpn
wave -noreg write_ppn
wave -noreg read_ppn
wave -noreg hit
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\pagetable_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_pagetable 
