library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity IR is
  port (
    clk : in std_logic;
    IRload : in std_logic;
    input : in std_logic_vector(15 downto 0);
    output : out std_logic_vector(15 downto 0)
  );
end entity;

architecture arch of IR is
begin
  process(clk)
  begin
      if(clk'event and clk = '1') then
        if(IRload = '1') then
        output <= input;
        end if;
      end if;
  end process;
end architecture;
