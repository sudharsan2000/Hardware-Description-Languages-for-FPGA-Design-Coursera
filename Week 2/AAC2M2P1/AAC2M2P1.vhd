LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity AAC2M2P1 is port (                 	
   CP: 	in std_logic; 	-- clock
   SR:  in std_logic;  -- Active low, synchronous reset
   P:    in std_logic_vector(3 downto 0);  -- Parallel input
   PE:   in std_logic;  -- Parallel Enable (Load)
   CEP: in std_logic;  -- Count enable parallel input
   CET:  in std_logic; -- Count enable trickle input
   Q:   out std_logic_vector(3 downto 0);            			
    TC:  out std_logic  -- Terminal Count
);            		
end AAC2M2P1;

architecture LS163 of AAC2M2P1 is

signal temp: std_logic_vector(3 downto 0);

begin

process(CP,CET,CEP) begin

if (rising_edge(CP) and SR = '0') then

temp <= "0000";

elsif (rising_edge(CP)) then

if (PE = '0') then

temp <= P;

elsif(CET = '1' and CEP = '1') then

temp <= temp + 1;

end if;

end if;

end process;

Q <= temp;

TC <= temp(0) and temp(1) and temp(2) and temp(3) and CET;

end LS163;