library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity processor_tb is
end processor_tb;

architecture TB_ARCHITECTURE of processor_tb is
	-- Component declaration of the tested unit
	component processor
	port(
		index : in INTEGER;
		vr_add : out STD_LOGIC_VECTOR(15 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal index : INTEGER;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal vr_add : STD_LOGIC_VECTOR(15 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : processor
		port map (
			index => index,
			vr_add => vr_add
		);

	-- Add your stimulus here ...	   
	process 
	is 
	begin	
		index <= 1;
		wait for 200 ns	;
		index <= 3;	 
		wait for 200 ns;
		wait;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_processor of processor_tb is
	for TB_ARCHITECTURE
		for UUT : processor
			use entity work.processor(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_processor;

