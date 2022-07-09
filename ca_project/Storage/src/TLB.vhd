library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all; 
use work.my_package.all;



----------------------------------------------------- design of Fully Associative TLB ------------------------------------------------------
entity Fully_Associative_TLB is 	
	port (	 
		w_bit : in std_logic;
		vpn : in std_logic_vector(8 downto 0);
		ppn : out std_logic_vector(3 downto 0);
		hit : out std_logic;
		ppn_from_pt : in std_logic_vector(3 downto 0)
	);
end Fully_Associative_TLB;	


architecture behavioral of Fully_Associative_TLB is
signal ppns : TLB_ppn_type := (others => ( others => '0' ));
signal tags : TLB_tag_type := (others => ( others => '0' ));
signal valid : std_logic_vector(47 downto 0);
signal sel : integer := 0;
begin
	process (vpn, ppn_from_pt)
	is
	begin
		if w_bit = '0' then
			hit <= '0';
			for i in 0 to 47 loop
				if valid(i) = '1' and tags(i) = vpn then
					ppn <= ppns(i);
					hit<= '1';
					exit;
				end if;
			end loop;
		else
			valid(sel) <= '1';
			tags(sel) <= vpn;
			ppns(sel) <= ppn_from_pt;
			sel <= (sel + 1) mod 48;
		end if;
	end process;
end	behavioral;	
-----------------------------------------------------------------------------------------------------------------------------------------