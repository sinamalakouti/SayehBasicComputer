library IEEE;
use IEEE.std_logic_1164.all;

entity Controller is
	port (
		clk, External_Reset,MemDataReady,Zin,Cin : in std_logic;
    IRout : in std_logic_vector(15 downto 0);


--  ouputs starts  here :
    --Adressing Unit
    ResetPC , PCplusI , PCplus1 , R0plusI , R0plus0 , EnablePC : out std_logic;
  	-- flags inputs
    Cset , Creset , Zset, Zreset , SRload : out std_logic;

		-- ALU inputs
    funcSelect : out std_logic_vector(3 downto 0);
    --RegisterFile inputs
    RFLWrite , RFHWrite: out std_logic;
    --WP inputs
    WPadd , WPreset : out std_logic;
    --IR inputs
    IRload : out std_logic;
    --TriStates  inputs
    Adress_on_DataBus , ALU_on_DataBus , Rs_on_AdressUnitRside , Rd_on_AdressUnitRside : out std_logic;
		--  memory inputs
    ReadMem: out std_logic;
    WriteMem: out std_logic
    );
end entity;

architecture rtl of controller is
	--  s0 --> fetch ,  s2..29 --> ir instruction decode

	type state is (S0, S1, S2, S3, S4, S5, S6, S7 , S8 , S9 , S10 , S11, S12 ,
	S13, S14 ,S15, S16, S17, S18, S19, S20, S21, S22 , S23 , S24 , S25,  S26, S27 , S28, S29 );

	signal current_state : state := S0 ;
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
			--  fetch from memory
			when S0 =>
			ReadMem = '1';
			WriteMem = '0';
				next_state <= S1;
				--  decode
			when S1 =>
				case( IRout(15 downto 12) ) is

					when "0000"=>
							--  todo case
					when "0001" =>
					--  move register instruction
						funcSelect <= "1010";
						ReadMem <='0';
						WriteMem <='0';
						AluOut_on_Databus <= '1';
						RFLWrite <= '1';
						RFHWrite <= '1';
					when "0010" =>

					when "0011" =>
					when "0100" =>
					when "0101" =>
					when "0110" =>
					when "0111" =>
					when "1000" =>
					when "1001" =>
					when "1010" =>
					when "1011" =>
					when "1100" =>
					when "1101" =>
					when "1110" =>
					when "1111" =>
					when others =>

				end case;

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
