library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_1bit is
	port(
		D	: in STD_LOGIC;
		CLK	: in STD_LOGIC;
		Q		: out STD_LOGIC;
		rst	: in STD_LOGIC
		);
end register_1bit;


architecture Behavioral of register_1bit is

begin
	
	if(rst = '0' and  rising_edge(CLK)) then
		Q <= D;
	end if;
	
	if(rst = '1' and  rising_edge(CLK)) then
		Q <= '0';
	end if;
	
end Behavioral;