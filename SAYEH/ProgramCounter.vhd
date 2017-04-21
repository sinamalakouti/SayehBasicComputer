library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity PC is
  port (
    EnablePC : in std_logic;
    input : in std_logic_vector(15 downto 0);
    clk : in std_logic;
    output : out std_logic_vector(15 downto 0)
  );
end entity;

architecture dataflow of PC is
begin
  process(clk)
  begin
    if(clk'event and clk = '1') then
      if(EnablePC = '1') then
        output <= input;
    end if;
  end if;
  end process;
end architecture;
