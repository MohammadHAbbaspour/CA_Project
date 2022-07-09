library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;



------------------------------------------------- Proccessor design ----------------------------------------------------
entity Processor is 
	port (
	index : in integer;
	vr_add : out std_logic_vector(15 downto 0);
	r_bit : in std_logic
	);
end Processor;	  


architecture Processor_behavioral of Processor is
begin  
	process (index)
	is	
	type virtual_address is array (0 to 3) of std_logic_vector(15 downto 0);	 -- should be (0 to 99)
		variable v_addrs : virtual_address := ("1011001101010111",
												"1101110111010010",
												"0111101100101111",
												"1101111100011011");
	begin
		vr_add <= v_addrs(index);				   
	end process;
end	Processor_behavioral;
------------------------------------------------------------------------------------------------------------------------