library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity AdditionComponent is
  port(
    Rs : in signed (15 downto 0);
    Rd : in signed (15 downto 0);
    Carryflag : in std_logic;
    result : out signed (15 downto 0);
    Carryout : out std_logic
  );
end entity;

architecture RTL of AdditionComponent is
  signal sum : signed(16 downto 0);
  signal Rsc : signed(16 downto 0);
  signal Rdc : signed(16 downto 0);
  begin
    Rsc(16) <= '0';
    Rdc(16) <= '0';
    Rsc(15 downto 0) <= Rs(15 downto 0);
    Rdc(15 downto 0) <= Rd(15 downto 0);
    sum <= Rsc + Rdc + Carryflag;
    result <= sum(15 downto 0);
    Carryout <= sum(16);
end architecture;
