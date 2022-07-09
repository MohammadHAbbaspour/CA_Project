library storage;
use storage.my_package.all;

	-- Add your library and packages declaration here ...

entity pagetable_tb is
end pagetable_tb;

architecture TB_ARCHITECTURE of pagetable_tb is
	-- Component declaration of the tested unit
	component pagetable
	port(
		w_bit : in STD_LOGIC;
		vpn : in STD_LOGIC_VECTOR(8 downto 0);
		write_ppn : in STD_LOGIC_VECTOR(3 downto 0);
		read_ppn : out STD_LOGIC_VECTOR(3 downto 0);
		hit : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
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
			w_bit => w_bit,
			vpn => vpn,
			write_ppn => write_ppn,
			read_ppn => read_ppn,
			hit => hit
		);

	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_pagetable of pagetable_tb is
	for TB_ARCHITECTURE
		for UUT : pagetable
			use entity work.pagetable(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_pagetable;

