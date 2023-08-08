library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2X1 is
	Port (
		Sel : in STD_LOGIC;
		In0 : in STD_LOGIC_VECTOR(3 downTo 0);
		In1 : in STD_LOGIC_VECTOR(3 downTo 0);
		Y : out STD_LOGIC_VECTOR(3 downTo 0)
	);
	
end MUX2X1;

architecture Behavioral of MUX2X1 is
begin

Y <= In0 when sel = '0' else In1;


end Behavioral;