library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MultiplierComponent is
port(
    Rs : in std_logic_vector(7 downto 0);
    Rd: in std_logic_vector(7 downto 0);
    result: out std_logic_vector(15 downto 0);
    Cout : out std_logic;
    Zout : out std_logic
     );
end MultiplierComponent;

architecture rtl of MultiplierComponent is

  signal R1,R2,R3: std_logic_vector(15 downto 0) := (others => '0');
  signal copy : std_logic_vector (15 downto 0);
begin
Process(Rs,Rd)
begin

  for i in 0 to 15 loop

    if i = 0 then
      if Rd(i) = '1' then
        R1(7+i downto i) <= Rs(7 downto 0);
      else
        R1(7+i downto i) <= (others => '0');
      end if;
      copy(i) <= R1(i);

    elsif (i>0 and i<8) then
      if Rd(i) = '1' then
        R2(7+i downto i) <= Rs(7 downto 0);
      else
        R2(7+i downto i) <= (others => '0');
      end if;
      R3 <= R1 + R2;
      copy(i) <= R3(i);
      R1 <= R3; R2 <= (others => '0');

    else
      copy(i) <= R3(i);
    end if;

  end loop;
end process;
  Cout <= '0';
  result  <= copy;
  with copy select
  Zout <= '1' when "0000000000000000",
  '0' when others;
end architecture;
