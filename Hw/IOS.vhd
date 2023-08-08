library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IOS is
	Port ( 
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
	
end IOS;

architecture Structural of IOS is

component Dispatcher is
	Port ( MCLK : in  STD_LOGIC;
		RESET : in STD_LOGIC;
		Dval : in STD_LOGIC;
		Fsh : in STD_LOGIC;
		Din : in STD_LOGIC_VECTOR(9 downTo 0);
		Dout : out STD_LOGIC_VECTOR(8 downTo 0);
		WrT : out STD_LOGIC;
		WrL : out STD_LOGIC;
		Done : out STD_LOGIC
			);
end component;

component SerialReceiver is
	Port (SDX : in STD_LOGIC;
			SCLK : in STD_LOGIC;
			nSS : in STD_LOGIC;
			MCLK : in STD_LOGIC;
			RESET : in STD_LOGIC;
			accept : in STD_LOGIC;
			busy : out STD_LOGIC;
			DXval : out STD_LOGIC;
			Dout : out STD_LOGIC_VECTOR(9 downTo 0)
			);
end component;

signal IOS_D : std_logic_vector(9 downTo 0);
signal IOS_DXval : std_logic;
signal IOS_Done : std_logic;

begin

U0:		Dispatcher
			port map(RESET => RESET, MCLK => MCLK, Dval => IOS_DXval, Fsh => Fsh, Din => IOS_D, Dout => Dout, 
			WrT => WrT, WrL => WrL, Done => IOS_Done);
			
U1:		SerialReceiver
			port map(MCLK => MCLK, RESET => RESET, SDX => SDX, SCLK => SCLK, nSS => nSS, accept => IOS_DONE, 
			busy => busy, DXval => IOS_DXval, Dout => IOS_D);

end Structural;