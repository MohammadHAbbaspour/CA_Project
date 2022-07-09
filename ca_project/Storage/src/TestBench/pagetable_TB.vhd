library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;
use work.my_package.all;

	-- Add your library and packages declaration here ...

entity pagetable_tb is
end pagetable_tb;

architecture TB_ARCHITECTURE of pagetable_tb is
	-- Component declaration of the tested unit
	component pagetable
	port(
		r_bit : in STD_LOGIC;
		w_bit : in STD_LOGIC;
		vpn : in STD_LOGIC_VECTOR(8 downto 0);
		write_ppn : in STD_LOGIC_VECTOR(3 downto 0);
		read_ppn : out STD_LOGIC_VECTOR(3 downto 0);
		hit : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal r_bit : STD_LOGIC;
	signal w_bit : STD_LOGIC;
	signal vpn : STD_LOGIC_VECTOR(8 downto 0);
	signal write_ppn : STD_LOGIC_VECTOR(3 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal read_ppn : STD_LOGIC_VECTOR(3 downto 0);
	signal hit : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : pagetable
		port map (
			r_bit => r_bit,
			w_bit => w_bit,
			vpn => vpn,
			write_ppn => write_ppn,
			read_ppn => read_ppn,
			hit => hit
		);

	-- Add your stimulus here ...
	
	process
	is
	begin		
		r_bit <= '0';
		w_bit <= '1';
		vpn <= "000101001";
		write_ppn <= "1010";
		wait for 200 ns;
		r_bit <= '1';
		w_bit <= '0';
		vpn <= "000100001";
		write_ppn <= "0000";
		wait for 200 ns;
		r_bit <= '1';
		w_bit <= '0';
		vpn <= "000101001";
		write_ppn <= "0000"; 
		wait for 200 ns;
		r_bit <= '1';
		w_bit <= '0';
		vpn <= "000101001";
		write_ppn <= "0000";
		wait;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_pagetable of pagetable_tb is
	for TB_ARCHITECTURE
		for UUT : pagetable
			use entity work.pagetable(pagetable_behavioral);
		end for;
	end for;
end TESTBENCH_FOR_pagetable;

