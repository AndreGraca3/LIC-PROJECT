library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity KeyboardReader is
		Port (
			Kentry : in STD_LOGIC_VECTOR(3 downTo 0);
			notDecOut : out STD_LOGIC_VECTOR(2 downTo 0);
			TxCLK : in STD_LOGIC;
			MCLK : in STD_LOGIC;
			RESET : in STD_LOGIC;
			TxD : out STD_LOGIC
		);
end KeyboardReader;

architecture Structural of KeyboardReader is

component KeyDecode is
	Port (
		MCLK : in STD_LOGIC;
	  RESET : in STD_LOGIC;
	  Kack : in STD_LOGIC;
	  Kentry : in STD_LOGIC_VECTOR(3 downTo 0);
	  notDecOut : out STD_LOGIC_VECTOR(2 downTo 0);
	  K : out STD_LOGIC_VECTOR(3 downTo 0);
	  Kval : out STD_LOGIC
		);
end component;

component KeyTransmitter is
	Port (
		MCLK : in STD_LOGIC;
		RESET : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(3 downTo 0);
		DAV : in STD_LOGIC;
		TxCLK : in STD_LOGIC;
		TxD : out STD_LOGIC;
		DAC : out STD_LOGIC
		);
end component;

signal Kack_signal : std_logic;
signal DAV_signal : std_logic;
signal D_signal : std_logic_vector(3 downTo 0);

begin

U0:		KeyTransmitter
			port map(MCLK => MCLK, RESET => RESET, DAV => DAV_signal, D => D_signal, TxCLK => TxCLK, 
			DAC => Kack_signal, TxD => TxD);

U1:		KeyDecode
			port map(MCLK => MCLK, RESET => RESET, Kack => Kack_signal, Kentry => Kentry, notDecOut => notDecOut, 
			Kval => DAV_signal, K => D_signal);		
			
end Structural;