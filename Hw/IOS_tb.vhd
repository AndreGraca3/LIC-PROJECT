library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IOS_tb is
	end IOS_tb;
	
architecture behavioral of IOS_tb is

component IOS is

	port(
			MCLK : in STD_LOGIC;
		RESET : in STD_LOGIC;
		SCLK : in STD_LOGIC;
		SDX: in STD_LOGIC;
		nSS : in STD_LOGIC;
		Fsh : in STD_LOGIC;
		WrT : out STD_LOGIC;
		WrL : out STD_LOGIC;
		busy : out STD_LOGIC;
		Dout : out STD_LOGIC_VECTOR(8 downTo 0)
		);
end component;

--UUT SIGNALS
constant MCLK_PERIOD	: time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD/2;

signal clk_tb :  STD_LOGIC;
signal RESET_tb :  STD_LOGIC;
signal SCLK_tb : STD_LOGIC;
signal SDX_tb : STD_LOGIC;
signal nSS_tb :  STD_LOGIC;
signal Fsh_tb :  STD_LOGIC;
signal WrT_tb : STD_LOGIC;
signal WrL_tb : STD_LOGIC;
signal busy_tb : STD_LOGIC;
signal Dout_tb : STD_LOGIC_VECTOR(8 downTo 0);

begin

--Unit Under Test
UUT: IOS
		port map(MCLK => clk_tb,
			RESET => RESET_tb,
			SCLK => SCLK_tb,
			SDX => SDX_tb,
			nSS => nSS_tb,
			Fsh => Fsh_tb,
			WrT => WrT_tb,
			WrL => WrL_tb,
			busy => busy_tb,
			Dout => Dout_tb
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
		RESET_tb <= '0';
		nSS_tb <= '1';
		Fsh_tb <= '0';
		SDX_tb <= '0';
		
		SCLK_tb <= '0';
		wait for MCLK_PERIOD;
		SCLK_tb <='1';
		wait for MCLK_PERIOD;
		
		nSS_tb <= '0';		--inicia transmissao
		SDX_tb <= '1';   --muda SDX

		SCLK_tb <= '0';
		wait for MCLK_PERIOD;
		SCLK_tb <='1';
		wait for MCLK_PERIOD;

		SCLK_tb <= '0';
		wait for MCLK_PERIOD;
		SCLK_tb <='1';
		wait for MCLK_PERIOD;

		SCLK_tb <= '0';
		wait for MCLK_PERIOD;
		SCLK_tb <='1';
		wait for MCLK_PERIOD;
		
		SDX_tb <= '0';  --muda o SDX
		
		SCLK_tb <= '0';
		wait for MCLK_PERIOD;
		SCLK_tb <='1';
		wait for MCLK_PERIOD;
		
		SCLK_tb <= '0';
		wait for MCLK_PERIOD;
		SCLK_tb <='1';
		wait for MCLK_PERIOD;
		
		SDX_tb <= '1';  --muda o SDX
		
		SCLK_tb <= '0';
		wait for MCLK_PERIOD;
		SCLK_tb <='1';
		wait for MCLK_PERIOD;
		
		SCLK_tb <= '0';
		wait for MCLK_PERIOD;
		SCLK_tb <='1';
		wait for MCLK_PERIOD;
		
		SCLK_tb <= '0';
		wait for MCLK_PERIOD;
		SCLK_tb <='1';
		wait for MCLK_PERIOD;
		
		SCLK_tb <= '0';
		wait for MCLK_PERIOD;
		SCLK_tb <='1';
		wait for MCLK_PERIOD;
		
		SCLK_tb <= '0';
		wait for MCLK_PERIOD;
		SCLK_tb <='1';
		wait for MCLK_PERIOD;		
		
		SDX_tb <= '0'; --parity bit
		
		SCLK_tb <= '0';
		wait for MCLK_PERIOD;
		SCLK_tb <='1';
		wait for MCLK_PERIOD;
		
		--11 bits la

		nSS_tb <= '1';
		
		SCLK_tb <= '0';
		wait for MCLK_PERIOD;
		SCLK_tb <='1';		
		wait for MCLK_PERIOD;
		
		SCLK_tb <= '0';
		wait for MCLK_PERIOD;
		SCLK_tb <='1';		
		wait for MCLK_PERIOD;
		
		SCLK_tb <= '0';
		wait for MCLK_PERIOD;
		SCLK_tb <='1';		
		wait for MCLK_PERIOD;
		
		SCLK_tb <= '0';
		wait for MCLK_PERIOD;
		SCLK_tb <='1';		
		wait for MCLK_PERIOD;
		
		Fsh_tb <= '1';
		
		SCLK_tb <= '0';
		wait for MCLK_PERIOD;
		SCLK_tb <='1';		
		wait for MCLK_PERIOD;
		
		wait;
		
end process;

end behavioral;