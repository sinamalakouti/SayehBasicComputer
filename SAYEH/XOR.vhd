library ieee;
use ieee.std_logic_1164.all;

entity XorComponent is
  port(
    Rs : in signed (15 downto 0);
    Rd : in signed (15 downto 0);
    result : out signed (15 downto 0)
  );
end entity;

architecture RTL of XorComponent is
  begin
    result <= (Rs and not Rd) or (not Rs and Rd);
end architecture;
