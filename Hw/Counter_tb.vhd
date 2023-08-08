library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Counter_tb is
	end Counter_tb;
	
architecture behavioral of Counter_tb is

component Counter_4bit is

	port(
		clk : in  STD_LOGIC;
		clr : in  STD_LOGIC;
		CE : in STD_LOGIC;
		q : out STD_LOGIC_VECTOR (3 downto 0)
		);
end component;

--UUT SIGNALS
constant MCLK_PERIOD	: time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD/2;

signal clr_tb : std_logic;
signal CLK_tb : std_logic;
signal q_tb: std_logic_vector(3 downTo 0);
signal CE_tb : std_logic;

begin

--Unit Under Test
UUT: Counter_4bit
		port map(clr => clr_tb,
					clk => CLK_tb, CE=> CE_tb, q => q_tb);

stimulus: process
begin
	--reset
	CLK_tb <= '0';
	clr_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '0';
	clr_tb <= '0';
	CE_tb <= '1';
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
	CLK_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '0';
	wait for MCLK_PERIOD;
	CLK_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '0';
	wait for MCLK_PERIOD;
	clr_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '1';
	wait for MCLK_PERIOD;	
	wait;
end process;

end behavioral;