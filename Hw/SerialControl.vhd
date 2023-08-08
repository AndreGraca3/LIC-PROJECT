library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SerialControl is
		Port (
			RESET : in STD_LOGIC;
			MCLK : in  STD_LOGIC;
			nSS : in  STD_LOGIC;
			accept : in  STD_LOGIC;
			pFlag : in  STD_LOGIC;
			dFlag : in  STD_LOGIC;
			RXerror : in  STD_LOGIC;
			busy : out STD_LOGIC;
			wr : out  STD_LOGIC;
			init : out  STD_LOGIC;
			DXval : out  STD_LOGIC
		);
end SerialControl;

architecture Behavioral of SerialControl is
		
		type  STATE_TYPE is (
				ESTADO_INIT,
				ESTADO_WR,
				ESTADO_READ_D_FLAG,
				ESTADO_BUSY
		);
		
		signal CurrentState, NextState : STATE_TYPE;
		
begin

		CurrentState <= ESTADO_INIT when RESET = '1' else NextState when rising_edge(MCLK);
		

		GenerateNextState: process(CurrentState, nSS, dFlag, pFlag, RXerror, accept)
		begin
			
			case CurrentState is
			when ESTADO_INIT				=> if(nSS = '0') then
														NextState <= ESTADO_WR;
													else
														NextState <= ESTADO_INIT;
													end if;
													
			when ESTADO_WR					=> if(nSS = '1') then
														NextState <= ESTADO_INIT;
													elsif(nSS = '0' and dFlag = '1') then
														NextState <= ESTADO_READ_D_FLAG;
													else
														NextState <= ESTADO_WR;
													end if;
			
			when ESTADO_READ_D_FLAG		=> if(nSS = '0') then
														NextState <= ESTADO_READ_D_FLAG;
													elsif(nSS = '1' and pFlag = '1' and RXerror = '0') then
														NextState <= ESTADO_BUSY;
													elsif(nSS = '1' and pflag = '0') then
														NextState <= ESTADO_READ_D_FLAG;
													else
														NextState <= ESTADO_INIT;
													end if;
				
			when ESTADO_BUSY				=> if(accept = '1') then
														NextState <= ESTADO_INIT;
													else
														NextState <= ESTADO_BUSY;
													end if;
			end case;										
			end process;
		
		init <= '1' when (CurrentState = ESTADO_INIT) else '0';
		wr <= '1' when (CurrentState = ESTADO_WR) else '0';
		DXval <= '1' when (CurrentState = ESTADO_BUSY) else '0';
		busy <= '1' when (CurrentState = ESTADO_BUSY) else '0';

end Behavioral;