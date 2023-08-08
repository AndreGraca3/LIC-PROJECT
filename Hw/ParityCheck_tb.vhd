library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ParityCheck_tb is
	end ParityCheck_tb;
	
architecture behavioral of ParityCheck_tb is

component ParityCheck is

	port(
		clk : in  STD_LOGIC;
		data : in  STD_LOGIC;
		init : in  STD_LOGIC;
		err : out  STD_LOGIC
		);
end component;

--UUT SIGNALS
constant MCLK_PERIOD	: time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD/2;

signal data_tb : std_logic;
signal CLK_tb : std_logic;
signal init_tb : std_logic;
signal err_tb : std_logic;

begin

--Unit Under Test
UUT: ParityCheck
		port map(data => data_tb,
					clk => CLK_tb,
					init => init_tb,
					err => err_tb);

stimulus: process
begin
	--reset
	data_tb <= '0';
	CLK_tb <= '0';
	init_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '0';
	data_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '0';	
	wait for MCLK_PERIOD;
	init_tb <= '0';
	data_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '0';
	wait for MCLK_PERIOD;
	CLK_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '0';
	wait for MCLK_PERIOD;
	data_tb <= '0';
	wait for MCLK_PERIOD;
	CLK_tb <= '1';
	wait for MCLK_PERIOD;
	CLK_tb <= '0';
	wait for MCLK_PERIOD;
	
	wait;
end process;

end behavioral;