library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity TwoComplementComponent is
  port(
    Rs : in std_logic_vector (15 downto 0);
    result : out std_logic_vector (15 downto 0)
  );
end entity;

architecture RTL of TwoComplementComponent is
  begin
    result <= not Rs + '1';
end architecture;