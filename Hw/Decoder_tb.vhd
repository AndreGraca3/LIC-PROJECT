library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder_tb is
	end Decoder_tb;
	
architecture behavioral of Decoder_tb is

component Decoder is

	port(
		S1 : in STD_LOGIC;
		S0 : in STD_LOGIC;
		Output : out STD_LOGIC_VECTOR
		);
end component;

--UUT SIGNALS

signal S1_tb : std_logic;
signal S0_tb : std_logic;
signal Output_tb : std_logic_vector(3 downTo 0);

begin

--Unit Under Test
UUT: Decoder
		port map(S0 => S0_tb, S1 => S1_tb, Output => Output_tb);

stimulus: process
begin
	--reset
	S0_tb <= '0';
	S1_tb <= '0';	
	wait for 20 ns;
	S0_tb <= '1';
	wait for 20 ns;
	S1_tb <= '1';
	S0_tb <= '0';
	wait for 20 ns;
	S0_tb <= '1';
	wait for 20 ns;
	wait;
end process;

end behavioral;