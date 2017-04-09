library ieee;
use ieee.std_logic_1164.all;

entity ComparisonComponent is
  port(
    Rs : in signed (15 downto 0);
    Rd : in signed (15 downto 0);
    Carryflag : out std_logic;
    Zeroflag : out std_logic
  );
end entity;

architecture RTL of ComparisonComponent is
  begin
  process (Rs,Rd)
  begin
    if (Rs = Rd) then
      Zeroflag <= '1';
      Carryflag <= '0';
    elsif (Rd < Rs) then
        Zeroflag <= '0';
        Carryflag <= '1';
        else
            Zeroflag <= '0';
            Carryflag <= '0';
    end if;
    end process;
end architecture;
