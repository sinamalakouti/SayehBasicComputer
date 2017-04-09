library ieee;
use ieee.std_logic_1164.all;

entity AndComponent is
  port(
    Rs : in std_logic_vector (15 downto 0);
    Rd : in std_logic_vector (15 downto 0);
    result : out std_logic_vector (15 downto 0)
  );
end entity;

architecture RTL of AndComponent is
  begin
    result <= Rs and Rd;
end architecture;