library ieee;
use ieee.std_logic_1164.all;

entity ShiftLeftComponent is
  port(
    Rs : in std_logic_vector (15 downto 0);
    result : out std_logic_vector (15 downto 0);
    Cout : out std_logic;
    Zout : out std_logic
  );
end entity;

architecture RTL of ShiftLeftComponent is
  signal copy : std_logic_vector (15 downto 0);
  begin
    copy(0) <= '0';
    copy(15 downto 1) <= Rs(14 downto 0);
    result <= copy;
    Cout <= '0';
    with copy select
    Zout <= '1' when "0000000000000000",
    '0' when others;
end architecture;
