library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all; 
use work.my_package.all;

	-- Add your library and packages declaration here ...

entity fully_associative_tlb_tb is
end fully_associative_tlb_tb;

architecture TB_ARCHITECTURE of fully_associative_tlb_tb is
	-- Component declaration of the tested unit
	component fully_associative_tlb
	port(
		r_bit : in STD_LOGIC;
		w_bit : in STD_LOGIC;
		vpn : in STD_LOGIC_VECTOR(8 downto 0);
		ppn_from_pt : in STD_LOGIC_VECTOR(3 downto 0);
		ppn : out STD_LOGIC_VECTOR(3 downto 0);
		hit : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal r_bit : STD_LOGIC;
	signal w_bit : STD_LOGIC;
	signal vpn : STD_LOGIC_VECTOR(8 downto 0);
	signal ppn_from_pt : STD_LOGIC_VECTOR(3 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal ppn : STD_LOGIC_VECTOR(3 downto 0);
	signal hit : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : fully_associative_tlb
		port map (
			r_bit => r_bit,
			w_bit => w_bit,
			vpn => vpn,
			ppn_from_pt => ppn_from_pt,
			ppn => ppn,
			hit => hit
		);

	-- Add your stimulus here ...  
	
	process
	is
	begin		
		r_bit <= '0';
		w_bit <= '1';
		vpn <= "001010010";
		ppn_from_pt <= "1010";
		wait for 200 ns;
		r_bit <= '1';
		w_bit <= '0';
		vpn <= "101010110";
		ppn_from_pt <= "0000";
		wait for 200 ns;
		r_bit <= '1';
		w_bit <= '0';
		vpn <= "001010010";
		ppn_from_pt <= "0000";	
		wait for 200 ns;
		r_bit <= '1';
		w_bit <= '0';
		vpn <= "001010010";
		ppn_from_pt <= "0000";
		wait;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_fully_associative_tlb of fully_associative_tlb_tb is
	for TB_ARCHITECTURE
		for UUT : fully_associative_tlb
			use entity work.fully_associative_tlb(tlb_behavioral);
		end for;
	end for;
end TESTBENCH_FOR_fully_associative_tlb;

