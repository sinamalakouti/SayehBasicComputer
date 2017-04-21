library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity NotComponent is
  port (
    input : in std_logic_vector(15 downto 0);
    output : out std_logic_vector(15 downto 0);
    Cout : out std_logic;
    Zout : out std_logic
  );
end entity;

architecture arch of NotComponent is

begin
    output <= not input;
    Cout <= '0';
    Zout <= '0';
end architecture;
