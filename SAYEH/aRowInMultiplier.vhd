library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity rowInMultiplier is
  port (
    A : std_logic_vector(7 downto 0);
    B : std_logic_vector(7 downto 0);
    output : std_logic_vector(14 downto 0)
  );
end entity;

architecture arch of rowInMultiplier is
  component halfadder is
    port(A , B : in std_logic;
         SUM, CARRY : out std_logic
         );
  end component;

  component fulladder is
    port(A , B , C_IN : in std_logic;
         SUM, CARRY : out std_logic
         );
  end component;

  signal input : std_logic_vector(20 downto 0);
begin
  input(0) <= A(0) and B(0);
  input(1) <= A(1) and B(0);
  input(2) <= A(0) and B(1);
  input(3) <= A(2) and B(0);
  input(4) <= A(1) and B(1);
  input(5) <= A(0) and B(2);
  input(6) <= A(2) and B(1);
  input(7) <= A(0) and B(3);
  input(8) <= A(1) and B(2);
  input(9) <= A(2) and B(2);
  input(10) <= A(1) and B(3);
  input(11) <= A(0) and B(4);
  input(12) <= A(2) and B(3);
  input(13) <= A(1) and B(4);
  input(14) <= A(0) and B(5);
  input(15) <= A(2) and B(4);
  input(16) <= A(1) and B(5);
  input(17) <= A(0) and B(6);
  input(18) <= A(2) and B(5);
  input(19) <= A(1) and B(6);
  input(20) <= A(0) and B(7);

  output(0) <= input(0);
  ha : halfadder port map (input(1),input(2),output(1),output(2));
  fa1 : fulladder port map (input(3),input(4),input(5),output(3),output(4));
  fa1 : fulladder port map (input(6),input(7),input(8),output(5),output(6));
  fa1 : fulladder port map (input(9),input(10),input(11),output(7),output(8));
  fa1 : fulladder port map (input(12),input(13),input(14),output(9),output(10));
  fa1 : fulladder port map (input(15),input(16),input(17),output(11),output(12));
  fa1 : fulladder port map (input(18),input(19),input(20),output(13),output(14));

end architecture;
