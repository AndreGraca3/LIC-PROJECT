library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity KeyTransmitter is
	Port (
		MCLK : in STD_LOGIC;
		RESET : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(3 downTo 0);
		DAV : in STD_LOGIC;
		TxCLK : in STD_LOGIC;
		TxD : out STD_LOGIC;
		DAC : out STD_LOGIC
	);
	
end KeyTransmitter;

architecture Structural of KeyTransmitter is

component KeyTransmitterControl is
		Port(
		MCLK : in STD_LOGIC;
		RESET : in STD_LOGIC;
		FlagCount : in STD_LOGIC;
		DAV : in STD_LOGIC;
		TxCLK : in STD_LOGIC;
		TxD : out STD_LOGIC;
		DAC : out STD_LOGIC;
		Sel : out STD_LOGIC;
		CE : out STD_LOGIC;
		E : out STD_LOGIC;
		ResetCount : out STD_LOGIC
		);
end component;

component MUX2X1_SINGLEBIT is
		Port(
		Sel : in STD_LOGIC;
		In0 : in STD_LOGIC;
		In1 : in STD_LOGIC;
		Y : out STD_LOGIC
		);
end component;

component MUX6X1 is
		Port(
		S2 : in STD_LOGIC;
		S1 : in STD_LOGIC;
		S0: in STD_LOGIC;
		In0 : in STD_LOGIC;
		In1 : in STD_LOGIC;
		In2 : in STD_LOGIC;
		In3 : in STD_LOGIC;
		In4 : in STD_LOGIC;
		In5 : in STD_LOGIC;
		Y : out STD_LOGIC
		);
end component;

component counter_4bit is
		Port(
		clk : in STD_LOGIC;
			clr : in STD_LOGIC;		
			CE : in STD_LOGIC;
			q : out STD_LOGIC_VECTOR (3 downto 0)
		);
end component;

component Register_D_R
	Generic ( WIDTH : positive := 1 );
		Port (
			CLK : in STD_LogiC;
			 Enable : in STD_LOGIC;
			 D : in STD_Logic_VECTOR (WIDTH-1 downto 0);
			 Q : out STD_Logic_VECTOR (WIDTH-1 downto 0);
			 RST : in STD_LOGIC
			 );
end component;

signal FlagCount_signal : std_logic;
signal E_signal : std_logic;
signal D_signal : std_logic_vector(3 downTo 0);
signal TxD_signal : std_logic;
signal Sel_signal : std_logic;
signal CE_signal : std_logic;
signal ResetCount_signal : std_logic;
signal Y_signal : std_logic;
signal S_signal : std_logic_vector(2 downTo 0);

begin

FlagCount_signal <= ( S_signal(2) and S_signal(1) and ( not S_signal(0)) );

U0:		Register_D_R
			Generic map (	WIDTH => 4 )
			port map(CLK => MCLK, Enable => E_signal, RST => '0', D => D, Q => D_signal);

U1:		KeyTransmitterControl
			port map(MCLK => MCLK, RESET => RESET, FlagCount => FlagCount_signal, DAV => DAV, TxCLK => TxCLK, 
			TxD => TxD_signal, DAC => DAC, Sel => Sel_signal, CE => CE_signal, E => E_signal, 
			ResetCount => ResetCount_signal);
			
U2:		MUX2X1_SINGLEBIT
			port map(Sel => Sel_signal, In0 => TxD_signal, In1 => Y_signal, Y => TxD);
			
U3:		MUX6X1
			port map(In0 => '1', In1 => D_signal(0), In2 => D_signal(1), In3 => D_signal(2), In4 => D_signal(3), 
			In5 => '0', S2 => S_signal(2), S1 => S_signal(1), S0 => S_signal(0), Y => Y_signal);
			
U4:		counter_4bit
			port map(clk => TxCLK, clr => ResetCount_signal, CE => CE_signal, q(2 downTo 0) => S_signal);


end Structural;