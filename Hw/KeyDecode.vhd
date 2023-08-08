library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity KeyDecode is
     Port (
	  MCLK : in STD_LOGIC;
	  RESET : in STD_LOGIC;
	  Kack : in STD_LOGIC;
	  Kentry : in STD_LOGIC_VECTOR(3 downTo 0);
	  notDecOut : out STD_LOGIC_VECTOR(2 downTo 0);
	  K : out STD_LOGIC_VECTOR(3 downTo 0);
	  Kval : out STD_LOGIC
		);
end KeyDecode;

Architecture Behavioral of KeyDecode is

	component KeyScan is
        Port (Kscan : in STD_LOGIC;
           MCLK : in std_logic;
			  Kentry : in STD_LOGIC_VECTOR(3 downTo 0);
           Kpress : out  std_logic;
			  notDecOut : out STD_LOGIC_VECTOR(2 downTo 0);
			  K : out STD_LOGIC_VECTOR(3 downTo 0)
				);
        end component;
		  
	component KeyControl is
        Port (RESET : in STD_LOGIC;
			MCLK : in STD_LOGIC;
			Kack : in STD_LOGIC;
			Kpress : in STD_LOGIC;
			Kval : out STD_LOGIC;
			Kscan : out STD_LOGIC
				);
        end component;

signal Kpress_signal : std_logic;
signal Kscan_signal : std_logic;
        
begin

U0:		KeyScan
			port map(Kscan => Kscan_signal, MCLK => MCLK, Kentry => Kentry, Kpress => Kpress_signal, notDecOut => 
			notDecOut, K => K);

U1:		KeyControl
			port map(MCLK => MCLK, RESET => RESET, Kack => Kack, Kpress => Kpress_signal, Kval => Kval, Kscan => 
			Kscan_signal);


end Behavioral;