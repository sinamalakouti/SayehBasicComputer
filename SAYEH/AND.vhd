library ieee;
use ieee.std_logic_1164.all;

entity AndComponent is
  port(
    Rs : in std_logic_vector (15 downto 0);
    Rd : in std_logic_vector (15 downto 0);
    result : out std_logic_vector (15 downto 0);
    Cout : out std_logic;
    Zout : out std_logic
  );
end entity;

architecture RTL of AndComponent is
  signal copy : std_logic_vector(15 downto 0);
  begin
    copy <= Rs and Rd;
    result <= copy;
    Cout <= '0';
    with copy select
    Zout <= '1' when "0000000000000000",
    '0' when others;
end architecture;
