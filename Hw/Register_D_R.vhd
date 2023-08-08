library IEEE;
use  IEEE.STD_LOGIC_1164.ALL;

entity register_D_R is
	generic(
		WIDTH : POSITIVE := 1
	);
	Port ( CLK : in STD_LogiC;
			 Enable : in STD_LOGIC;
			 D : in STD_Logic_VECTOR (WIDTH-1 downto 0);
			 Q : out STD_Logic_VECTOR (WIDTH-1 downto 0);
			 RST : in STD_LOGIC);
end register_D_R;

architecture Behavioral of register_D_R is

begin

	Q <= (others => '0') when RST = '1' else D when (rising_edge(clk) and Enable = '1');
	
end Behavioral;