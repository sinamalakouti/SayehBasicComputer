library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity regFile is
  port(
    input : in std_logic_vector(15 downto 0);
    wp : in std_logic_vector(5 downto 0);
    selectR : in std_logic_vector(3 downto 0);
    clk: in std_logic;
    RFLwrite,RFHwrite : in std_logic;
    Rs : out std_logic_vector(15 downto 0);
    Rd : out std_logic_vector(15 downto 0)
  );
end entity;

architecture RTL of regFile is

  type registerFile is array (0 to 63) of std_logic_vector(15 downto 0);
  signal reg: registerFile := (others => "0000000000000010");

  begin
    Rd <= reg(to_integer (unsigned (wp)) + to_integer (unsigned (selectR(3 downto 2))));
    Rs <= reg(to_integer (unsigned (wp)) + to_integer (unsigned (selectR(1 downto 0))));
 process (clk)
   begin
     if (clk'event and clk = '1') then
        if(RFHWrite = '0' and RFLwrite = '1') then
           reg(to_integer (unsigned (wp)) + to_integer (unsigned (selectR(3 downto 2))))(7 downto 0) <= input(7 downto 0);
           reg(to_integer (unsigned (wp)) + to_integer (unsigned (selectR(3 downto 2))))(15 downto 8) <= "00000000";
        elsif (RFHWrite = '1' and RFLwrite = '0') then
          reg(to_integer (unsigned (wp)) + to_integer (unsigned (selectR(3 downto 2))))(15 downto 8) <= input(7 downto 0);
          reg(to_integer (unsigned (wp)) + to_integer (unsigned (selectR(3 downto 2))))(7 downto 0) <= "00000000";
        elsif (RFHWrite = '1' and RFLwrite = '1') then
           reg(to_integer (unsigned (wp)) + to_integer (unsigned (selectR(3 downto 2)))) <= input;
   end if;
     end if;
 end process;
end architecture;
