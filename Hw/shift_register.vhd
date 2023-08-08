library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
	port(
		Sin	: in STD_LOGIC;
		CLK	: in STD_LOGIC;
		enable	: in STD_LOGIC;
		D		: out STD_LOGIC_VECTOR(9 downto 0)
		);
end shift_register;

architecture Behavioral of shift_register is

signal q	:	std_logic_vector(9 downto 0);

begin

	shiftBits: process(Sin,CLK)
	begin 
			if(enable = '1' and rising_edge(CLK)) then
				q(0) <= q(1);
				q(1) <= q(2);
				q(2) <= q(3);
				q(3) <= q(4);
				q(4) <= q(5);
				q(5) <= q(6);
				q(6) <= q(7);
				q(7) <= q(8);
				q(8) <= q(9);
				q(9) <= Sin;
				end if;
	end process;
	
	D <= q;
	
end Behavioral;