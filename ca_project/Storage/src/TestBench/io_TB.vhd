library storage;
use storage.my_package.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity io_tb is
end io_tb;

architecture TB_ARCHITECTURE of io_tb is
	-- Component declaration of the tested unit
	component io
	port(
		idxin : in INTEGER;
		dataout : out STD_LOGIC_VECTOR(7 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal idxin : INTEGER;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal dataout : STD_LOGIC_VECTOR(7 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : io
		port map (
			idxin => idxin,
			dataout => dataout
		);

	-- Add your stimulus here ... 
	process
	begin	   
		idxin <= 0;
		wait for 50 ns;
		idxin <= 1;
		wait for 50 ns;
		idxin <= 2;
		wait for 50 ns;
	end process;
	

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_io of io_tb is
	for TB_ARCHITECTURE
		for UUT : io
			use entity work.io(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_io;

