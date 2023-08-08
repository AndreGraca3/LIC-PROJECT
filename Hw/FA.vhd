library IEEE;
use  IEEE.STD_LOGIC_1164.ALL;

entity FA is
	Port ( A : in STD_Logic;
			 B : in STD_Logic;
			 Cin : in STD_Logic;
			 S : out STD_Logic;
			 Cout : out STD_Logic);
end FA;

architecture Behavioral of FA is
	signal xor_ab	: std_logic;
	signal and_ab	: std_logic;
begin
	xor_ab	<= A xor B;
	and_Ab	<= A and B;
	
	S			<= xor_ab xor Cin;
	
	Cout		<= and_ab or ( Cin and xor_ab );
	
end Behavioral;