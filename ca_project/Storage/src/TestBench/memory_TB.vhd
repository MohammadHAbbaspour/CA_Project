library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

use work.my_package.all;

	-- Add your library and packages declaration here ...

entity memory_tb is
end memory_tb;

architecture TB_ARCHITECTURE of memory_tb is
	-- Component declaration of the tested unit
	component memory
	port(
		r_bit : in STD_LOGIC;
		w_bit : in STD_LOGIC;
		ph_add : in STD_LOGIC_VECTOR(10 downto 0);
		write_data_from_disk : in page_type;
		read_data : out two_word_data_Type;
		ppnout : out STD_LOGIC_VECTOR(3 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal r_bit : STD_LOGIC;
	signal w_bit : STD_LOGIC;
	signal ph_add : STD_LOGIC_VECTOR(10 downto 0);
	signal write_data_from_disk : page_type;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal read_data : two_word_data_Type;
	signal ppnout : STD_LOGIC_VECTOR(3 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : memory
		port map (
			r_bit => r_bit,
			w_bit => w_bit,
			ph_add => ph_add,
			write_data_from_disk => write_data_from_disk,
			read_data => read_data,
			ppnout => ppnout
		);

	-- Add your stimulus here ... 
	process
	is
	begin		
		r_bit <= '0';
		w_bit <= '1';
		ph_add <= (others => '0');
		write_data_from_disk <= 	(   ("01100110101111000000001001101111", "11001000111111001100110001010010"), 
										("10101111001001001000010001001101", "11000001001010001000101000011010"), 
										("10111101111110101001100010000110", "01010100111110110110110100000000"), 
										("00011010101111000001000101010100", "00011000010010001010100110111001"), 
										("10100010110100011010001011110101", "01100100110110010010010100101011"), 
										("00001000000011000110101101111111", "01000111011111101111010110011110"), 
										("10000011101001100111110000100101", "11000100010011111110100111111111"), 
										("00001010001100111110000111000001", "10110100110011111111000000010100"), 
										("11000100001000010111010000111001", "00000101011010001100011100101111"), 
										("10011001000010111110111001011101", "10000001010000101110000011100001"), 
										("10100010110101001010010011001100", "10110011110000110100010000000110"), 
										("01111011110100111011110110100110", "11111110010111101010100010000100"), 
										("10101100001101100101110111001100", "01111101011100100110100001101000"), 
										("11011001100111110001111111001101", "00010111100101101100100010111100"),
										("11000000110110110100010100011101", "10111111001100101001010010000101"), 
										("00110110111010011010011100000110", "01011101011100101010010011101011")  );
										
		wait for 200 ns;
		r_bit <= '1' ;
		w_bit <= '0'; 
		ph_add <= "00000100110";
		wait for 200 ns;
		r_bit <= '1' ;
		w_bit <= '0'; 
		ph_add <= "00000100110";
		wait;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_memory of memory_tb is
	for TB_ARCHITECTURE
		for UUT : memory
			use entity work.memory(memory_behavioral);
		end for;
	end for;
end TESTBENCH_FOR_memory;

