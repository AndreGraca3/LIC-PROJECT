library IEEE;
use  IEEE.STD_LOGIC_1164.ALL;

entity adder_4bit is
	Port ( A : in STD_LogiC_VECTOR (3 downto 0);
			 B : in STD_Logic_VECTOR (3 downto 0);
			 Cin : in STD_Logic;
			 S : out STD_Logic_VECTOR (3 downto 0);
			 Cout : out STD_Logic);
end adder_4bit;

architecture Structural of adder_4bit is
component FA is
	Port ( A : in STD_Logic;
			 B : in STD_Logic;
			 Cin : in STD_Logic;
			 S : out STD_Logic;
			 Cout : out STD_Logic);
end component;

signal carry		: std_logic_vector(3 downto 1);
begin
U0:		FA
			port map(A => A(0), B => B(0), Cin => Cin, S => S(0), Cout => carry(1));
			
U1:		FA
			port map(A => A(1), B => B(1), Cin => carry(1), S => S(1), Cout => carry(2));
			
U2:		FA
			port map(A => A(2), B => B(2), Cin => carry(2), S=> S(2), Cout => carry(3));
			
U3:		FA
			port map(A => A(3), B => B(3), Cin => carry(3), S=> S(3), Cout => Cout);			
			
end Structural;