library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;
use work.my_package.all;


entity PageTable is
  port (
    w_bit : in std_logic;
    vpn : in std_logic_vector(8 downto 0);
    write_ppn : in std_logic_vector(3 downto 0);
    read_ppn : out std_logic_vector(3 downto 0);
    hit : out std_logic
  );
end PageTable; 



architecture behavioral of PageTable is
signal ppns : ppnarray:= (others => (others => '0'));  
signal valid: std_logic_vector(0 to 511) := (others => '0');
begin 
  process (vpn)  
  is 
  begin
    if w_bit = '0' then
      hit <= '0';
      if valid(to_integer(unsigned(vpn))) = '1' then
        read_ppn <= ppns(to_integer(unsigned(vpn)));
        hit <= '1';
      end if;
        end if;     
    if w_bit = '1' then
      valid(to_integer(unsigned(vpn))) <= '1';
      ppns(to_integer(unsigned(vpn))) <= write_ppn;
    end if;
  end process;
end  behavioral;

----------------------------------------------------------------------------------------------------------------------------------------