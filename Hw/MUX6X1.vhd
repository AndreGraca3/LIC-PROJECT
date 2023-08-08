library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX6X1 is
	Port (
		S2 : in STD_LOGIC;
		S1 : in STD_LOGIC;
		S0: in STD_LOGIC;
		In0 : in STD_LOGIC;
		In1 : in STD_LOGIC;
		In2 : in STD_LOGIC;
		In3 : in STD_LOGIC;
		In4 : in STD_LOGIC;
		In5 : in STD_LOGIC;
		Y : out STD_LOGIC
	);
	
end MUX6X1;

architecture Behavioral of MUX6X1 is

begin

check : process(S0, S1, S2)
begin

	if(S2 = '0' and S1 = '0' and S0 = '0') then
	Y <= In0;
	elsif(S2 = '0' and S1 = '0' and S0 = '1') then
	Y <= In1;
	elsif(S2 = '0' and S1 = '1' and S0 = '0') then
	Y <= In2;
	elsif(S2 = '0' and S1 = '1' and S0 = '1') then
	Y <= In3;
	elsif(S2 = '1' and S1 = '0' and S0 = '0') then
	Y <= In4;
	elsif(S2 = '1' and S1 = '0' and S0 = '1') then
	Y <= In5;	
	end if;
	
end process;


end Behavioral;