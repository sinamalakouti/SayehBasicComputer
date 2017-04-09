library ieee;
use ieee.std_logic_1164.all;

entity ShiftLeftComponent is
  port(
    Rs : in signed (15 downto 0);
    result : out signed (15 downto 0)
  );
end entity;

architecture RTL of ShiftLeftComponent is
  signal copy : std_logic_vector (15 downto 0);
  begin
    copy(0) <= '0';
    copy(15 downto 1) <= Rs(14 downto 0);
    result <= copy;
end architecture;
