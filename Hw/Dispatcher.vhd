library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Dispatcher is
	Port ( 
		RESET : in  STD_LOGIC;
		MCLK : in STD_LOGIC;
		Dval : in STD_LOGIC;
		Fsh : in STD_LOGIC;
		Din : in STD_LOGIC_VECTOR(9 downTo 0);
		Dout : out STD_LOGIC_VECTOR(8 downTo 0);
		WrT : out STD_LOGIC;
		WrL : out STD_LOGIC;
		Done : out STD_LOGIC
	);
	
end Dispatcher;

architecture Structural of Dispatcher is

component DispatcherControl is
	Port ( RESET : in STD_LOGIC;
			Fsh : in STD_LOGIC;
			MCLK : in  STD_LOGIC;
			Dval : in  STD_LOGIC;
			TnL : in  STD_LOGIC;
			WrT : out  STD_LOGIC;
			WrL : out  STD_LOGIC;
			Done : out STD_LOGIC
			);
end component;

begin

Dout(8) <= Din(9);
Dout(7) <= Din(8);
Dout(6) <= Din(7);
Dout(5) <= Din(6);
Dout(4) <= Din(5);
Dout(3) <= Din(4);
Dout(2) <= Din(3);
Dout(1) <= Din(2);
Dout(0) <= Din(1);

U0:		DispatcherControl
			port map(RESET => RESET, MCLK => MCLK, Fsh => Fsh, Dval => Dval, TnL => Din(0), WrT => WrT, WrL=> WrL,
			Done => Done);

end Structural;