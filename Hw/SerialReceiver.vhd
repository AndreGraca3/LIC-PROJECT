library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SerialReceiver is
		Port (
			MCLK : in STD_LOGIC;
			RESET : in STD_LOGIC;
			SDX : in STD_LOGIC;
			SCLK : in STD_LOGIC;
			nSS : in STD_LOGIC;
			accept : in STD_LOGIC;
			busy : out STD_LOGIC;
			DXval : out STD_LOGIC;
			Dout : out STD_LOGIC_VECTOR(9 downTo 0)
		);
end SerialReceiver;

architecture Structural of SerialReceiver is

component SerialControl is
	Port ( RESET : in STD_LOGIC;
			MCLK : in  STD_LOGIC;
			nSS : in  STD_LOGIC;
			accept : in  STD_LOGIC;
			pFlag : in  STD_LOGIC;
			dFlag : in  STD_LOGIC;
			RXerror : in  STD_LOGIC;
			busy : out STD_LOGIC;
			wr : out  STD_LOGIC;
			init : out  STD_LOGIC;
			DXval : out  STD_LOGIC);
end component;


component counter_4bit is
	Port ( clk : in STD_LOGIC;
			clr : in STD_LOGIC;
			CE : in STD_LOGIC;
			q : out STD_LOGIC_VECTOR (3 downto 0));
end component;


component shift_register is
	Port ( Sin	: in STD_LOGIC;
		CLK	: in STD_LOGIC;
		enable	: in STD_LOGIC;
		D		: out STD_LOGIC_VECTOR(9 downto 0));
end component;


component ParityCheck is
	Port ( clk : in  STD_LOGIC;
		data : in  STD_LOGIC;
		init : in  STD_LOGIC;
		err : out  STD_LOGIC);
end component;


signal tenFlag : std_logic;
signal elevenFlag : std_logic;
signal serial_wr : std_logic;
signal serial_init : std_logic;
signal serial_err : std_logic;
signal serial_q : std_logic_vector(3 downTo 0);

begin


tenFlag <= serial_q(3) and (not serial_q(2)) and serial_q(1) and (not serial_q(0));
elevenFlag <= serial_q(3) and (not serial_q(2)) and serial_q(1) and serial_q(0);

U0:		SerialControl
			port map(RESET => RESET, MCLK => MCLK, nSS => nSS, accept => accept, pFlag => elevenFlag, 
			dFlag => tenFlag, RXerror => serial_err, 
			wr => serial_wr, init => serial_init, DXval => DXval, busy => busy);


U1:		counter_4bit
			port map(clk => SCLK, clr => serial_init, CE => '1', q => serial_q);
			
			
U2:		ParityCheck
			port map(clk => SCLK, data => SDX, init => serial_init, err => serial_err);			
			
			
U3:		shift_register
			port map(clk => SCLK, enable => serial_wr, Sin => SDX, D => Dout);

			
end Structural;