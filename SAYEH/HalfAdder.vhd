library IEEE;
use IEEE.std_logic_1164.all;

entity halfadder is
  port(A , B : in std_logic;
       cout, sum : out std_logic
       );
end entity halfadder;

architecture behavioral of halfadder is
  begin
    sum <= A xor B;
    cout <= A and B;
end behavioral;
