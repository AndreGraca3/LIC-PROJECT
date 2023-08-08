library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX4X1 is
	Port (
		S1 : in STD_LOGIC;
		S0 : in STD_LOGIC;
		In0 : in STD_LOGIC;
		In1 : in STD_LOGIC;
		In2 : in STD_LOGIC;
		In3 : in STD_LOGIC;
		Y : out STD_LOGIC
	);
	
end MUX4X1;

architecture Behavioral of MUX4X1 is

begin

check : process(S0, S1)
begin

	if(S1 = '0' and S0 = '0') then
	Y <= In0;
	elsif(S1 = '0' and S0 = '1') then
	Y <= In1;
	elsif(S1 = '1' and S0 = '0') then
	Y <= In2;
	else
	Y <= In3;
	end if;
	
end process;


end Behavioral;