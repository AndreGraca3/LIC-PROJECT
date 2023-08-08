library IEEE;
use  IEEE.STD_LOGIC_1164.ALL;

entity CounterLogic_4bit is
	Port ( operandA : in STD_LogiC_VECTOR (3 downto 0);
			en : in STD_LOGIC;
			R : out STD_Logic_VECTOR (3 downto 0)	
			 );
end CounterLogic_4bit;

architecture Structural of CounterLogic_4bit is

component adder_4bit is
	Port( A : in STD_LOGIC_VECTOR(3 downto 0);
			B : in STD_LOGIC_VECTOR(3 downto 0);
			Cin : in STD_LOGIC;
			S : out STD_LOGIC_VECTOR(3 downto 0);
			Cout : out STD_LOGIC);
end component;

component MUX2x1 is
	Port(Sel : in STD_LOGIC;
		In0 : in STD_LOGIC_VECTOR(3 downTo 0);
		In1 : in STD_LOGIC_VECTOR(3 downTo 0);
		Y : out STD_LOGIC_VECTOR(3 downTo 0)
		);
end component;

signal operandB : std_logic_vector(3 downTo 0);

begin
		
U0:	adder_4bit
		port map(A => operandA, B => operandB, Cin => '0', S => R, Cout => open);
		
U1: MUX2X1
		port map(In0 => "0000", In1 => "0001", Sel => en, Y => operandB);

end Structural;