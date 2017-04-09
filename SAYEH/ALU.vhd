library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity ArithmeticUnit is
  port (
  CLK :  in std_logic;
  A : in std_logic_vector(15 downto 0);
  B : in std_logic_vector(15 downto 0);
  --  B -> Rs   and A -> RD
  funcSelect : in std_logic_vector(3 downto 0);
  -- funcSelect is considered with optional parts  TODO : handle optionals later
  Cin  : in std_logic;
  Zin  : in std_logic;
  Cout  : in std_logic;
  Zout  : in std_logic
  --  z  is Zeroflag

  AluOut_on_Databus : out std_logic_vector(15 downto 0)

  );
end entity;

architecture RTL of ArithmeticUnit is
  --  select number is 0
  component ADDITION is   port(
      Rs : in std_logic_vector (15 downto 0);
      Rd : in std_logic_vector (15 downto 0);
      Carryflag : in std_logic;
      result : out std_logic_vector (15 downto 0);
      Carryout : out std_logic
    );
  end component;
  --  select number is 1
    component AND is port(
      Rs : in std_logic_vector (15 downto 0);
      Rd : in std_logic_vector (15 downto 0);
      result : out std_logic_vector (15 downto 0)
    );
  end component;
  --  select number is 2
  component COMPARISON is   port(
      Rs : in std_logic_vector (15 downto 0);
      Rd : in std_logic_vector (15 downto 0);
      Carryflag : out std_logic;
      Zeroflag : out std_logic
    );
  end component;
  --  select number is 3
  component OR is port(
    Rs : in std_logic_vector (15 downto 0);
    Rd : in std_logic_vector (15 downto 0);
    result : out std_logic_vector (15 downto 0)
  );
  end component;
  --  select number is 4
  component  TwoComplementComponent is
    port(
      Rs : in std_logic_vector (15 downto 0);
      result : out std_logic_vector (15 downto 0)
    );
  end component;
  --  select number is 5
  component ShiftLeftComponent is
  port(
    Rs : in std_logic_vector (15 downto 0);
    result : out std_logic_vector (15 downto 0)
  );
end component;
--  select number is 6
component  ShiftRightComponent is

port(
  Rs : in std_logic_vector (15 downto 0);
  Rd : out std_logic_vector (15 downto 0)
);

end component;
--  select number is 7
component   SubtractionComponent is


  port(
    Rs : in std_logic_vector (15 downto 0);
    Rd : in std_logic_vector (15 downto 0);
    Carryflag : in std_logic;
    result : out std_logic_vector (15 downto 0)
  );
end component;
--  select number is 8
component   XorComponent  is

  port(
    Rs : in std_logic_vector (15 downto 0);
    Rd : in std_logic_vector (15 downto 0);
    result : out std_logic_vector (15 downto 0)
  );

end component;


begin
    process(falling_edge CLK)
  begin
    case( funcSelect ) is

      when "0000" =>
      Add : ADDITION port map (B , A , Cin , AluOut_on_Databus , Cout );
      when "001" =>
      and : AND port map (B , A , Cin ,   );

      when "010" =>
      compare : COMPARISON port map (B , A , Cout , Zout  );
      when "011" =>
      or : OR port map (B , A ,AluOut_on_Databus  );
      when "100" =>
-- TODO  : StantiateTwoComplementComponent
      when "101" =>
-- TODO  : Stantiate
      when "111" =>
-- TODO  : Stantiate
      when others =>

    end case;


  end process;

end architecture;
