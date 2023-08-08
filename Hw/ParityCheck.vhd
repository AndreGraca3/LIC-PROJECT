library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ParityCheck is
	Port ( 
		clk : in  STD_LOGIC;
		data : in  STD_LOGIC;
		init : in  STD_LOGIC;
		err : out  STD_LOGIC
	);
	
end ParityCheck;

architecture Behavioral of ParityCheck is

	signal estado: STD_LOGIC; -- guarda estado do parity check

begin
	
	check: process (init, clk)
	begin
		if (init = '1') then -- reset
			estado <= '0';
		elsif (rising_edge(clk)) then
			estado <= data xor estado;		
		end if;
	end process;
	
	err <= estado; -- como queremos paridade par, enviamos "estado" para "err"

end Behavioral;