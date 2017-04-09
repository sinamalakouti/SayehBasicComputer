library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity SubtractionComponent is
  port(
    Rs : in signed (15 downto 0);
    Rd : in signed (15 downto 0);
    Carryflag : in std_logic;
    result : out signed (15 downto 0)
  );
end entity;

architecture RTL of SubtractionComponent is
  signal sum : signed(15 downto 0);
  begin
    sum <= Rd - Rs - Carryflag;
end architecture;
