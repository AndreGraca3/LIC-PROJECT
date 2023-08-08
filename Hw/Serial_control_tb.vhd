library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SerialControl_tb is
	end SerialControl_tb;
	
architecture behavioral of SerialControl_tb is

component SerialControl is

	port(
			RESET : in STD_LOGIC;
			MCLK : in  STD_LOGIC;
			nSS : in  STD_LOGIC;
			accept : in  STD_LOGIC;
			pFlag : in  STD_LOGIC;
			dFlag : in  STD_LOGIC;
			RXerror : in  STD_LOGIC;
			busy : out STD_LOGIC;
			wr : out  STD_LOGIC;
			init : out  STD_LOGIC;
			DXval : out  STD_LOGIC
		);
end component;

--UUT SIGNALS
constant MCLK_PERIOD	: time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD/2;

signal clk_tb :  STD_LOGIC;
signal rst_tb :  STD_LOGIC;
signal nSS_tb : STD_LOGIC;
signal accept_tb : STD_LOGIC;
signal pFlag_tb :  STD_LOGIC;
signal dFlag_tb :  STD_LOGIC;
signal RXerror_tb : STD_LOGIC;
signal busy_tb : STD_LOGIC;
signal wr_tb : STD_LOGIC;
signal init_tb : STD_LOGIC;
signal DXval_tb : STD_LOGIC;

begin

--Unit Under Test
UUT: SerialControl
		port map(MCLK => clk_tb,
			RESET => rst_tb,
			nSS => nSS_tb,
			accept => accept_tb,
			pFlag => pFlag_tb,
			dFlag => dFlag_tb,
			RXerror => RXerror_tb,
			busy => busy_tb,
			wr => wr_tb,
			init => init_tb,
			DXval => DXval_tb
			);
				
clk_gen : process
begin
		clk_tb <= '0';
		wait for MCLK_HALF_PERIOD;
		clk_tb <= '1';
		wait for MCLK_HALF_PERIOD;
end process;

stimulus : PROCESS
	begin
		rst_tb <= '0';
		RXerror_tb <= '0';
		dFlag_tb <= '0';
		pFlag_tb <= '0';
		accept_tb <= '0';
		wait for MCLK_PERIOD;
		
		-- 00 -> 00
		nSS_tb <= '1';
		wait for MCLK_PERIOD;
		
		-- 00 -> 01
		nSS_tb <= '0';
		wait for MCLK_PERIOD;
		
		-- 01 -> 01
		nSS_tb <= '0';
		wait for MCLK_PERIOD;
		
		-- 01 -> 01
		nSS_tb <= '0';
		dFlag_tb <= '0';
		wait for MCLK_PERIOD;
		
		-- 01 -> 10
		nSS_tb <= '0';
		dFlag_tb <= '1';
		wait for MCLK_PERIOD;
		
		-- 10 -> 10
		pFlag_tb <= '0';
		wait for MCLK_PERIOD;
		
		-- TO TEST: RXerror = 1 (10 -> 00)
		
		-- 10 -> 11
		pFlag_tb <= '1';
		RXerror_tb <= '0';
		wait for MCLK_PERIOD;
		
		-- 11 -> 11
		accept_tb <= '0';
		wait for MCLK_PERIOD;
		
		-- 11 -> 00
		accept_tb <= '1';
		wait for MCLK_PERIOD;
		
		rst_tb <= '1';
		wait for MCLK_PERIOD;
		wait;
		
end process;

end behavioral;