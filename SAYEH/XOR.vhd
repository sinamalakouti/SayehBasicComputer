library ieee;
use ieee.std_logic_1164.all;

entity XorComponent is
  port(
    Rs : in std_logic_vector (15 downto 0);
    Rd : in std_logic_vector (15 downto 0);
    result : out std_logic_vector (15 downto 0)
  );
end entity;

architecture RTL of XorComponent is
  begin
    result <= (Rs and not Rd) or (not Rs and Rd);
end architecture;
