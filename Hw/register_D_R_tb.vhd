library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_D_R_tb is
end register_D_R_tb;


architecture behavioral of register_D_R_tb is

component register_D_R is
		Generic ( WIDTH : positive := 1 );
		Port(	CLK : in STD_LOGIC;
				Enable : in STD_LOGIC;
				RST : in STD_LOGIC;
				D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);          
				Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0));
	end component;
	
--UUT SIGNALS
constant MCLK_PERIOD	: time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD/2;

signal CLK_tb : std_logic;
signal RST_tb : std_logic;
signal D_tb : std_logic_vector(8 downto 0);
signal Q_tb : std_logic_vector(8 downTo 0);
signal Enable_tb : std_logic;

begin

--Unit Under Test
UUT: register_D_R
		Generic map (	WIDTH => 9 )
		port map(RST => RST_tb,
					Enable => Enable_tb,
					CLK => CLK_tb,
					Q => Q_tb,
					D => D_tb);

stimulus: process
begin
	--reset
	RST_tb <= '0';
	CLK_tb <= '0';
	Enable_tb <= '0';
	D_tb <= "100101100";
	wait for MCLK_PERIOD;
	CLK_tb <= '1';
	wait for MCLK_PERIOD;
	Enable_tb <= '1';
	wait for MCLK_PERIOD;
	D_tb <= "000000010";
	wait for MCLK_PERIOD;
	D_tb <= "010110010";
	wait for MCLK_PERIOD;
	CLK_tb <= '0';
	wait for MCLK_PERIOD;
	CLK_tb <= '1';
	wait for MCLK_PERIOD;
	wait;
end process;

end behavioral;