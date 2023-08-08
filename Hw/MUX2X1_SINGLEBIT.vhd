library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2X1_SINGLEBIT is
	Port (
		Sel : in STD_LOGIC;
		In0 : in STD_LOGIC;
		In1 : in STD_LOGIC;
		Y : out STD_LOGIC
	);
	
end MUX2X1_SINGLEBIT;

architecture Behavioral of MUX2X1_SINGLEBIT is
begin

Y <= In0 when sel = '0' else In1;


end Behavioral;