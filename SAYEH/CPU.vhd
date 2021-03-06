library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity CPU is
  port (
    clk,External_Reset : in std_logic
  );
end entity;

architecture arch of CPU is
  component memory is
    generic (blocksize : integer := 1024);
  	port (
  		clk, ReadMem, WriteMem : in std_logic;
  		AddressBus: in std_logic_vector (15 downto 0);
  		DataBus : inout std_logic_vector (15 downto 0);
  		MemDataReady : out std_logic
  		);
  end component;

  component Sayeh is port (
      clk : in std_logic;
      MemDataReady : in std_logic;
      ReadMem, WriteMem : out std_logic;
      External_Reset : in std_logic;
      inputFromMemory : in std_logic_vector(15 downto 0) ;
      outputToMemory : out std_logic_vector(15 downto 0) ;
      addressUnitOutputToMemory : out std_logic_vector(15 downto 0)
      );
    end component;

    signal memReadMem,memWriteMem : std_logic;
    signal sayehAddressUnitOutputToMemory : std_logic_vector(15 downto 0);
    signal sayehMemDataReady : std_logic;
    signal sayehDataBus : std_logic_vector(15 downto 0);
    signal temp : std_logic_vector(15 downto 0);
    signal temp2 : std_logic_vector(15 downto 0);

begin
  mem : Memory port map(clk,memReadMem,memWriteMem,sayehAddressUnitOutputToMemory,sayehDataBus,sayehMemDataReady);
  sa : Sayeh port map(clk,sayehMemDataReady,memReadMem,memWriteMem,External_Reset,sayehDataBus,sayehDataBus,sayehAddressUnitOutputToMemory);
  --  temp <= sayehDataBus;
  -- sayehDataBus <= temp2;
end architecture;
