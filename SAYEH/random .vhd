library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity random is
port (
a  : in std_logic_vector(15 downto 0);
result : out std_logic_vector(15 downto 0)
);
end entity;

architecture arch of random is

signal temp : std_logic_vector(15 downto 0);

begin
--temp(0) <= '0';
temp(15 downto 1) <= a(14 downto 0);
temp(0) <= a(0) xor a(7) xor a(15);
result <= temp;
end architecture;


