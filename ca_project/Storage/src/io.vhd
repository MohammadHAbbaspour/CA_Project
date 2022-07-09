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
	signal idx : integer; 
	signal processor_r_bit : std_logic;
----------------------------- TLB signals ---------------------------------------------
	signal virtual_address : std_logic_vector(15 downto 0);
	signal tlb_w_bit : std_logic;
	signal page_offset : std_logic_vector(6 downto 0);
	signal vpn : std_logic_vector(8 downto 0);
	signal ppn : std_logic_vector(3 downto 0);
	signal tlb_hit : std_logic;
	signal write_ppn : std_logic_vector(3 downto 0);
	signal tlb_r_bit : std_logic;
----------------------------------------------------------------------------------------
-------------------------------cach signals --------------------------------------------
	signal physical_address : std_logic_vector(10 downto 0);
	signal cach_hit : std_logic;
	signal cach_read_data : std_logic_vector(7 downto 0);
	signal cach_w_bit : std_logic;
	signal cach_write_data : two_word_data_Type;
	signal cach_r_bit : std_logic;
-----------------------------------------------------------------------------------------
begin
	idx <= idxin;
	processor : entity work.Processor(Processor_behavioral) port map (index => idx, vr_add => virtual_address, r_bit => processor_r_bit);	
	
	vpn <= virtual_address(15 downto 7);
	page_offset <= virtual_address(6 downto 0);
	tlb_w_bit <= '0';
	write_ppn <= (others => '0');
	
	tlb : entity work.Fully_Associative_TLB(TLB_behavioral) port map(w_bit => tlb_w_bit,
																	vpn => vpn,
																	ppn => ppn,
																	hit => tlb_hit,
																	ppn_from_pt => write_ppn);
	
	cach : entity work.Direct_Cach(Direct_Cach_behavioral) port map(ph_add => physical_address,
																			hit => cach_hit,
																			read_data => cach_read_data,
																			w_bit => cach_w_bit,
																			write_data_from_memory => cach_write_data);																	
	process(ppn, write_ppn)
	is
	begin
		if tlb_hit = '1' then 
			physical_address <= ppn & page_offset;
			cach_w_bit <= '0';
			cach_write_data <= (others => (others => '0'));
		end if;
	end process;
	
end	behavioral;	