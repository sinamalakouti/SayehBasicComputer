library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity multiply is
  port (
  x : in std_logic_vector(7 downto 0);
  y : in std_logic_vector(7 downto 0);
  result : out std_logic_vector(15 downto 0);
  Cout : out std_logic;
  Zout : out std_logic
  );
end entity;

architecture arch of multiply is
  signal c1, c2,c3 ,c4, c5, c6, c7, c8 : std_logic_vector(7 downto 0);
  signal s1,s2,s3,s4,s5,s6,s7,s8 : std_logic_vector ( 7 downto 0);
  -- signal xy0 ,xy1, xy2, xy3, xy4, xy5, xy6, xy7,xy8 : std_logic_vector ( 7 downto 0);
  component fullAdder
    port ( a,b, cin : in std_logic;
    cout, sum  : out std_logic);
  end component;
  component halfAdder
  port ( a,b : in std_logic;
  cout, sum  : out std_logic);
end component;

-- type xy_array is array ( 7 downto 0  ) of std_logic_vector (7 downto 0);
type xy_array is array ( 7 downto 0 , 7 downto 0 ) of std_logic;

signal yx : xy_array;
signal temp : std_logic_vector(15 downto 0);
begin



i_id : for i in 0 to 7 generate
    j_id : for j in 0 to 7 generate
      yx(i,j) <= x(j) and y(i);
    end generate;
end generate;


-- xy0 parameters :
-- xy0(0) <=  x(0) and y(0);
-- xy0(1) <=  x(1) and y(0);
-- xy0(2) <=  x(2) and y(0);
-- xy0(3) <=  x(3) and y(0);
-- xy0(4) <=  x(4) and y(0);
-- xy0(5) <=  x(5) and y(0);
-- xy0(6) <=  x(6) and y(0);
-- xy0(7) <=  x(7) and y(0);
-- -- xy1 parameters
-- xy1(0) <= x(0) and y(1);
-- xy1(1) <= x(1) and y(1);
-- xy1(2) <= x(2) and y(1);
-- xy1(3) <= x(3) and y(1);
-- xy1(4) <= x(4) and y(1);
-- xy1(5) <= x(5) and y(1);
-- xy1(6) <= x(6) and y(1);
-- xy1(7) <= x(7) and y(1);
-- -- xy2 parameters
-- xy2(0) <= x(0) and y(2);
-- xy2(1) <= x(1) and y(2);
-- xy2(2) <= x(2) and y(2);
-- xy2(3) <= x(3) and y(2);
-- xy2(4) <= x(4) and y(2);
-- xy2(5) <= x(5) and y(2);
-- xy2(6) <= x(6) and y(2);
-- xy2(7) <= x(7) and y(2);
-- -- xy3 parameters
-- xy3(0) <= x(0) and y(3);
-- xy3(1) <= x(1) and y(3);
-- xy3(2) <= x(2) and y(3);
-- xy3(3) <= x(3) and y(3);
-- xy3(4) <= x(4) and y(3);
-- xy3(5) <= x(5) and y(3);
-- xy3(6) <= x(6) and y(3);
-- xy3(7) <= x(7) and y(3);

-- first row :
HA11 : halfAdder port map  (yx(0,1),yx(1,0),c1(0), s1(0) );
FA11 : fullAdder  port map (yx(0,2), yx(1,2),c1(0),c1(1), s1(1));
FA12 : fullAdder  port map (yx(0,3), yx(1,2),c1(1),c1(2), s1(2));
FA13 : fullAdder  port map (yx(0,4), yx(1,3),c1(2),c1(3), s1(3));
FA14 : fullAdder  port map (yx(0,5), yx(1,4),c1(3),c1(4), s1(4));
FA15 : fullAdder  port map (yx(0,6), yx(1,5),c1(4),c1(5), s1(5));
FA16 : fullAdder  port map (yx(0,7), yx(1,6),c1(5),c1(6), s1(6));
HA12 : halfAdder port map (yx(1,7), c1(6), c1(7), s1(7));
-- second row  :
HA21 : halfAdder port map (yx(2,0), s1(1),c2(0),s2(0));
FA21 : fullAdder port map (s1(2), yx(2,1), c2(0), c2(1), s2(1));
FA22 : fullAdder port map (s1(3),yx(2,2),c2(1),c2(2),s2(2));
FA23 : fullAdder port map (s1(4), yx(2,3),c2(2),c2(3),s2(3) );
FA24 : fullAdder port map (s1(5), yx(2,4),c2(3),c2(4),s2(4));
FA25 : fullAdder port map (s1(6), yx(2,5),c2(4),c2(5),s2(5));
FA26 : fullAdder port map (s1(7), yx(2,6),c2(5),c2(6),s2(6)  );
FA27 : fullAdder port map (c1(7), yx(2,7),c2(6),c2(7),s2(7));
-- third row :
HA31 : halfAdder port map (yx(3,0),s2(1),c3(0),s3(0));
FA31 : fullAdder port map (yx(3,1),s2(2),c3(0),c3(1),s3(1));
FA32 : fullAdder port map (yx(3,2),s2(3),c3(1),c3(2),s3(2)) ;
FA33 : fullAdder port map (yx(3,3),s2(4),c3(2),c3(3),s3(3));
FA34 : fullAdder port map (yx(3,4),s2(5),c3(3),c3(4),s3(4));
FA35 : fullAdder port map (yx(3,5),s2(6),c3(4),c3(5),s3(5));
FA36 : fullAdder port map (yx(3,6),s2(7),c3(5),c3(6),s3(6));
FA37 : fullAdder port map (yx(3,7),c2(7),c3(6),c3(7),s3(7));
-- 4th row :
HA41 : halfAdder port map (yx(4,0), s3(1),c4(0),s4(0));
FA41 : fullAdder port map (yx(4,1),s3(2),c4(0),c4(1),s4(1));
FA42 : fullAdder port map (yx(4,2),s3(3),c4(1),c4(2),s4(2));
FA43 : fullAdder port map (yx(4,3),s3(4),c4(2),c4(3),s4(3));
FA44 : fullAdder port map (yx(4,4),s3(5),c4(3),c4(4),s4(4));
FA45 : fullAdder port map (yx(4,5),s3(6),c4(4),c4(5),s4(5));
FA46 : fullAdder port map (yx(4,6),s3(7),c4(5),c4(6),s4(6));
FA47 : fullAdder port map (yx(4,7),c3(7),c4(6),c4(7),s4(7));
-- 5th row:
HA51 : halfAdder port map (yx(5,0),s4(1),c5(0),s5(0));
FA51 : fullAdder port map (yx(5,1),s4(2),c5(0),c5(1),s5(1));
FA52 : fullAdder port map (yx(5,2),s4(3),c5(1),c5(2),s5(2));
FA53 : fullAdder port map (yx(5,3),s4(4),c5(2),c5(3),s5(3));
FA54 : fullAdder port map (yx(5,4),s4(5),c5(3),c5(4),s5(4));
FA55 : fullAdder port map (yx(5,5),s4(6),c5(4),c5(5),s5(5));
FA56 : fullAdder port map (yx(5,6),s4(7),c5(5),c5(6),s5(6));
FA57 : fullAdder port map (yx(5,7),c4(7),c5(6),c5(7),s5(7));
-- 6th row :
HA61 : halfAdder port map (yx(6,0),s5(1),c6(0),s6(0));
FA61 : fullAdder port map (yx(6,1),s5(2),c6(0),c6(1),s6(1));
FA62 : fullAdder port map (yx(6,2),s5(3),c6(1),c6(2),s6(2));
FA63 : fullAdder port map (yx(6,3),s5(4),c6(2),c6(3),s6(3));
FA64 : fullAdder port map (yx(6,4),s5(5),c6(3),c6(4),s6(4));
FA65 : fullAdder port map (yx(6,5),s5(6),c6(4),c6(5),s6(5));
FA66 : fullAdder port map (yx(6,6),s5(7),c6(5),c6(6),s6(6));
FA67 : fullAdder port map (yx(6,7),c5(7),c6(6),c6(7),s6(7));
-- 7th row :
HA71 : halfAdder port map (yx(7,0),s6(1),c7(0),s7(0));
FA71 : fullAdder port map (yx(7,1),s6(2),c7(0),c7(1),s7(1));
FA72 : fullAdder port map (yx(7,2),s6(3),c7(1),c7(2),s7(2));
FA73 : fullAdder port map (yx(7,3),s6(4),c7(2),c7(3),s7(3));
FA74 : fullAdder port map (yx(7,4),s6(5),c7(3),c7(4),s7(4));
FA75 : fullAdder port map (yx(7,5),s6(6),c7(4),c7(5),s7(5));
FA76 : fullAdder port map (yx(7,6),s6(7),c7(5),c7(6),s7(6));
FA77 : fullAdder port map (yx(7,7),c6(7),c7(6),c7(7),s7(7));

  temp(0) <= yx(0,0);
  temp(1) <= s1(0);
  temp(2) <= s2(0);
  temp(3) <= s3(0);
  temp(4) <= s4(0);
  temp(5) <= s5(0);
  temp(6) <= s6(0);
  temp(7) <= s7(0);
  temp(8) <= s7(1);
  temp(9) <= s7(2);
  temp(10) <= s7(3);
  temp(11) <= s7(4);
  temp(12) <= s7(5);
  temp(13) <= s7(6);
  temp(14)  <= s7(7);
  temp(15) <= c7(7);
  Zout <= '1' when tmep = "0000000000000000" else '0';
  Cout <= '0';
  result <= temp;

end architecture;
