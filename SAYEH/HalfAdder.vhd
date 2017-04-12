library IEEE;
use IEEE.std_logic_1164.all;

entity halfadder is
  port(A , B : in std_logic;
       SUM, CARRY : out std_logic
       );      
end entity halfadder;

architecture behavioral of halfadder is
  begin
    SUM <= A xor B;
    CARRY <= A and B;
end behavioral;
