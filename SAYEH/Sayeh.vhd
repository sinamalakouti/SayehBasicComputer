library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

  entity Sayeh is
    port (
    clk : in std_logic;
    MemDataReady : in std_logic;
    ReadMem, WriteMem : out std_logic;
    External_Reset : in std_logic;
    inputFromMemory : in std_logic_vector(15 downto 0) ;
    outputToMemory : out std_logic_vector(15 downto 0) ;
    addressUnitOutputToMemory : out std_logic_vector(15 downto 0)
    ) ;
  end entity;

architecture arch of  Sayeh is

  component Controller is
    port (
      clk, External_Reset,MemDataReady,Zin,Cin : in std_logic;
      IRout : in std_logic_vector(15 downto 0);
      --Adressing Unit
      ResetPC , PCplusI , PCplus1 , R0plusI , R0plus0 , EnablePC : out std_logic;
      -- ALU
      Cset , Creset , Zset, Zreset , SRload : out std_logic;
      funcSelect : out std_logic_vector(3 downto 0);
      --RegisterFile
      RFLWrite , RFHWrite: out std_logic;
      --WP
      WPadd , WPreset : out std_logic;
      --IR
      IRload : out std_logic;
      --TriStates
      Adress_on_DataBus , ALUOut_on_DataBus , Rs_on_AdressUnitRside , Rd_on_AdressUnitRside : out std_logic;

      ReadMem,WriteMem : out std_logic
      );
    end component;

    component DP is
    port (
      clk : in std_logic;

      Cset,Creset,Zset,Zreset,SRload : in std_logic;

      funcSelect : in std_logic_vector(3 downto 0);

      AluOut_on_Databus : in std_logic;

      IRload : in std_logic;

      WPadd,WPreset : in std_logic;

      RFLwrite,RFHwrite : in std_logic;

      EnablePC : in std_logic;

      ResetPC, PCplusI, PCplus1, RplusI, Rplus0 : in std_logic;

      Rs_on_AddressUnitRSide, Rd_on_AddressUnitRSide : in std_logic;

      Address_on_DataBus : in std_logic;
      inputFromMemory : in std_logic_vector(15 downto 0);
      ReadMem , WriteMem : in std_logic;

      outputToMemory : out std_logic_vector(15 downto 0);

      Cout : out std_logic;
      Zout : out std_logic;

      addressUnitOutputToMemory : out std_logic_vector(15 downto 0);
      IR_output_to_controller : out std_logic_vector(15 downto 0)
    );
  end component;

  signal datapathCout,datapathZout : std_logic;
  signal datapathIR_output_to_controller : std_logic_vector(15 downto 0);
  signal datapathaddressUnitOutputToMemory : std_logic_vector(15 downto 0);
  signal datapathOutputToMemory : std_logic_vector(15 downto 0);
  signal ConResetPC , ConPCplusI , ConPCplus1 , ConR0plusI , ConR0plus0 , ConEnablePC : std_logic;
  signal ConCset , ConCreset , ConZset, ConZreset , ConSRload : std_logic;
  signal ConRFLWrite , ConRFHWrite: std_logic;
  signal ConWPadd , ConWPreset : std_logic;
  signal ConIRload : std_logic;
  signal ConAdress_on_DataBus , ConALU_on_DataBus , ConRs_on_AdressUnitRside , ConRd_on_AdressUnitRside : std_logic;
  signal ConReadMem,ConWriteMem : std_logic;
  signal ConfuncSelect : std_logic_vector(3 downto 0);

begin

  con : Controller port map(clk,External_Reset,MemDataReady,datapathCout,datapathZout,datapathIR_output_to_controller,ConResetPC , ConPCplusI , ConPCplus1 , ConR0plusI , ConR0plus0 , ConEnablePC,
  ConCset , ConCreset , ConZset, ConZreset , ConSRload, ConfuncSelect,ConRFLWrite , ConRFHWrite,ConWPadd , ConWPreset,ConIRload,ConAdress_on_DataBus , ConALU_on_DataBus ,
  ConRs_on_AdressUnitRside , ConRd_on_AdressUnitRside , ConReadMem,ConWriteMem);

  datapath : DP port map (clk,ConCset , ConCreset , ConZset, ConZreset , ConSRload,ConfuncSelect,ConALU_on_DataBus,ConIRload,ConWPadd , ConWPreset,
  ConRFLWrite , ConRFHWrite,ConEnablePC,ConResetPC , ConPCplusI , ConPCplus1 , ConR0plusI , ConR0plus0,ConRs_on_AdressUnitRside , ConRd_on_AdressUnitRside,
  ConAdress_on_DataBus,inputFromMemory,ConReadMem,ConWriteMem,datapathOutputToMemory,datapathCout,datapathZout,datapathaddressUnitOutputToMemory,datapathIR_output_to_controller);

  addressUnitOutputToMemory <= datapathaddressUnitOutputToMemory;
  outputToMemory <= datapathOutputToMemory;
  ReadMem <= ConReadMem;
  WriteMem <= ConWriteMem;

end architecture;
