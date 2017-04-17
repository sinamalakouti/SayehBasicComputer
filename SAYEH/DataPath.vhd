library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity DP is
  port (
    clk : in std_logic;
    Cin,Zin,Cset,Creset,Zset,Zreset,SRload : in std_logic;
    funcSelect : in std_logic_vector(3 downto 0);
    AluOut_on_Databus : in std_logic;
    IRload : in std_logic;
    WPadd,WPreset : in std_logic;
    RFLwrite,RFHwrite : in std_logic;
    EnablePC : in std_logic;
    ResetPC, PCplusI, PCplus1, RplusI, Rplus0 : in std_logic;
    Rs_on_AddressUnitRSide, Rd_on_AddressUnitRSide : in std_logic;
    inputFromMemory : in std_logic_vector(15 downto 0);
    ouputToMemory : out std_logic_vector(15 downto 0);
    Zout : out std_logic;
    Cout : out std_logic;
    addressUnitOutputToMemory : out std_logic_vector(15 downto 0);
    IR_output_to_controller : out std_logic_vector(15 downto 0)
  );
end entity;
  component

architecture arch of DP is

  component AddressUnit is
    port (
      Rside : IN std_logic_vector (15 DOWNTO 0);
      Iside : IN std_logic_vector (7 DOWNTO 0);
      Address : OUT std_logic_vector (15 DOWNTO 0);
      clk, ResetPC, PCplusI, PCplus1 : IN std_logic;
      RplusI, Rplus0, EnablePC : IN std_logic
    );
    end component;

    component IR is
      port (
        clk : in std_logic;
        IRload : in std_logic;
        input : in std_logic_vector(15 downto 0);
        output : out std_logic_vector(15 downto 0)
      );
    end component;

    component WP is
      port (
        input : in std_logic_vector(5 downto 0);
        clk : in std_logic;
        WPadd,WPreset : in std_logic;
        output : out std_logic_vector(5 downto 0)
      );
    end component;

    component regFile is
      port(
      port(
        input : in std_logic_vector(15 downto 0);
        wp : in std_logic_vector(5 downto 0);
        selectR : in std_logic_vector(3 downto 0);
        clk: in std_logic;
        RFLwrite,RFHwrite : in std_logic;
        Rs : out std_logic_vector(15 downto 0);
        Rd : out std_logic_vector(15 downto 0)
      );
    end component;

    component FlagsReg is
      port (
        clk : in std_logic;
        Cin,Zin,Cset,Creset,Zset,Zreset,SRload : in std_logic;
        Cout,Zout : out std_logic
      );
    end component;

    port (
    A : in std_logic_vector(15 downto 0);
    B : in std_logic_vector(15 downto 0);
    --  B -> Rs   and A -> RD
    funcSelect : in std_logic_vector(3 downto 0);
    -- funcSelect is considered with optional parts  TODO : handle optionals later
    Cin  : in std_logic;
    Zin  : in std_logic;
    Cout  : out std_logic;
    Zout  : out std_logic;
    --  z  is Zeroflag
    output : out std_logic_vector(15 downto 0)
    );
    end component;

begin

end architecture;
