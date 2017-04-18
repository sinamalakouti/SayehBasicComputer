library IEEE;
use IEEE.std_logic_1164.all;

entity Controller is
	port (
		clk, External_Reset,MemDataReady,Zin,Cin : in std_logic;
    IRout : in std_logic_vector(15 downto 0);
    --Adressing Unit
    ResetPC , PCplusI , PCplus1 , R0plusI , R0plus0 , EnablePC : out std_logic;
    -- ALU
    Cset , Creset , Zset, Zreset , SRload : out std_logic;
    B15to0 , AandB , AorB , NotB , AaddB , AsubB , AmulB , AcmpB , ShrB , ShlB : out std_logic;
    --RegisterFile
    RFLWrite , RFHWrite: out std_logic;
    --WP
    WPadd , WPreset : out std_logic;
    --IR
    IRload : out std_logic;
    --TriStates
    Adress_on_DataBus , ALU_on_DataBus , Rs_on_AdressUnitRside , Rd_on_AdressUnitRside : out std_logic;

    ReadMem: out std_logic;
    WriteMem: out std_logic
    );
end entity;

architecture rtl of controller is
	type state is (S0, S1, S2, S3, S4);
	signal current_state : state;
	signal next_state : state;
begin
	-- next to current
	process (clk, External_Reset)
	begin
		if External_Reset = '1' then
			current_state <= S0;
		elsif clk'event and clk = '1' then
			current_state <= next_state;
		end if;
	end process;

	-- next based on state
	process (current_state)
	begin
		case current_state is
			when S0 =>
				next_state <= S1;
			when S1 =>
				next_state <= S2;
			when S2 =>
				next_state <= S3;
			when S3 =>
				next_state <= S4;
			when S4 =>
				next_state <= S0;
		end case;
	end process;
end architecture;
