library ieee;
use ieee.std_logic_1164.all;

entity ComparisonComponent is
  port(
    Rs : in std_logic_vector (15 downto 0);
    Rd : in std_logic_vector (15 downto 0);
    Cout : out std_logic;
    Zout : out std_logic
  );
end entity;

architecture RTL of ComparisonComponent is
  begin
  process (Rs,Rd)
  begin
    if (Rs = Rd) then
      Zout <= '1';
      Cout <= '0';
    elsif (Rd < Rs) then
        Zout <= '0';
        Cout <= '1';
        else
            Zout <= '0';
            Cout <= '0';
    end if;
    end process;
end architecture;
