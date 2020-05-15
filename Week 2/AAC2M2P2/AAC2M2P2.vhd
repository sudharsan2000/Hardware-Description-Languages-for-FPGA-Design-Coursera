LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

ENTITY RAM128_32 IS
	PORT
	(
		address	: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END RAM128_32;

architecture Behavioral of RAM128_32 is
type RAM_ARRAY is array (0 to 127 ) of std_logic_vector (31 downto 0);
-- initial values in the RAM
signal RAM: RAM_ARRAY ;
begin
process(clock)
begin
 if(rising_edge(clock)) then
 if(wren='1') then -- when write enable = 1, 
 -- write input data into RAM at the provided address
 RAM(to_integer(unsigned(address))) <= data;
 -- The index of the RAM array type needs to be integer so
 -- converts address from std_logic_vector -> Unsigned -> Interger using numeric_std library
 end if;
 end if;
end process;
 -- Data to be read out 
 q <= RAM(to_integer(unsigned(address)));
end Behavioral;
