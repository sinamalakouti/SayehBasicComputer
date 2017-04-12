library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity TwoRowInMultiplier is
  port (
  A : std_logic_vector(7 downto 0);
  B : std_logic_vector(7 downto 0);
  output : std_logic_vector(14 downto 0)
  );
end entity;

architecture arch of TwoRowInMultiplier is
  component rowInMultiplier is
    port (
      A : std_logic_vector(7 downto 0);
      B : std_logic_vector(7 downto 0);
      output : std_logic_vector(14 downto 0)
    );
  end component;
  signal input : std_logic_vector(27 downto 0);
  signal firstRowOutput : std_logic_vector(14 downto 0);
begin
  arim : aRowInMultiplier port map (A,B,firstRowOutput);

end architecture;
