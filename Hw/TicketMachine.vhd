library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TicketMachine is
	Port (
		MCLK : in STD_LOGIC;
		RESET : in STD_LOGIC;
		Fn : in STD_LOGIC;
		Coin : in STD_LOGIC;
		Cid : in STD_LOGIC_VECTOR(2 downTo 0);
		accept , collect , eject : out STD_LOGIC;
		M : in STD_LOGIC;
		HEX0 : out STD_LOGIC_VECTOR(7 downTo 0);
		HEX1 : out STD_LOGIC_VECTOR(7 downTo 0);
		HEX2 : out STD_LOGIC_VECTOR(7 downTo 0);
		Print : out STD_LOGIC;
		Dout: out STD_LOGIC_VECTOR(7 downTo 0); --lcd
		RS: out STD_LOGIC; --lcd
		Enable : out STD_LOGIC;	--lcd
		WrT : out STD_LOGIC;
		WrL :out STD_LOGIC;
		Kentry : in STD_LOGIC_VECTOR(3 downTo 0);
		notDecOut : out STD_LOGIC_VECTOR(2 downTo 0)
	);
	
end TicketMachine;

architecture Structural of TicketMachine is

component UsbPort is
		Port(
		inputPort:  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		outputPort :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
end component;


component IOS is
		Port(
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

component TicketDispenser is
		Port(
		FnINT : in STD_LOGIC;
		Prt : in STD_LOGIC;
		RT : in STD_LOGIC;
		DId : in STD_LOGIC_VECTOR(3 downTo 0);
		OId : in STD_LOGIC_VECTOR(3 downTo 0);
		RT_out : out STD_LOGIC_VECTOR(7 downTo 0);
		DId_out : out STD_LOGIC_VECTOR(7 downTo 0);
		OId_out : out STD_LOGIC_VECTOR(7 downTo 0);
		Fn : out STD_LOGIC;
		Print : out STD_LOGIC
		);
end component;

component KeyboardReader is
	Port(
		Kentry : in STD_LOGIC_VECTOR(3 downTo 0);
		notDecOut : out STD_LOGIC_VECTOR(2 downTo 0);
		TxCLK : in STD_LOGIC;
		MCLK : in STD_LOGIC;
		RESET : in STD_LOGIC;
		TxD : out STD_LOGIC
		);
end component;

signal busy_TM : std_logic;
signal WrT_TM : std_logic;
signal Dout_TM : std_logic_vector(8 downTo 0);
signal SCLK_TM : std_logic;
signal SDX_TM : std_logic;
signal nSS_TM : std_logic;
signal WrL_TM : std_logic;
signal TxCLK_signal : std_logic;
signal TxD_signal : std_logic;

begin

Dout <= Dout_TM(8 downTo 1); --lcd
RS <= Dout_TM(0); --lcd
Enable <= WrL_TM;
WrT <= WrT_TM;
WrL <= WrL_TM;

U0:		IOS
			port map(MCLK => MCLK, RESET => RESET, SCLK => SCLK_TM, SDX => SDX_TM, nSS => nSS_TM, Fsh => not Fn, 
			WrT=> WrT_TM, WrL => WrL_TM, busy => busy_TM, Dout => Dout_TM);
			
U1:		TicketDispenser
			port map(FnINT => Fn, Prt => WrT_TM, RT => Dout_TM(0), Did(3) => Dout_TM(4), Did(2) => Dout_TM(3), 
			Did(1) => Dout_TM(2), DId(0) => Dout_TM(1), OId(3) => Dout_TM(8), OId(2) => Dout_TM(7), 
			OId(1) => Dout_TM(6), OId(0) => Dout_TM(5), RT_out => HEX0, DId_out => HEX1, 
			OId_out => HEX2, Print => Print);
			
U2:		UsbPort
			port map(inputPort(0) => busy_TM, inputPort(1) => Coin, inputPort(2) => Cid(0), inputPort(3) => Cid(1), 
			inputPort(4) => Cid(2), inputPort(5) => TxD_signal, inputPort(6) => M, outputPort(0) => SCLK_TM, 
			outputPort(1) => SDX_TM, outputPort(2) => nSS_TM, outputPort(3) => accept, outputPort(4) => collect, 
			outputPort(5) => eject, outputPort(6) => TxCLK_signal);
			
			
U3:		KeyboardReader
			port map(Kentry => Kentry, notDecOut => notDecOut, TxCLK => TxCLK_signal, TxD => TxD_signal, 
			MCLK => MCLK, RESET => RESET);

end Structural;