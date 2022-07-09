library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all; 
use work.my_package.all;



----------------------------------------------------- design of Fully Associative TLB ------------------------------------------------------
entity Fully_Associative_TLB is 	
	port (
		r_bit : in std_logic;
		w_bit : in std_logic;
		vpn : in std_logic_vector(8 downto 0); 
		ppn_from_pt : in std_logic_vector(3 downto 0);
		ppn : out std_logic_vector(3 downto 0);
		hit : out std_logic
	);
end Fully_Associative_TLB;	


architecture TLB_behavioral of Fully_Associative_TLB is
signal ppns : TLB_ppn_type := (others => ( others => '0' ));
signal tags : TLB_tag_type := (others => ( others => '0' ));
signal valid : std_logic_vector(47 downto 0);
signal sel : integer := 0;
begin
	process (vpn)
	is
	begin
		if r_bit = '1' then
			hit <= '0';
			for i in 0 to 47 loop
				if valid(i) = '1' and tags(i) = vpn then
					ppn <= ppns(i);
					hit<= '1';
					exit;
				end if;
			end loop;
		end if;
		if w_bit = '1' then
			valid(sel) <= '1';
			tags(sel) <= vpn;
			ppns(sel) <= ppn_from_pt;
			sel <= (sel + 1) mod 48;
		end if;
	end process;
end	TLB_behavioral;	
-----------------------------------------------------------------------------------------------------------------------------------------