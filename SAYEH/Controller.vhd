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
    Adress_on_DataBus , ALUOut_on_DataBus , Rs_on_AdressUnitRside , Rd_on_AdressUnitRside : out std_logic;
		--  memory inputs
    ReadMem: out std_logic;
    WriteMem: out std_logic
    );
end entity;

architecture rtl of controller is
	--  s0 --> fetch ,  s2..29 --> ir instruction decode

	type state is (S_reset, S_firstFetch,S_secondFetch,S_waitBeforeDecode ,S_decode, S_updatePC, S_halt , S_and , S_or , S_not ,
	 S_shiftleft , S_shiftright , S_add , S_subtraction , S_multiply , S_comparison ,S_noOperation, S_setZFlag,
	  S_clearZflag, S_setCarryFlag , S_clearCarryFlag, S_clearWindowPointer, S_moveRegister, S_loadAddress ,S_loadAddress2, S_storeAdress, S_moveImmidiateLow,
		S_moveImmidiateHigh, S_savePC, S_jumpAddress, S_jumpRelative, S_brachIfZero, S_brachIfCarry, S_addWindowPointer);

  signal current_state : state := S_reset;
  signal next_state : state;
begin
	-- next to current
	process (clk,External_Reset)
	begin
		if External_Reset = '1' then
			current_state <= S_reset;
		elsif clk'event and clk = '1' then
			current_state <= next_state;
		end if;
	end process;

	-- next based on state
	process (current_state)
	begin
		ResetPC  <='0';
		PCplusI  <='0';
	 	PCplus1  <='0';
	 	R0plusI  <='0';
	 	R0plus0 <='0';
	 	EnablePC <='0';
	 	Cset  <='0';
		Creset  <='0';
		Zset  <='0';
		Zreset  <='0';
	  SRload  <='0';
		RFLWrite <='0';
		RFHWrite <='0';
		WPadd <='0';
	 	WPreset <='0';
		IRload <='0';
		Adress_on_DataBus <='0';
 		ALUOut_on_DataBus	 <='0';
 		Rs_on_AdressUnitRside <='0';
  	Rd_on_AdressUnitRside <='0';
		ReadMem  <='0';
    WriteMem <='0';

		case current_state is
			--  reset states of the controller
			when S_reset =>
				ResetPC <= '1';
				EnablePC <= '1';
				Creset <= '1';
				Zreset <= '1';
				WPreset <= '1';
				next_state <= S_firstFetch;
			when S_firstFetch =>
			-- fist fetch data
				ReadMem <= '1';
				IRLoad <= '1';
				next_state <= S_secondFetch;
			when S_secondFetch =>
			-- second fetch data
					ReadMem <= '1';
					IRLoad <= '1';
					next_state <= S_waitBeforeDecode;
			when S_waitBeforeDecode =>
				next_state <= S_decode;
			when S_decode =>
	-- Decode IR_output_to_controller
				case(IRout(15 downto 12)) is
					--  where opcode is 0000
					when "0000"=>
					--  we care about next 4 bits
						case(IRout(11 downto 8)) is
							when "0000" =>
							-- NO OPERATION
								next_state <= S_noOperation;
							when "0001" =>
							--  halt no fetch occurs
								next_state <= S_halt;
							when "0010" =>
							--  set zero flag to one and then fetch
								next_state <= S_setZFlag;
							when "0011" =>
							--  set zero flag to zero and then fetch

								next_state <= S_clearZflag;
							when "0100"	=>
							--  set carry  flag to one and then fetch

								next_state <= S_setCarryFlag;
							when "0101"	=>
							--  set carry  flag to zero and then fetch

								next_state <= S_clearCarryFlag;
							when "0110"	=>
							-- set window pointer to zero then fetch from memory

								next_state <= S_clearWindowPointer;
							when "0111"	=>
								-- pc + Is

								next_state <= S_jumpRelative;
							when "1000"	=>
							--  pc + I if only zero flag is equal to 1

								next_state <= S_brachIfZero;
							when "1001"	=>
							--  pc + I if only zero flag is equal to 1
										next_state <= S_brachIfCarry;
							when "1010"=>
							-- WP + I  then fetch from memory

								next_state <= S_addWindowPointer;
							when others =>
								next_state <= S_reset;
						end case; --IRout(11 downto 8)

					when "0001" =>
					-- move register  RD <= RS

						next_state <= S_moveRegister;
					when "0010" =>
					-- load [Rs] to Rd
						next_state <=S_loadAddress;

					when "0011" =>
					-- store Rs to [Rd]

						next_state <= S_storeAdress;

					when "0100" =>
					-- optional
						EnablePC <= '1';
						PCplus1 <= '1';
						next_state <= S_firstFetch;
					when "0101" =>
					-- optional
						EnablePC <= '1';
						PCplus1 <= '1';
						next_state <= S_firstFetch;
					when "0110" =>
					-- and function

						next_state <= S_and;
					when "0111" =>
					-- or function

						next_state <= S_or;
					when "1000" =>
					-- not function

						next_state <= S_not;
					when "1001" =>
					-- shift left function

						next_state <= S_shiftleft;
					when "1010" =>
					-- shift right function

						next_state <= S_shiftright;
					when "1011" =>
					-- add function

						next_state <= S_add;
					when "1100" =>
					-- subtract function
						next_state <= S_subtraction;
					when "1101" =>
					-- multiply function

						next_state <= S_multiply;
					when "1110" =>
					-- comparision function

						next_state <= S_comparison;
					when "1111" =>
					-- we care about IR (9 downto 8)
						case(IRout(9 downto 8)) is

							when "00" =>
							-- move immidate low

								next_state <= S_moveImmidiateLow;
							when "01" =>
							-- move immidate high
								next_state <= S_moveImmidiateHigh;

							when "10" =>
							-- save pc
									next_state <= S_savePC;
							when "11" =>
							-- jump addressed

								next_state <= S_jumpAddress;
							when others =>
								next_state <= S_reset;

						end case; -- IRout(9 downto 8)
					when others =>
						next_state <= S_reset;

				end case; -- IRout(15 downto 12)

			when S_updatePC =>
				EnablePC <= '1';
				PCplus1 <= '1';
				next_state <= S_firstFetch;

			when  S_noOperation =>
			-- no operation
				EnablePC <= '1';
				PCplus1 <= '1';
				next_state <= S_firstFetch;

				when S_halt =>
					next_state <= S_halt;

			when  S_setZFlag =>
			-- setting zero flag to 1 then fetch
				Zset <= '1';
				EnablePC <= '1';
				PCplus1 <= '1';
				next_state <= S_firstFetch;
			when  S_clearZflag =>
			-- seeting zero flag to zero then fetch
				EnablePC <= '1';
				PCplus1 <= '1';
				Zreset <= '1';
				next_state <= S_firstFetch;
			when  S_setCarryFlag =>
				Cset <= '1';
				EnablePC <= '1';
				PCplus1 <= '1';
				next_state <= S_firstFetch;
			when  S_clearCarryFlag =>
				EnablePC <= '1';
				PCplus1 <= '1';
				Creset <= '1';
				next_state <= S_firstFetch;
			when  S_clearWindowPointer =>
				WPreset <= '1';
				EnablePC <= '1';
				PCplus1 <= '1';
				next_state <= S_firstFetch;
			when  S_moveRegister =>
				funcSelect <= "1010";
				ALUOut_on_DataBus <= '1';
				RFLwrite <= '1';
				RFHwrite <= '1';
				EnablePC <= '1';
				PCplus1 <= '1';
				next_state <= S_firstFetch;
			when  S_loadAddress =>
				Rs_on_AdressUnitRside <= '1'; --TO DO
				R0plus0 <= '1';
				next_state <= S_loadAddress2;
			when S_loadAddress2 =>
				ReadMem <= '1';
				RFHwrite <= '1';
				RFLwrite <= '1';
				next_state <= S_updatePC;
			when  S_storeAdress =>
				funcSelect <= "1010";
				ALUOut_on_DataBus <= '1';
				Rd_on_AdressUnitRside <= '1';
				R0plus0 <= '1';
				WriteMem <= '1';
				next_state <= S_updatePC;
			when  S_and =>
				funcSelect <= "0001";
				ALUOut_on_DataBus <= '1';
				RFLwrite <= '1';
				RFHwrite <= '1';
				EnablePC <= '1';
				PCplus1 <= '1';
				next_state <= S_firstFetch;
			when  S_or =>
				funcSelect <= "0011";
				ALUOut_on_DataBus <= '1';
				RFLwrite <= '1';
				RFHwrite <= '1';
				EnablePC <= '1';
				PCplus1 <= '1';
				next_state <= S_firstFetch;
			when  S_not =>
				funcSelect <= "1011";
				ALUOut_on_DataBus <= '1';
				RFLwrite <= '1';
				RFHwrite <= '1';
				EnablePC <= '1';
				PCplus1 <= '1';
				next_state <= S_firstFetch;
			when  S_shiftleft =>
			funcSelect <= "0101";
				ALUOut_on_DataBus <= '1';
				RFLwrite <= '1';
				RFHwrite <= '1';
				EnablePC <= '1';
				PCplus1 <= '1';
				next_state <= S_firstFetch;
			when  S_shiftright =>
				funcSelect <= "0110";
				ALUOut_on_DataBus <= '1';
				RFLwrite <= '1';
				RFHwrite <= '1';
				EnablePC <= '1';
				PCplus1 <= '1';
				next_state <= S_firstFetch;
			when  S_add =>
				funcSelect <= "0000";
				SRload <= '1';
				ALUOut_on_DataBus <= '1';
				RFLwrite <= '1';
				RFHwrite <= '1';
				EnablePC <= '1';
				PCplus1 <= '1';
				next_state <= S_firstFetch;
			when  S_subtraction =>
				funcSelect <= "0111";
				SRload <= '1';
				ALUOut_on_DataBus <= '1';
				RFLwrite <= '1';
				RFHwrite <= '1';
				EnablePC <= '1';
				PCplus1 <= '1';
				next_state <= S_firstFetch;
			when  S_multiply =>
				funcSelect <= "1001";
				SRload <= '1';
				ALUOut_on_DataBus <= '1';
				RFLwrite <= '1';
				RFHwrite <= '1';
				EnablePC <= '1';
				PCplus1 <= '1';
				next_state <= S_firstFetch;
			when  S_comparison =>
				funcSelect <= "0010";
				RFLwrite <= '1';
				RFHwrite <= '1';
				EnablePC <= '1';
				PCplus1 <= '1';
				next_state <= S_firstFetch;
			when  S_moveImmidiateLow =>
				R0plusI <= '1';
				Adress_on_DataBus <= '1';
				RFLwrite <= '1';
				next_state <= S_updatePC;
			when  S_moveImmidiateHigh =>
				R0plusI <= '1';
				Adress_on_DataBus <= '1';
				RFHwrite <= '1';
				next_state <= S_updatePC;
			when  S_savePC =>
				PCplusI <= '1';
				Adress_on_DataBus <= '1';
				RFHwrite <= '1';
				RFLwrite <= '1';
				next_state <= S_updatePC;
			when  S_jumpAddress =>
				Rd_on_AdressUnitRSide <= '1';
				R0plusI <= '1';
				EnablePC <= '1';
				next_state <= S_firstFetch;
			when  S_jumpRelative =>
				EnablePC <= '1';
				PCplusI <='1';
				next_state <= S_firstFetch;
			when  S_brachIfZero =>
				EnablePC <= '1';
				if (Zin = '1' ) then
						PCplusI <= '1';
					else
							PCplus1 <= '1';
				end if;
				next_state <= S_firstFetch;
			when   S_brachIfCarry =>
			EnablePC <= '1';
			if (Cin  = '1' ) then
					PCplusI <= '1';
			else
					PCplus1 <= '1';
			end if;
				next_state <= S_firstFetch;
			when  S_addWindowPointer =>
				WPadd <= '1';
				EnablePC <= '1';
				PCplus1 <= '1';
				next_state <= S_firstFetch;
			when others =>
				next_state <= S_reset;
		end case; --next_state
	end process;
	end architecture;
