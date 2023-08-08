library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX6X1_tb is
	end MUX6X1_tb;
	
architecture behavioral of MUX6X1_tb is

component MUX6X1 is

	port(
		S2 : in STD_LOGIC;
		S1 : in STD_LOGIC;
		S0 : in STD_LOGIC;
		In0 : in STD_LOGIC;
		In1 : in STD_LOGIC;
		In2 : in STD_LOGIC;
		In3 : in STD_LOGIC;
		Y : out STD_LOGIC
		);
end component;

--UUT SIGNALS
signal S2_tb : std_logic;
signal S1_tb : std_logic;
signal S0_tb : std_logic;
signal In0_tb : std_logic;
signal In1_tb : std_logic;
signal In2_tb : std_logic;
signal In3_tb : std_logic;
signal Y_tb : std_logic;

begin

--Unit Under Test
UUT: MUX6X1
		port map(In0 => In0_tb, In1 => In1_tb, In2 => In2_tb, In3 => In3_tb, S0 => S0_tb, S1 => S1_tb, S2 => S2_tb,
		Y => Y_tb);

stimulus: process
begin
	--reset
	In0_tb <= '1';
	In1_tb <= '0';
	In2_tb <= '1';
	In3_tb <= '0';
	S0_tb <= '0';
	S1_tb <= '0';	
	S2_tb <= '0';
	wait for 20 ns;
	S0_tb <= '1';
	wait for 20 ns;
	S1_tb <= '1';
	S0_tb <= '0';
	wait for 20 ns;
	S0_tb <= '1';
	wait for 20 ns;
	S2_tb <= '1';
	S1_tb <= '0';
	S0_tb <= '0';
	wait for 20 ns;
	wait;
end process;

end behavioral;