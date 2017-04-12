library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity AdditionComponent is
  port(
    Rs : in std_logic_vector (15 downto 0);
    Rd : in std_logic_vector (15 downto 0);
    Carryflag : in std_logic;
    result : out std_logic_vector (15 downto 0);
    Cout : out std_logic;
    Zout : out std_logic
  );
end entity;

architecture RTL of AdditionComponent is
  signal sum : std_logic_vector(16 downto 0);
  signal Rsc : std_logic_vector(16 downto 0);
  signal Rdc : std_logic_vector(16 downto 0);
  begin
    Rsc(15 downto 0) <= Rs;
    Rdc(15 downto 0) <= Rd;
    Rsc(16) <= '0';
    Rdc(16) <= '0';
    sum <= Rsc + Rdc + Carryflag;
    result <= sum(15 downto 0);
    Cout <= sum(16);
    with sum(15 downto 0) select
    Zout <= '1' when "0000000000000000",
    '0' when others;
end architecture;