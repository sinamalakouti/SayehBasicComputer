library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity AdditionComponent is
  port(
    Rs : in std_logic_vector (15 downto 0);
    Rd : in std_logic_vector (15 downto 0);
    Carryflag : in std_logic;
    result : out std_logic_vector (15 downto 0);
    Carryout : out std_logic
  );
end entity;

architecture RTL of AdditionComponent is 
  signal sum : std_logic_vector(16 downto 0);
  signal Rsc : std_logic_vector(16 downto 0);
  signal Rdc : std_logic_vector(16 downto 0);
  begin
    Rsc(16) <= '0';
    Rdc(16) <= '0';
    Rsc(15 downto 0) <= Rs(15 downto 0);
    Rdc(15 downto 0) <= Rd(15 downto 0);
    sum <= Rsc + Rdc + Carryflag;
    result <= sum(15 downto 0);
    Carryout <= sum(16);
end architecture;