library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity ArithmeticUnit is
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
end entity;

architecture RTL of ArithmeticUnit is
  --  select number is 0
  component AdditionComponent is
      port(
    Rs : in std_logic_vector (15 downto 0);
    Rd : in std_logic_vector (15 downto 0);
    Carryflag : in std_logic;
    result : out std_logic_vector (15 downto 0);
    Cout : out std_logic;
    Zout : out std_logic
  );
end component;

  --  select number is 1
    component AndComponent is
    port(
      Rs : in std_logic_vector (15 downto 0);
      Rd : in std_logic_vector (15 downto 0);
      result : out std_logic_vector (15 downto 0);
      Cout : out std_logic;
      Zout : out std_logic
    );
  end component;
  --  select number is 2
  component ComparisonComponent is
  port(
      Rs : in std_logic_vector (15 downto 0);
      Rd : in std_logic_vector (15 downto 0);
      Cout : out std_logic;
      Zout : out std_logic
    );
  end component;
  --  select number is 3
  component OrComponent is
  port(
    Rs : in std_logic_vector (15 downto 0);
    Rd : in std_logic_vector (15 downto 0);
    result : out std_logic_vector (15 downto 0);
    Cout : out std_logic;
    Zout : out std_logic
  );
  end component;
  --  select number is 4
  component  TwoComplementComponent is
    port(
      Rs : in std_logic_vector (15 downto 0);
      result : out std_logic_vector (15 downto 0);
      Cout : out std_logic;
      Zout : out std_logic
    );
  end component;
  --  select number is 5
  component ShiftLeftComponent is
  port(
    Rs : in std_logic_vector (15 downto 0);
    result : out std_logic_vector (15 downto 0);
    Cout : out std_logic;
    Zout : out std_logic
  );
end component;
--  select number is 6
component ShiftRightComponent is
  port(
    Rs : in std_logic_vector (15 downto 0);
    result : out std_logic_vector (15 downto 0);
    Cout : out std_logic;
    Zout : out std_logic
  );
end component;
--  select number is 7
component SubtractionComponent is
  port(
    Rs : in std_logic_vector (15 downto 0);
    Rd : in std_logic_vector (15 downto 0);
    Carryflag : in std_logic;
    result : out std_logic_vector (15 downto 0);
    Cout : out std_logic;
    Zout : out std_logic
  );
end component;
--  select number is 8
component XorComponent  is
  port(
    Rs : in std_logic_vector (15 downto 0);
    Rd : in std_logic_vector (15 downto 0);
    result : out std_logic_vector (15 downto 0);
    Cout : out std_logic;
    Zout : out std_logic
    );
end component;

--  select number is 9
component MultiplierComponent is
port(
    Rs : in std_logic_vector(7 downto 0);
    Rd: in std_logic_vector(7 downto 0);
    result: out std_logic_vector(15 downto 0);
    Cout : out std_logic;
    Zout : out std_logic
  );
end component;

-- B to output select number is 10

type outputarray is array (0 to 15) of std_logic_vector(15 downto 0);
type carryarray is array (0 to 15) of std_logic;
type zeroarray is array (0 to 15) of std_logic;

signal componentOutput : outputarray;
signal componentCarry : carryarray;
signal componentZero : zeroarray;

begin
  AddC : AdditionComponent port map (B , A , Cin , componentOutput(0) , componentCarry(0), componentZero(0));
  andC : AndComponent port map (B , A , componentOutput(1) , componentCarry(1) , componentZero(1));
  compare : ComparisonComponent port map (B , A , componentCarry(2) , componentZero(2));
  orC : OrComponent port map (B , A ,componentOutput(3),componentCarry(3) , componentZero(3));
  twosComplement : TwoComplementComponent port map ( B ,componentOutput(4), componentCarry(4) , componentZero(4));
  shiftLeft : ShiftLeftComponent port map (B , componentOutput(5), componentCarry(5) , componentZero(5));
  shiftRight : ShiftRightComponent port map (B , componentOutput(6), componentCarry(6) , componentZero(6));
  subtraction : SubtractionComponent port map (B , A , Cin, componentOutput(7),componentCarry(7) , componentZero(7));
  xorC : XorComponent port map(B , A, componentOutput(8),componentCarry(8) , componentZero(8));
  multiply : MultiplierComponent port map (B(7 downto 0) , A(7 downto 0) , componentOutput (9) , componentCarry(9) , componentZero(9));

  with funcSelect select
    output <= componentOutput(0) when "0000",
                         componentOutput(1) when "0001",
                         componentOutput(3) when "0011",
                         componentOutput(4) when "0100",
                         componentOutput(5) when "0101",
                         componentOutput(6) when "0110",
                         componentOutput(7) when "0111",
                         componentOutput(8) when "1000",
                         componentOutput(9) when "1001",
                         B                  when "1010",
                         "0000000000000000" when others;

  with funcSelect select
    Cout <= componentCarry(0) when "0000",
                         componentCarry(1) when "0001",
                         componentCarry(2) when "0010",
                         componentCarry(3) when "0011",
                         componentCarry(4) when "0100",
                         componentCarry(5) when "0101",
                         componentCarry(6) when "0110",
                         componentCarry(7) when "0111",
                         componentCarry(8) when "1000",
                         componentCarry(9) when "1001",
                         '0' when others;
  with funcSelect select
    Zout <= componentZero(0) when "0000",
                         componentZero(1) when "0001",
                         componentZero(2) when "0010",
                         componentZero(3) when "0011",
                         componentZero(4) when "0100",
                         componentZero(5) when "0101",
                         componentZero(6) when "0110",
                         componentZero(7) when "0111",
                         componentZero(8) when "1000",
                         componentZero(9) when "1001",
                         '0' when others;

end architecture;
