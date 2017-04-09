library ieee;
use ieee.std_logic_1164.all;

entity ShiftRightComponent is
  port(
    Rs : in std_logic_vector (15 downto 0);
    Rd : out std_logic_vector (15 downto 0)
  );
end entity;

architecture RTL of ShiftRightComponent is
  signal copy : std_logic_vector (15 downto 0); 
  begin
    copy(15) <= '0';
    copy(14 downto 0) <= Rs(15 downto 1);
    Rd <= copy;
end architecture;
