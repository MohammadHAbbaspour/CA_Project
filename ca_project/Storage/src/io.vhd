library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all; 
use work.my_package.all;

entity io is 	
	port(									   
	idxin : in integer;
	dataout : out std_logic_vector(7 downto 0)
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
	signal mem_ppnout: std_logic_vector(3 downto 0);
-------------------------------------------------------------------------------------------
begin
	processor : entity work.Processor(Processor_behavioral) port map (r_bit => proc_r_bit,
																	index => proc_index,
																	vr_add => proc_vr_add);	
	
		tlb : entity work.Fully_Associative_TLB(TLB_behavioral) port map(r_bit => tlb_r_bit,
																	w_bit => tlb_w_bit,
																	vpn => tlb_vpn,
																	ppn_from_pt => tlb_ppn_from_pt,
																	ppn => tlb_ppn,
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
														read_data => mem_read_data,
														ppnout => mem_ppnout);
	process(idxin)
	is
	variable pageoffset: std_logic_vector(6 downto 0);
	variable vpn: std_logic_vector(8 downto 0);
	variable ppn: std_logic_vector(3 downto 0);
	variable phaddr: std_logic_vector(10 downto 0);
	variable readpage: page_type;
	variable twoword: two_word_data_Type;
	variable word: std_logic_vector(31 downto 0);
	variable byteoffset: std_logic_vector(1 downto 0);
	begin
		-- get virtual address from processor
		proc_r_bit <= '1';
		proc_index <= idxin;
		vpn := proc_vr_add(15 downto 7);
		pageoffset:= proc_vr_add(6 downto 0);
		proc_r_bit <= '0' ;
		
		-- check vpn in tlb
		tlb_vpn <= vpn;
		tlb_ppn_from_pt <= (others => '0');
		tlb_r_bit <= '1' ; 
		tlb_r_bit <= '0';
		if tlb_hit = '1' then
			ppn := tlb_ppn;
		elsif tlb_hit = '0' then 
			-- check vpn in page table
			pt_vpn <= vpn;
			pt_write_ppn <= (others => '0'); 
			pt_r_bit <= '1'; 
			pt_r_bit <= '0';
			if pt_hit = '1'then	
				-- write ppn to tln for later acceses
				ppn := pt_read_ppn;
				tlb_vpn <= vpn;
				tlb_ppn_from_pt <= ppn;
				tlb_w_bit <= '1';
				tlb_w_bit <= '0';
			elsif pt_hit = '0'then
				-- read page from hard
				hard_storage_add <= vpn;
				hard_r_bit <= '1';
				hard_r_bit <= '0';
				readpage := hard_page;
				-- write page in memory and save the address
				mem_ph_add <= (others => '0');
				mem_write_data_from_disk <= readpage;
				mem_w_bit <= '1';
				mem_w_bit <= '0';
				ppn := mem_ppnout;
				-- write ppn to page table
				pt_vpn <= vpn;
				pt_write_ppn <= ppn;
				pt_w_bit <= '1';
				pt_w_bit <= '0';
				-- write ppn to tlb for later acceses;
				tlb_vpn <= vpn;
				tlb_ppn_from_pt <= ppn;
				tlb_w_bit <= '1';
				tlb_w_bit <= '0';	
			end if;
		end if;	 
		
		-- read physical address from cache
		phaddr := ppn & pageoffset;
		cache_ph_add <= phaddr;
		cache_write_data_from_memory <= (others => (others => '0'));
		cache_r_bit <= '1';
		cache_r_bit <= '0';
		if cache_hit = '1' then
			dataout <= cache_read_data;
		elsif cache_hit = '0' then
			-- read physical address from memory
			mem_ph_add <= phaddr;
			mem_write_data_from_disk <= (others => (others => (others => '0')));
			mem_r_bit <= '1';
			mem_r_bit <= '0';
			twoword := mem_read_data;
			-- write two word to cache for later acceses
			cache_ph_add <= phaddr;
			cache_write_data_from_memory <= twoword;
			cache_r_bit <= '0';
			cache_r_bit <= '1';	
			word := twoword(to_integer(unsigned'('0' & phaddr(2))));
			byteoffset := phaddr(1 downto 0);
			dataout <= word(to_integer(unsigned(byteoffset)) * 8 + 7 downto to_integer(unsigned(byteoffset) * 8));
		end if;	
	end process;
	
end	behavioral;	