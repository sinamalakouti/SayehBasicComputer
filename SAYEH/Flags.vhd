library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity FlagsReg is
  port (
    clk : in std_logic;
    Cin,Zin,Cset,Creset,Zset,Zreset,SRload : in std_logic;
    Cout,Zout : out std_logic
  );
end entity;

architecture arch of FlagsReg is
  signal tz,tc : std_logic;
begin
  process(clk)
  begin
    if(clk'event and clk = '1') then
      if(Cset = '1') then Cout <= '1';
    end if;
      if(Creset = '1') then Cout <= '0';
    end if;
      if(Zset = '1') then Zout <= '1';
    end if;
      if(Zreset = '1') then Zout <= '0';
    end if;
      if(SRload = '1') then Cout <= Cin; Zout <= Zin;
    end if;
  end if;
  end process;
end architecture;
