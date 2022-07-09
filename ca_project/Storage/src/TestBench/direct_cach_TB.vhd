library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

use work.my_package.all;

	-- Add your library and packages declaration here ...

entity direct_cach_tb is
end direct_cach_tb;

architecture TB_ARCHITECTURE of direct_cach_tb is
	-- Component declaration of the tested unit
	component direct_cach
	port(
		r_bit : in STD_LOGIC;
		w_bit : in STD_LOGIC;
		ph_add : in STD_LOGIC_VECTOR(10 downto 0);
		write_data_from_memory : in two_word_data_Type;
		read_data : out STD_LOGIC_VECTOR(7 downto 0);
		hit : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal r_bit : STD_LOGIC;
	signal w_bit : STD_LOGIC;
	signal ph_add : STD_LOGIC_VECTOR(10 downto 0);
	signal write_data_from_memory : two_word_data_Type;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal read_data : STD_LOGIC_VECTOR(7 downto 0);
	signal hit : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : direct_cach
		port map (
			r_bit => r_bit,
			w_bit => w_bit,
			ph_add => ph_add,
			write_data_from_memory => write_data_from_memory,
			read_data => read_data,
			hit => hit
		);

	-- Add your stimulus here ...
	
	process
	is
	begin		
		r_bit <= '0';
		w_bit <= '1';
		ph_add <= "01100100110";
		write_data_from_memory <= ("01100110101111000000001001101111", "11001000111111001100110001010010");
		wait for 200 ns;
		r_bit <= '1';
		w_bit <= '0';
		ph_add <= "11011111111";
		write_data_from_memory <= (others => (others => '0'));
		wait for 200 ns;
		r_bit <= '1';
		w_bit <= '0';
		ph_add <= "00000100110";
		write_data_from_memory <= (others => (others => '0'));
		wait;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_direct_cach of direct_cach_tb is
	for TB_ARCHITECTURE
		for UUT : direct_cach
			use entity work.direct_cach(direct_cach_behavioral);
		end for;
	end for;
end TESTBENCH_FOR_direct_cach;

