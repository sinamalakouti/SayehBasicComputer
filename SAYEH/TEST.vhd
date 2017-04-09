library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity test is
end entity;

architecture test of test is
  component TwoComplementComponent is
  port(
    Rs : in std_logic_vector (15 downto 0);
    result : out std_logic_vector (15 downto 0)
  );
end component;
  signal i : std_logic_vector (15 downto 0);
  signal res : std_logic_vector (15 downto 0);
  begin
    an : TwoComplementComponent port map (Rs => i ,result => res);
    i <= "1110101011001101";
end test;