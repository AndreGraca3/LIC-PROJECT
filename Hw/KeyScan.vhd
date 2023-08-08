library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity KeyScan is
     Port (Kscan : in STD_LOGIC;
           MCLK : in std_logic;
			  RESET : in STD_LOGIC;
			  Kentry : in STD_LOGIC_VECTOR(3 downTo 0);
           Kpress : out  std_logic;
			  notDecOut : out STD_LOGIC_VECTOR(2 downTo 0);
			  K : out STD_LOGIC_VECTOR(3 downTo 0)
			  );
end KeyScan;

Architecture Behavioral of KeyScan is

        Component counter_4bit is
        Port (clk : in STD_LOGIC;
			clr : in STD_LOGIC;		
			CE : in STD_LOGIC;
			q : out STD_LOGIC_VECTOR (3 downto 0)
				);
        end component;

        Component Decoder is
        Port (S : in std_logic_vector( 1 downto 0);
			notDEC : out std_logic_vector(2 downto 0)
				);
        end component;

        Component MUX4X1 is
        Port (S1 : in STD_LOGIC;
			S0 : in STD_LOGIC;
			In0 : in STD_LOGIC;
			In1 : in STD_LOGIC;
			In2 : in STD_LOGIC;
			In3 : in STD_LOGIC;
			Y : out STD_LOGIC
				  );
        end component;
		  
		  
		  Component CLKDIV is 
		  generic(div: natural := 250000);
			port ( clk_in: in std_logic;
			clk_out: out std_logic);
			end component;
			

signal Qsel : std_logic_vector(3 downto 0);
signal decOut : std_logic_vector(2 downTo 0);
signal MuxOut : std_logic;
signal CLK_DIV_signal : STD_LOGIC;

begin

Kpress <= not MuxOut;
K <= Qsel;

U0: counter_4bit
	port map (CE => Kscan, q => Qsel, CLK => CLK_DIV_signal, clr => RESET);

U1: Decoder 
	port map (S(1) => Qsel(3), S(0) => Qsel(2), notDEC => notDecOut);

U2: MUX4X1
	port map (S1 => Qsel(1), S0 => Qsel(0), In0 => Kentry(0), In1 => Kentry(1), In2 => Kentry(2), 
	In3 => Kentry(3), Y => MuxOut);
	
U3: CLKDIV 
	port map(clk_in=>MCLK, clk_out=> CLK_DIV_signal);

end Behavioral;