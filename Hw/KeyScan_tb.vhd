library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity KeyScan_tb is 
end KeyScan_tb;

architecture behavioral of KeyScan_tb is 

component keyScan 
     Port (Kscan : in STD_LOGIC;
              MCLK : in std_logic;
				RESET : in STD_LOGIC;
			  K  : out STD_LOGIC_VECTOR (3 downto 0);
				Kpress : out  std_logic;
              Kentry : in STD_LOGIC_VECTOR (3 downto 0);
              notDecOut : out STD_LOGIC_VECTOR (2 downto 0)
				  );
end component;

--UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD/2;

signal Kentry_tb, K_tb : std_logic_vector(3 downto 0);
signal Kscan_tb, CLK_tb,Kpress_tb,RESET_tb : std_logic;
signal notDecOut_tb : std_logic_vector(2 downto 0);

begin

--UUT
UUT : KeyScan port map(
Kscan=>Kscan_tb,
MCLK=>CLK_tb,
Kentry=>Kentry_tb,
RESET=>RESET_tb,
Kpress=>Kpress_tb,
notDecOut=>notDecOut_tb,
K => K_tb
);


clk_gen : process
begin 
		CLK_tb <= '0';
		wait for MCLK_HALF_PERIOD;
		CLK_tb <= '1';
		wait for MCLK_HALF_PERIOD;
end process;

stimulus: process
begin 
--verificar que o countador varre o teclado
RESET_tb<='1';
Kscan_tb<='1';
Kentry_tb<="0001";
wait for MCLK_PERIOD * 1;
RESET_tb<='0';
Kscan_tb<='1';
wait for MCLK_PERIOD * 1;
Kscan_tb<='1';
wait for MCLK_PERIOD * 1;
Kscan_tb<='1';
wait for MCLK_PERIOD * 1;
Kscan_tb<='1';
wait for MCLK_PERIOD * 1;
Kscan_tb<='1';
wait for MCLK_PERIOD * 1;
Kscan_tb<='1';
wait for MCLK_PERIOD * 1;
Kscan_tb<='1';
wait for MCLK_PERIOD * 1;
Kscan_tb<='1';
wait for MCLK_PERIOD * 1;
Kscan_tb<='1';
wait for MCLK_PERIOD * 1;
Kscan_tb<='1';
wait for MCLK_PERIOD * 1;
Kscan_tb<='1';
wait for MCLK_PERIOD * 1;
Kscan_tb<='1';
wait for MCLK_PERIOD * 1;
Kscan_tb<='1';
wait for MCLK_PERIOD * 1;
Kscan_tb<='1';
wait for MCLK_PERIOD * 1;
Kscan_tb<='1';
wait for MCLK_PERIOD * 1;

wait;

end process;

end architecture;