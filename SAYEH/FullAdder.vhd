library IEEE;
use IEEE.std_logic_1164.all;

entity fulladder is
  port(A , B , C_IN : in std_logic;
       SUM, CARRY : out std_logic
       );      
end entity fulladder;

architecture behavioral of fulladder is
    component halfadder is
  port(A , B : in std_logic;
       SUM, CARRY : out std_logic);
end component;

  signal firstCarry, secondCarry , firstSum : std_logic;

  begin
    module1 : halfadder port map(A , B , firstSum , firstCarry);
    module2 : halfadder port map(firstSum , C_IN , SUM , secondCarry);
    CARRY <= firstCarry or secondCarry;
end behavioral;
