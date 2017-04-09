library ieee;
use ieee.std_logic_1164.all;

entity OrComponent is
  port(
    Rs : in signed (15 downto 0);
    Rd : in signed (15 downto 0);
    result : out signed (15 downto 0)
  );
end entity;

architecture RTL of OrComponent is
  begin
    result <= Rs or Rd;
end architecture;
