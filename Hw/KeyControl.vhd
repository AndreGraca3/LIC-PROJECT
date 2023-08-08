library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity KeyControl is
		Port (
			RESET : in STD_LOGIC;
			MCLK : in STD_LOGIC;
			Kack : in STD_LOGIC;
			Kpress : in STD_LOGIC;
			Kval : out STD_LOGIC;
			Kscan : out STD_LOGIC
		);
end KeyControl;

architecture Behavioral of KeyControl is
		
		type  STATE_TYPE is (
				ESTADO_INIT,
				ESTADO_KVAL,
				ESTADO_WAIT_NOTKPRESS
		);
		
		signal CurrentState, NextState : STATE_TYPE;
		
begin

		CurrentState <= ESTADO_INIT when RESET = '1' else NextState when rising_edge(MCLK);
		

		GenerateNextState: process(CurrentState, Kpress, Kack)
		begin
			
			case CurrentState is
			when ESTADO_INIT				=> if(Kpress = '1') then
														NextState <= ESTADO_KVAL;
													else
														NextState <= ESTADO_INIT;
													end if;
													
			when ESTADO_KVAL				=> if(Kack = '1') then
														NextState <= ESTADO_WAIT_NOTKPRESS;
													else
														NextState <= ESTADO_KVAL;
													end if;
													
			when ESTADO_WAIT_NOTKPRESS	=> if(Kpress = '0') then
														NextState <= ESTADO_INIT;
													else
														NextState <= ESTADO_WAIT_NOTKPRESS;
													end if;									
			
			end case;										
			end process;
		
		Kval <= '1' when (CurrentState = ESTADO_KVAL) else '0';
		Kscan <= '1' when (CurrentState = ESTADO_INIT and Kpress = '0') else '0';

end Behavioral;