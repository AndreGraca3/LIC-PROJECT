library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TicketDispenser_tb is
	end TicketDispenser_tb;
	
architecture behavioral of TicketDispenser_tb is

component TicketDispenser is

	port(
			FnINT	: in STD_LOGIC;
		Prt : in STD_LOGIC;
		RT : in STD_LOGIC;
		DId : in STD_LOGIC_VECTOR(3 downTo 0);
		OId : in STD_LOGIC_VECTOR(3 downTo 0);
		RT_out : out STD_LOGIC_VECTOR(7 downTo 0);
		DId_out : out STD_LOGIC_VECTOR(7 downTo 0);
		OId_out : out STD_LOGIC_VECTOR(7 downTo 0);
		Fn : out STD_LOGIC;
		Print : out STD_LOGIC
		);
end component;

--UUT SIGNALS

signal FNINT_tb :  STD_LOGIC;
signal Prt_tb :  STD_LOGIC;
signal RT_tb : STD_LOGIC;
signal Did_tb : STD_LOGIC_VECTOR(3 downTo 0);
signal OId_tb :  STD_LOGIC_VECTOR(3 downTo 0);
signal RT_out_tb : STD_LOGIC_VECTOR(7 downTo 0);
signal Did_out_tb :  STD_LOGIC_VECTOR(7 downTo 0);
signal OId_out_tb : STD_LOGIC_VECTOR(7 downTo 0);
signal Fn_tb : STD_LOGIC;
signal Print_tb : STD_LOGIC;

begin

--Unit Under Test
UUT: TicketDispenser
		port map(FNINT => FNINT_tb,
			Prt => Prt_tb,
			RT => RT_tb,
			Did => Did_tb,
			OId => OId_tb,
			RT_out => RT_out_tb,
			Did_out => Did_out_tb,
			OId_out => OId_out_tb,
			Fn => Fn_tb,
			Print => Print_tb
			);

stimulus : PROCESS
	begin
		
		FNINT_tb <= '0';
		Prt_tb <= '1';
		Did_tb <= "1010";
		OId_tb <= "0010";
		RT_tb <= '0';
		wait for 20 ns;
		
		FNINT_tb <= '1';
		Prt_tb <= '0';
		wait;
		
end process;

end behavioral;