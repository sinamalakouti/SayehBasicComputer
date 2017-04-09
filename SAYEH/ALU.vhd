library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity ArithmeticUnit is
  port (
  CLK :  in std_logic;
  A : in signed(15 downto 0);
  B : in signed(15 downto 0);
  --  B -> Rs   and A -> RD
  funcSelect : in std_logic_vector(3 downto 0);
  -- funcSelect is considered with optional parts  TODO : handle optionals later
  Cin  : in std_logic;
  Zin  : in std_logic;
  Cout  : in std_logic;
  Zout  : in std_logic
  --  z  is Zeroflag

  AluOut_on_Databus : out signed(15 downto 0)

  );
end entity;

architecture RTL of ArithmeticUnit is
  --  select number is 0
  component ADDITION is   port(
      Rs : in signed (15 downto 0);
      Rd : in signed (15 downto 0);
      Carryflag : in std_logic;
      result : out signed (15 downto 0);
      Carryout : out std_logic
    );
  end component;
  --  select number is 1
    component AND is port(
      Rs : in signed (15 downto 0);
      Rd : in signed (15 downto 0);
      result : out signed (15 downto 0)
    );
  end component;
  --  select number is 2
  component COMPARISON is   port(
      Rs : in signed (15 downto 0);
      Rd : in signed (15 downto 0);
      Carryflag : out std_logic;
      Zeroflag : out std_logic
    );
  end component;
  --  select number is 3
  component OR is port(
    Rs : in signed (15 downto 0);
    Rd : in signed (15 downto 0);
    result : out signed (15 downto 0)
  );
  end component;
  --  select number is 4
  component  TwoComplementComponent is
    port(
      Rs : in signed (15 downto 0);
      result : out signed (15 downto 0)
    );
  end component;
  --  select number is 5
  component ShiftLeftComponent is
  port(
    Rs : in signed (15 downto 0);
    result : out signed (15 downto 0)
  );
end component;
--  select number is 6
component  ShiftRightComponent is

port(
  Rs : in signed (15 downto 0);
  result : out signed (15 downto 0)
);

end component;
--  select number is 7
component   SubtractionComponent is
  port(
    Rs : in signed (15 downto 0);
    Rd : in signed (15 downto 0);
    Carryflag : in signed;
    result : out signed (15 downto 0)
  );
end component;
--  select number is 8
component   XorComponent  is

  port(
    Rs : in signed (15 downto 0);
    Rd : in signed (15 downto 0);
    result : out signed (15 downto 0)
  );

end component;


begin
    process(falling_edge CLK)
  begin
    case( funcSelect ) is

      when "0000" =>
        Add : ADDITION port map (B , A , Cin , AluOut_on_Databus , Cout );
      when "0001" =>
        andC : AND port map (B , A , Cin , AluOut_on_Databus  );
      when "0010" =>
        compare : COMPARISON port map (B , A , Cout , Zout  );
        AluOut_on_Databus = "0000000000000000";
      when "0011" =>
        orC : OR port map (B , A ,AluOut_on_Databus  );
      when "0100" =>
        twosComplement : TwoComplementComponent port map ( B , AluOut_on_Databus);
      when "0101" =>
        shiftLeft : ShiftLeftComponent port map ( B , AluOut_on_Databus);
      when "0110" =>
        shiftRight : ShiftRightComponent port map ( B  ,AluOut_on_Databus);
      when "0111" =>
        subtraction : SubtractionComponent port map ( B , A , Cin, AluOut_on_Databus);
      when "1000" =>
          xorC : XorComponent ( B , A, AluOut_on_Databus);
      when others =>
        NULL;
    end case;
if (AluOut_on_Databus =  "0000000000000000"  & funcSelect /=  "0010")
  then

  Zout = '1';
else  Zout= '0';

end if;


  end process;

end architecture;
