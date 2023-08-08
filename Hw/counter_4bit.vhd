library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_4Bit is
	Port ( clk : in STD_LOGIC;
			clr : in STD_LOGIC;		
			CE : in STD_LOGIC;
			q : out STD_LOGIC_VECTOR (3 downto 0)
			);
end counter_4Bit;

architecture Structural of counter_4Bit is

	component CounterLogic_4Bit is
		PORT(	operandA : IN std_logic_vector(3 downto 0);
				en : IN STD_LOGIC;
				R : OUT std_logic_vector(3 downto 0)
				);
	end component;

	component register_D_R is
		Generic ( WIDTH : positive := 1 );
		Port(	CLK : in STD_LOGIC;
				Enable : in STD_LOGIC;
				RST : in STD_LOGIC;
				D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);          
				Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0));
	end component;

	signal operandA, result : std_logic_vector(3 downto 0);

	begin

	U0: CounterLogic_4Bit 
			PORT MAP(	operandA => operandA, R => result, en => CE);
	
	U1: register_D_R 
			Generic map (	WIDTH => 4 )
			Port map(
				CLK => clk,
				Enable => '1', 
				RST => clr,
				D => result,
				Q => operandA
			);

	q <= operandA;

end Structural;