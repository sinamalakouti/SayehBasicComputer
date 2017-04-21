library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity flagtest is
end entity;

architecture test of flagtest is
  component FlagsReg is
    port (
      clk : in std_logic;
      Cin,Zin,Cset,Creset,Zset,Zreset,SRload : in std_logic;
      Cout,Zout : out std_logic
    );
  end component;
  signal clk : std_logic;
  signal Cin,Zin,Cset,Creset,Zset,Zreset,SRload : std_logic;
  signal Cout,Zout : std_logic;
  begin
    ft : FlagsReg port map (clk => clk , Cin => Cin,Zin => Zin , Cset =>Cset, Creset =>Creset , Zset => Zset , Zreset => Zreset , SRload => SRload , Cout => Cout ,Zout => Zout);
    ClockGen: process
    begin
      while true loop
          clk <= '0';
            wait for 50 ns;
            clk <= '1';
            wait for 50 ns;
        end loop;
        wait;
    end process ;
    SRload <= '1' , '0'after 100 ns ,'1' after 500 ns;
    Cset <= '0' , '1' after 100 ns , '0' after 200 ns , '1' after 300 ns , '0' after 400 ns;
    Creset <= '0' , '1' after 200 ns , '0' after 300 ns;
    Zset <= '0' , '1' after 300 ns , '0' after 500 ns;
    Zreset <= '0' , '1' after 100 ns, '0' after 300 ns;
    Cin <= '1';
    Zin <= '0';
end architecture;
