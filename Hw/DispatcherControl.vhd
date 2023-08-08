library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DispatcherControl is
		Port (
			RESET : in STD_LOGIC;
			MCLK : in STD_LOGIC;
			Fsh : in STD_LOGIC;
			Dval : in  STD_LOGIC;
			TnL : in  STD_LOGIC;
			WrT : out  STD_LOGIC;
			WrL : out  STD_LOGIC;
			Done : out STD_LOGIC
		);
end DispatcherControl;

architecture Behavioral of DispatcherControl is

	component CLKDIV is
	Generic ( div : natural := 26);
		Port(
		clk_in: in std_logic;
		 clk_out: out std_logic
		);
end component;
		
		type  STATE_TYPE is (
				ESTADO_INIT,
				ESTADO_WrT,
				ESTADO_WrL,
				ESTADO_DONE,
				ESTADO_WAIT_FSH
		);
		
		signal CurrentState, NextState : STATE_TYPE;
		signal MCLK_DIV : std_logic;
		
begin

		CurrentState <= ESTADO_INIT when RESET = '1' else NextState when rising_edge(MCLK_DIV);
		
		
		GenerateNextState: process(CurrentState, Dval, TnL, Fsh)
		begin
			
			case CurrentState is
			when ESTADO_INIT				=> if(Dval = '1' and TnL = '1') then
														NextState <= ESTADO_WrT;
													elsif(Dval = '1' and TnL = '0') then
														NextState <= ESTADO_WrL;
													else
														NextState <= ESTADO_INIT;
													end if;
													
			when ESTADO_WAIT_FSH			=> if(Fsh = '0') then
														NextState <= ESTADO_DONE;
													else
														NextState <= ESTADO_WAIT_FSH;
													end if;
													
			when ESTADO_WrT				=> if(Fsh = '1') then
														NextState <= ESTADO_WAIT_FSH;
													else
														NextState <= ESTADO_WrT;
													end if;
			
			when ESTADO_WrL				=> NextState <= ESTADO_DONE;
													
			when ESTADO_DONE				=> NextState <= ESTADO_INIT;
			
			
			end case;
		end process;
		
	Done <= '1' when (CurrentState = ESTADO_DONE) else '0';
	WrT <= '1' when (CurrentState = ESTADO_WrT) else '0';
	WrL <= '1' when (CurrentState = ESTADO_WrL) else '0';
	
	U0:		CLKDIV
			port map(clk_in => MCLK, clk_out => MCLK_DIV);
		
end Behavioral;