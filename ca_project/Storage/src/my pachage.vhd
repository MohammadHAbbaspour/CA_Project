library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;


package my_package is 													
	type two_word_data_Type is array (0 to 1) of std_logic_vector(31 downto 0);	
	type page_type is array (0 to 15) of two_word_data_type;	
	type memory_data_blocks_type is array (0 to 12) of page_type;
	type cach_data_blocks_type is array (0 to 31) of two_word_data_Type;
	type tag_data_type is array (0 to 31) of std_logic_vector(2 downto 0);
	type valid2setarray is array (0 to 31) of std_logic_vector(1 downto 0);
	type tag2set is array (0 to 1) of std_logic_vector(2 downto 0);
	type tag2setarray is array (0 to 31) of tag2set;
	type cache2set is array (0 to 1) of two_word_data_Type;
	type cache2setarray is array (0 to 31) of cache2set;
	type TLB_ppn_type is array (0 to 47) of std_logic_vector(3 downto 0); 
	type TLB_tag_type is array (0 to 47) of std_logic_vector(8 downto 0);
end my_package;

				