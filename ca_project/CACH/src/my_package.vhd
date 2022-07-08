library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;


package my_package is 													
	type two_word_data_Type is array (0 to 1) of std_logic_vector(31 downto 0);	
	type page_type is array (0 to 15) of two_word_data_type;	
	type memory_data_blocks_type is array (0 to 12) of page_type;
	type cach_data_blocks_type is array (0 to 31) of two_word_data_Type;
	type tag_data_type is array (0 to 31) of std_logic_vector(2 downto 0);
end my_package;

