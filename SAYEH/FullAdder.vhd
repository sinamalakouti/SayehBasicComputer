library IEEE;
use IEEE.std_logic_1164.all;

entity fulladder is
  port(a, b , cin: in std_logic;
       cout, sum : out std_logic
       );
end entity fulladder;

architecture behavioral of fulladder is
    component halfadder is
  port(A , B : in std_logic;
       cout, sum : out std_logic);
end component;

  signal firstCarry, secondCarry , firstSum : std_logic;

  begin
    module1 : halfadder port map(a , b , firstCarry, firstSum );
    module2 : halfadder port map(firstSum , cin  , secondCarry, sum);
    cout <= firstCarry or secondCarry;
end behavioral;
