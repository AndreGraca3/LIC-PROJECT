library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity KeyControl_tb is
	end KeyControl_tb;
	
architecture behavioral of KeyControl_tb is

component KeyControl is

	port(
			RESET : in STD_LOGIC;
			MCLK : in STD_LOGIC;
			Kack : in STD_LOGIC;
			Kpress : in STD_LOGIC;
			Kval : out STD_LOGIC;
			Kscan : out STD_LOGIC
		);
end component;

--UUT SIGNALS
constant MCLK_PERIOD	: time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD/2;

signal RESET_tb :  STD_LOGIC;
signal MCLK_tb :  STD_LOGIC;
signal Kack_tb : STD_LOGIC;
signal Kpress_tb : STD_LOGIC;
signal Kval_tb :  STD_LOGIC;
signal Kscan_tb :  STD_LOGIC;

begin

--Unit Under Test
UUT: KeyControl
		port map(MCLK => MCLK_tb,
			RESET => RESET_tb,
			Kack => Kack_tb,
			Kpress => Kpress_tb,
			Kval => Kval_tb,
			Kscan => Kscan_tb
			);
				
clk_gen : process
begin
		MCLK_tb <= '0';
		wait for MCLK_HALF_PERIOD;
		MCLK_tb <= '1';
		wait for MCLK_HALF_PERIOD;
end process;

stimulus : PROCESS
	begin
		RESET_tb <= '0';
		Kpress_tb <= '0';
		Kack_tb <= '0';
		wait for MCLK_PERIOD;
		
		-- 00 -> 00
		Kpress_tb <= '0';
		wait for MCLK_PERIOD;
		
		-- 00 -> 01
		Kpress_tb <= '1';
		wait for MCLK_PERIOD;
		
		-- 01 -> 01
		Kack_tb <= '0';
		wait for MCLK_PERIOD;
		
		-- 01 -> 10
		Kack_tb <= '1';
		wait for MCLK_PERIOD;
		
		-- 10 -> 10
		Kpress_tb <= '1';
		wait for MCLK_PERIOD;
		
		-- 10 -> 00
		Kpress_tb <= '0';
		wait for MCLK_PERIOD;
		
		wait;
		
end process;

end behavioral;