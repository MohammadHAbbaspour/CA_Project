SetActiveLib -work
comp -include "$dsn\src\TLB.vhd" 
comp -include "$dsn\src\TestBench\fully_associative_tlb_TB.vhd" 
asim +access +r TESTBENCH_FOR_fully_associative_tlb 
wave 
wave -noreg r_bit
wave -noreg w_bit
wave -noreg vpn
wave -noreg ppn_from_pt
wave -noreg ppn
wave -noreg hit
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\fully_associative_tlb_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_fully_associative_tlb 
