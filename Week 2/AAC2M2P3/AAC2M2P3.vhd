library ieee;
use ieee.std_logic_1164.all;

entity FSM is
generic (
A : std_logic_vector(1 downto 0) :="00";
B : std_logic_vector(1 downto 0) :="01";
C : std_logic_vector(1 downto 0) :="10"
);

port (In1: in std_logic;
   RST: in std_logic; 
   CLK: in std_logic;
   Out1 : inout std_logic);
end FSM;

architecture behav of FSM is
signal currentState, nextState : std_logic_vector(1 downto 0) ;
begin
	comb : process(In1, currentState)
	begin
		case(currentState) is 
			when A => 
				if ( In1 = '1') then 
					nextState <= B;
					 Out1 <= '0';
				else 
					nextState <= A;
					 Out1 <= '0';
				end if;
			when B => 
				if ( In1 = '1') then
					 nextState <= B;
					 Out1 <= '0';
				else 
					 nextState <= C;
					 Out1 <= '1';
				end if;
			when C => 
				if ( In1 = '1') then
					 nextState <= A;
					 Out1 <= '0';
				else 
					nextState <= C;
					 Out1 <= '1';
				end if;
			when others => nextState <= A;
		end case; 
 	end process comb;
	synch : process (clk, rst) 
		begin
		if ( RST = '1') then currentState <= A;
		elsif ( rising_edge(CLK)) then currentState <= nextState;
		end if;
		
	end process synch;
end behav;