library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity div_binary is
Port (

            ina : in std_logic_vector (15 downto 0);-- range 0 to 99;
          inb:  in std_logic_vector (7 downto 0);-- range 1 to 9;
         quot:  out std_logic_vector (7 downto 0);-- range 0 to 99;

end div_binary;

architecture Behavioral of div_binary is

signal a,b: integer range 0 to 65535;
begin

a <= CONV_INTEGER(ina);
b <= CONV_INTEGER(inb);
process (a,b)

variable temp1,temp2: integer range 0 to 65535;
variable y :  std_logic_vector (15 downto 0);
 begin
 temp1:=a;
 temp2:=b;
 for i in 15 downto 0 loop
 if (temp1>temp2 * 2**i) then
 y(i):= '1';
 temp1:= temp1- temp2 * 2**i;
 else y(i):= '0';
 end if;
 end loop;
 rest <= CONV_STD_LOGIC_VECTOR (temp1 ,16);
  quot<= y;
 --quot<= conv_integer (y);
  end process;


end Behavioral
