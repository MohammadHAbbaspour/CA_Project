library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

use work.my_package.all;

------- size of RAM = 512 words.
------- size of Page Table = 80 words (we have 2^9 pages, every row has 4 bit for ppn and 1 bit for valid => (4+1)*(2^9)bit = 80 words).
------- size of remaining blocks = 512 - 80 = 432words
------- size of every block = 432/32 = 13  (size of page = 32 words)

------------------------------------------------ design of memory without Page Table --------------------------------------------

entity Memory is
	port (
		w_bit : in std_logic; -- if equals to 0 => read from memmory and write in CACH else write from hard disk in memory
		ph_add : in std_logic_vector(10 downto 0);
		write_data_from_disk : in page_type;
		read_date : out two_word_data_Type
	);
end Memory; 



architecture behavioral of Memory is
signal data : memory_data_blocks_type := (others => (others => (others => '0')));
signal counter : integer := 0;
begin 
	process (ph_add)	
	is 
		variable page_offset : std_logic_vector(6 downto 0);
		variable ppn : std_logic_vector(3 downto 0);  
		variable page : page_type;
	begin
		if w_bit = '1' then
			 data(counter) <= write_data_from_disk;
             counter <= (counter + 1) mod 13;
        else 
			page_offset := ph_add(6 downto 0);
			ppn := ph_add(10 downto 7);
			page := data(to_integer(unsigned(ppn)));
			-----??????------
		end if;
	end process;
end	behavioral;

--------------------------------------------------------------------------------------------------------------------------------------------