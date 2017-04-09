library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity test is
end entity;

architecture test of test is
  component ALU is
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
end component;

  signal CLK : std_logic;
  signal A : signed (15 downto 0);
  signal B : signed (15 downto 0);
  signal funcSelect : std_logic_vector(3 downto 0);
  signal Cin : std_logic;
  signal Zin : std_logic;
  signal Cout : std_logic;
  signal Zout : std_logic;
  signal AluOut_on_Databus : std_logic_vector(15 downto 0);

  begin
    an : ALU port map (CLK => CLK ,A => A , B => B , funcSelect => funcSelect , Cin => Cin , Zin => Zin , Cout => Cout, Zout => Zout , AluOut_on_Databus => AluOut_on_Databus);
    A <= "0101101001011100";
    B <= "1010111000101101";
    funcSelect <= "0000","0001" after 60 ns , "0010" after 120 ns , "0011" after 180 ns , "0100" after 240 ns , "0101" after 310 ns , "0110" after 360 ns , "0111" after 420 ns , "1000" after 480 ns;
    Cin <= '0';
    Zin <= '0';
    ClockGen: process
    begin
      while true loop
          CLK <= '0';
            wait for 50 ns;
            CLK <= '1';
            wait for 50 ns;
        end loop;
        wait;
    end process ;
end test;
