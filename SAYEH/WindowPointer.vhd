library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_unsigned.all;

entity WP is
  port (
    input : in std_logic_vector(5 downto 0);
    clk : in std_logic;
    WPadd,WPreset : in std_logic;
    output : out std_logic_vector(5 downto 0)
  );
end entity;

architecture arch of WP is
  signal saveFormerWP : std_logic_vector(5 downto 0) := "000000";
begin
  process(clk)
  begin
    if(clk'event and clk = '1') then
      if(WPadd = '1') then saveFormerWP <= saveFormerWP + input;
    end if;
      if(WPreset = '1') then saveFormerWP <= "000000";
    end if;
  end if;
  end process;
   output <= saveFormerWP;
end architecture;
