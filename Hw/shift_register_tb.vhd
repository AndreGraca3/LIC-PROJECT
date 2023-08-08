library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register_tb is
	end shift_register_tb;
	
architecture behavioral of shift_register_tb is

component shift_register is

	port(
		Sin	: in STD_LOGIC;
		CLK	: in STD_LOGIC;
		enable	: in STD_LOGIC;
		D		: out STD_LOGIC_VECTOR(9 downto 0)
		);
end component;

--UUT SIGNALS
constant MCLK_PERIOD	: time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD/2;

signal Sin_tb : std_logic;
signal CLK_tb : std_logic;
signal enable_tb : std_logic;
signal D_tb : std_logic_vector(9 downto 0);

begin

--Unit Under Test
UUT: shift_register
		port map(Sin => Sin_tb,
					CLK => CLK_tb,
					enable => enable_tb,
					D => D_tb);

stimulus: process
begin
	--reset
	Sin_tb <= '0';
	CLK_tb <= '0';
	enable_tb <= '0';
	wait for MCLK_PERIOD;
	CLK_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '0';
	wait for MCLK_PERIOD;
	enable_tb <= '1';
	Sin_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '0';
	wait for MCLK_PERIOD;	
	CLK_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '0';
	wait for MCLK_PERIOD;
	CLK_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '0';
	wait for MCLK_PERIOD;
	Sin_tb <= '0';
	wait for MCLK_PERIOD;
	CLK_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '0';
	wait for MCLK_PERIOD;	
	CLK_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '0';
	wait for MCLK_PERIOD;
	CLK_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '0';
	wait for MCLK_PERIOD;
	
	wait;
end process;

end behavioral;