library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

use work.my_package.all;

	-- Add your library and packages declaration here ...

entity storage_tb is
end storage_tb;

architecture TB_ARCHITECTURE of storage_tb is
	-- Component declaration of the tested unit
	component storage
	port(
		r_bit : in STD_LOGIC;
		storage_add : in STD_LOGIC_VECTOR(8 downto 0);
		page : out page_type );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal r_bit : STD_LOGIC;
	signal storage_add : STD_LOGIC_VECTOR(8 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal page : page_type;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : storage
		port map (
			r_bit => r_bit,
			storage_add => storage_add,
			page => page
		);

	-- Add your stimulus here ...
	process
	is
	begin		
		r_bit <= '1';
		storage_add <= "000000001";
		wait for 10 ms;
		r_bit <= '0';
		storage_add <= "000000010";
		wait for 10 ms;
		r_bit <= '1';
		storage_add <= "000000000";	
		wait for 10 ms;
		r_bit <= '0';
		storage_add <= "000000001";
		wait;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_storage of storage_tb is
	for TB_ARCHITECTURE
		for UUT : storage
			use entity work.storage(storage_behavioral);
		end for;
	end for;
end TESTBENCH_FOR_storage;

