library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity KeyTransmitterControl is
		Port (
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
end KeyTransmitterControl;

architecture Behavioral of KeyTransmitterControl is
		
		type  STATE_TYPE is (
				ESTADO_INIT,
				ESTADO_STORE,
				ESTADO_STOREEND,
				ESTADO_SEND,
				ESTADO_SENDEND
		);
		
		signal CurrentState, NextState : STATE_TYPE;
		
begin

		CurrentState <= ESTADO_INIT when RESET = '1' else NextState when rising_edge(MCLK);
		

		GenerateNextState: process(CurrentState, DAV, TxCLK, FlagCount)
		begin
			
			case CurrentState is
			when ESTADO_INIT				=> if(DAV = '1') then
														NextState <= ESTADO_STORE;
													else
														NextState <= ESTADO_INIT;
													end if;
													
			when ESTADO_STORE				=> 	NextState <= ESTADO_STOREEND;
									
									
			when ESTADO_STOREEND			=> if(DAV = '0') then
														NextState <= ESTADO_SEND;
													else
														NextState <= ESTADO_STOREEND;
													end if;
													
			when ESTADO_SEND				=> if(TxCLK = '1') then
														NextState <= ESTADO_SENDEND;
													else
														NextState <= ESTADO_SEND;
													end if;										
													
													
			when ESTADO_SENDEND				=> if(FlagCount = '1') then
														NextState <= ESTADO_INIT;
													else
														NextState <= ESTADO_SENDEND;
													end if;								
													
			end case;										
			end process;
		
		TxD <= '1' when (CurrentState = ESTADO_INIT or CurrentState = ESTADO_STORE or CurrentState = ESTADO_STOREEND) else '0';
		ResetCount <= '1' when (CurrentState = ESTADO_INIT) else '0';
		E <= '1' when (CurrentState = ESTADO_STORE) else '0';
		DAC <= '1' when (CurrentState = ESTADO_STOREEND) else '0';
		Sel <= '1' when (CurrentState = ESTADO_SENDEND) else '0';
		CE <= '1' when (CurrentState = ESTADO_SENDEND) else '0';
		
end Behavioral;