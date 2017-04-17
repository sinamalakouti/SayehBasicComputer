library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity AddressUnit is
  port (
    Rside : IN std_logic_vector (15 DOWNTO 0);
    Iside : IN std_logic_vector (7 DOWNTO 0);
    Address : OUT std_logic_vector (15 DOWNTO 0);
    clk, ResetPC, PCplusI, PCplus1 : IN std_logic;
    RplusI, Rplus0, EnablePC : IN std_logic
  );
end entity;

architecture arch of AddressUnit is
  
  component PC is
  port (
    EnablePC : in std_logic;
    input : in std_logic_vector(15 downto 0);
    clk : in std_logic;
    output : out std_logic_vector(15 downto 0)
  );
  end component;

  component AddressLogic is
    port (
      PCside , Rside : in std_logic_vector(15 downto 0);
      Iside : in std_logic_vector(7 downto 0);
      ALout : out std_logic_vector(15 downto 0);
      ResetPC, PCplusI, PCplus1, RplusI, Rplus0 : IN std_logic
    );
  end component;

  SIGNAL pcout : std_logic_vector (15 DOWNTO 0);
  SIGNAL AddressSignal : std_logic_vector (15 DOWNTO 0);

  begin
  Address <= AddressSignal;
  l1 : PC PORT MAP (EnablePC, AddressSignal, clk, pcout);
  l2 : AddressLogic PORT MAP (pcout, Rside, Iside, AddressSignal,ResetPC, PCplusI, PCplus1, RplusI, Rplus0);
end architecture;
