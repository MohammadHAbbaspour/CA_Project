library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all; 
use work.my_package.all;

entity io is 	
	port(									   
	idxin : in integer;
	vraddrout : out std_logic_vector(15 downto 0)
	);
end io;	   

architecture behavioral of io is
----------------------------- processor signals ---------------------------------------
	signal proc_r_bit :  std_logic;
	signal proc_index :  integer;
	signal proc_vr_add : std_logic_vector(15 downto 0);
----------------------------- TLB signals ---------------------------------------------
	signal tlb_r_bit : std_logic;
	signal tlb_w_bit : std_logic;
	signal tlb_vpn : std_logic_vector(8 downto 0);
	signal tlb_ppn : std_logic_vector(3 downto 0);
	signal tlb_ppn_from_pt : std_logic_vector(3 downto 0);
	signal tlb_hit : std_logic;
	
----------------------------------------------------------------------------------------
-------------------------------cach signals -------------------------------------------- 
	signal cache_r_bit : std_logic;
	signal cache_w_bit : std_logic; 
	signal cache_ph_add : std_logic_vector(10 downto 0);
	signal cache_write_data_from_memory : two_word_data_Type;
	signal cache_read_data : std_logic_vector(7 downto 0);
	signal cache_hit : std_logic;
	
-----------------------------------------------------------------------------------------
---------------------------------page table signals---------------------------------------
	signal pt_r_bit : std_logic;
    signal pt_w_bit : std_logic;
    signal pt_vpn : std_logic_vector(8 downto 0);
    signal pt_write_ppn : std_logic_vector(3 downto 0);
    signal pt_read_ppn : std_logic_vector(3 downto 0);
    signal pt_hit : std_logic;
----------------------------------------------------------------------------------------
--------------------------------- hard signals-----------------------------------------
	signal hard_r_bit : std_logic;
	signal hard_storage_add : std_logic_vector(8 downto 0);   	-- referes to OS Fault Handler
	signal hard_page : page_type;
-----------------------------------------------------------------------------------------
-------------------------------------memory signals--------------------------------------
	signal mem_r_bit : std_logic;
	signal mem_w_bit : std_logic;
	signal mem_ph_add : std_logic_vector(10 downto 0);
	signal mem_write_data_from_disk : page_type;
	signal mem_read_data : two_word_data_Type;	
-------------------------------------------------------------------------------------------
begin
	processor : entity work.Processor(Processor_behavioral) port map (r_bit => proc_r_bit,
																	index => proc_index,
																	vr_add => proc_vr_add);	
	
		tlb : entity work.Fully_Associative_TLB(TLB_behavioral) port map(r_bit => tlb_r_bit,
																	w_bit => tlb_w_bit,
																	vpn => tlb_vpn,
																	ppn => tlb_ppn,
																	ppn_from_pt => tlb_ppn_from_pt,
																	hit => tlb_hit);
	
	cach : entity work.Direct_Cach(Direct_Cach_behavioral) port map(r_bit => cache_r_bit,
																	w_bit => cache_w_bit,
																	ph_add => cache_ph_add,
																	write_data_from_memory => cache_write_data_from_memory,
																	read_data => cache_read_data,
																	hit => cache_hit);
	pt: entity work.PageTable(PageTable_behavioral) port map(r_bit => pt_r_bit,
															w_bit => pt_w_bit,
															vpn => pt_vpn,
															write_ppn => pt_write_ppn,
															read_ppn => pt_read_ppn,
															hit => pt_hit);
	hard: entity work.Storage(Storage_behavioral) port map(r_bit => hard_r_bit,
															storage_add => hard_storage_add,
															page => hard_page); 
	mem: entity work.Memory(Memory_behavioral) port map(r_bit => mem_r_bit,
														w_bit => mem_w_bit,
														ph_add => mem_ph_add,
														write_data_from_disk => mem_write_data_from_disk,
														read_data => mem_read_data);
	process
	is
	begin
	end process;
	
end	behavioral;	