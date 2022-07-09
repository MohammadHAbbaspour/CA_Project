library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;  
use work.my_package.all;


------------------------------------------------------ design of Direct Map Cach -----------------------------------------------------------
entity Direct_Cach is
	port (
		r_bit : in std_logic;
		w_bit : in std_logic; 
		ph_add : in std_logic_vector(10 downto 0);
		write_data_from_memory : in two_word_data_Type;
		read_data : out std_logic_vector(7 downto 0);
		hit : out std_logic
	);
end Direct_Cach;  


architecture Direct_Cach_behavioral of Direct_Cach is
signal valid : std_logic_vector(31 downto 0) := (others => '0');
signal cach_data : cach_data_blocks_type := (others => (others => (others => '0')));	 
signal tags : tag_data_type := (others => (others => '0'));
begin
	process (ph_add)
	is
		variable byte_offset : std_logic_vector(1 downto 0) := ph_add(1 downto 0);
		variable word_offset : std_logic := ph_add(2);
		variable index : std_logic_vector(4 downto 0) := ph_add(7 downto 3);
		variable tag : std_logic_vector(2 downto 0) := ph_add(10 downto 8);
		variable d : two_word_data_Type;
		variable word : std_logic_vector(31 downto 0);
	begin
		if r_bit = '1' then
			if valid(to_integer(unsigned(index))) = '0' then
				valid(to_integer(unsigned(index))) <= '1';
				hit <= '0';
			elsif tags(to_integer(unsigned(index))) = tag then
				hit <= '1';
				d := cach_data(to_integer(unsigned(index)));
				if word_offset = '0' then
					word := d(0);
				else
					word := d(1);
				end if;
				read_data <= word(to_integer(unsigned(byte_offset)) * 8 + 7 downto to_integer(unsigned(byte_offset)) * 8);
			else
				hit <= '0';
			end if;	
		end if;
		if w_bit = '1' then
			valid(to_integer(unsigned(index))) <= '1';
			cach_data(to_integer(unsigned(index))) <= write_data_from_memory;
			tags(to_integer(unsigned(index))) <= tag;
		end if;
	end process;
	
end	Direct_Cach_behavioral;	 
------------------------------------------------------------------------------------------------------------------------------------------



-------------------------------------------------------Design of Two-Way set assosiative cache--------------------------------------------
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;  
use work.my_package.all;

entity TwoWay_Cach is
	port (
		r_bit : in std_logic;
		w_bit : in std_logic; 
		ph_add : in std_logic_vector(10 downto 0);
		write_data_from_memory : in two_word_data_Type;
		read_data : out std_logic_vector(7 downto 0);
		hit : out std_logic
	);
end TwoWay_Cach;  


architecture behavioral of TwoWay_Cach is
signal valid : valid2setarray := (others => (others => '0'));
signal cach_data : cache2setarray := (others => (others => (others => (others => '0'))));	 
signal tags : tag2setarray := (others => (others => (others => '0'))); 
signal sel: std_logic := '1';
begin
	process (ph_add)
	is
		variable byte_offset : std_logic_vector(1 downto 0) := ph_add(1 downto 0);
		variable word_offset : std_logic := ph_add(2);
		variable index : std_logic_vector(4 downto 0) := ph_add(7 downto 3);
		variable tag : std_logic_vector(2 downto 0) := ph_add(10 downto 8);
		variable d : two_word_data_Type;
		variable word : std_logic_vector(31 downto 0);
	begin
		if r_bit = '1' then
			if (valid(to_integer(unsigned(index)))(0) = '1') and (tags(to_integer(unsigned(index)))(0) = tag) then
				hit <= '1';
				d := cach_data(to_integer(unsigned(index)))(0);
				if word_offset = '0' then
					word := d(0);
				else
					word := d(1);
				end if;
				read_data <= word(to_integer(unsigned(byte_offset)) * 8 + 7 downto to_integer(unsigned(byte_offset)) * 8);
	
			elsif (valid(to_integer(unsigned(index)))(1) = '1') and (tags(to_integer(unsigned(index)))(1) = tag) then
				hit <= '1';
				d := cach_data(to_integer(unsigned(index)))(1);
				if word_offset = '0' then
					word := d(0);
				else
					word := d(1);
				end if;
				read_data <= word(to_integer(unsigned(byte_offset)) * 8 + 7 downto to_integer(unsigned(byte_offset)) * 8);
			else
				hit <= '0';
			end if;
		end if;
		if w_bit = '1' then
			valid(to_integer(unsigned(index)))(to_integer(unsigned'('0' & sel))) <= '1';
			cach_data(to_integer(unsigned(index)))(to_integer(unsigned'('0' & sel))) <= write_data_from_memory;
			tags(to_integer(unsigned(index)))(to_integer(unsigned'('0' & sel))) <= tag;
			sel <= not(sel);
		end if;
	end process;
	
end	behavioral;