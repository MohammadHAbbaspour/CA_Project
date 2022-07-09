library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all; 
use work.my_package.all;

entity io is 	
	port(									   
	idxout : out integer;
	vraddrout : out std_logic_vector(15 downto 0)
	);
end io;	   

architecture behavioral of io is
component Processor is 
	port (
	index : in integer;
	vr_add : out std_logic_vector(15 downto 0)
	);
end component; 

signal idx: integer := 1;
signal vraddr: std_logic_vector(15 downto 0);
begin
	process
	is
	begin
		--------
		idx := 1;
		prcs: Processor port map(index => idx, vr_add => vraddr);
		
		
		--------
	end process;
end	behavioral;	