library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity SubtractionComponent is
  port(
    Rs : in std_logic_vector (15 downto 0);
    Rd : in std_logic_vector (15 downto 0);
    Carryflag : in std_logic;
    result : out std_logic_vector (15 downto 0)
  );
end entity;

architecture RTL of SubtractionComponent is
  signal sum : std_logic_vector(15 downto 0);
  begin
    sum <= Rd - Rs - Carryflag;
end architecture;



