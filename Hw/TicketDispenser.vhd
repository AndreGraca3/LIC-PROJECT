library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TicketDispenser is
	Port ( 
		FnINT	: in STD_LOGIC;
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
	
end TicketDispenser;

architecture Structural of TicketDispenser is

component decoderHex is
		Port(A: in std_logic_vector(3 downto 0);		
		clear : in std_logic;
		HEX0 : out std_logic_vector(7 downto 0)
		);
end component;

signal RT_vector : std_logic_vector(3 downTo 0);
signal nPRT : std_logic;

begin

RT_vector(0) <= RT;
RT_vector(1) <= '0';
RT_vector(2) <= '0';
RT_vector(3) <= '0';
Print <= Prt;
nPrt <= not Prt;
Fn <= FnINT;

U0:	decoderHex
		port map(A => RT_vector, clear => nPrt, HEX0 => RT_out);

		
U1:	decoderHex
		port map(A => DId, clear => nPrt, HEX0 => DId_out);


U2:	decoderHex
		port map(A => OId, clear => nPrt, HEX0 => OId_out);
		
end Structural;