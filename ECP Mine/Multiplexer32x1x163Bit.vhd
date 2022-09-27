----------------------------------------------------------------------
----------------------------------------------------------------------
-------------------------//MUX 32x1  163bit//----------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
----------------------------
entity Multiplexer32x1x163Bit is
  port(
      a1,b1,c1,d1,e1,f1,g1,h1,i1,j1,k1,l1,m1,n1,o1,p1:in std_logic_vector(162 downto 0);
      a2,b2,c2,d2,e2,f2,g2,h2,i2,j2,k2,l2,m2,n2,o2,p2:in std_logic_vector(162 downto 0);
      s:in std_logic_vector(4 downto 0);
      Output:out std_logic_vector(162 downto 0)
      );
end Multiplexer32x1x163Bit;
----------------------------
architecture Operation of Multiplexer32x1x163Bit is
begin
  process(s,a1,b1,c1,d1,e1,f1,g1,h1,i1,j1,k1,l1,m1,n1,o1,p1,a2,b2,c2,d2,e2,f2,g2,h2,i2,j2,k2,l2,m2,n2,o2,p2)
    begin
      if(s="00000")then
        Output<= a1;
      elsif(s="00001")then
        Output<= b1;
      elsif(s="00010")then
        Output<= c1;
      elsif(s="00011")then
        Output<= d1;
      elsif(s="00100")then
        Output<= e1;
      elsif(s="00101")then
        Output<= f1;
      elsif(s="00110")then
        Output<= g1;
      elsif(s="00111")then
        Output<= h1;
      elsif(s="01000")then
        Output<= i1;
      elsif(s="01001")then
        Output<= j1;
      elsif(s="01010")then
        Output<= k1;
      elsif(s="01011")then
        Output<= l1;
      elsif(s="01100")then
        Output<= m1;
      elsif(s="01101")then
        Output<= n1;
      elsif(s="01110")then
        Output<= o1;
      elsif(s="01111")then
        Output<= p1;
      elsif(s="10000")then
        Output<= a2;
      elsif(s="10001")then
        Output<= b2;
      elsif(s="10010")then
        Output<= c2;
      elsif(s="10011")then
        Output<= d2;
      elsif(s="10100")then
        Output<= e2;
      elsif(s="10101")then
        Output<= f2;
      elsif(s="10110")then
        Output<= g2;
      elsif(s="10111")then
        Output<= h2;
      elsif(s="11000")then
        Output<= i2;
      elsif(s="11001")then
        Output<= j2;
      elsif(s="11010")then
        Output<= k2;
      elsif(s="11011")then
        Output<= l2;
      elsif(s="11100")then
        Output<= m2;
      elsif(s="11101")then
        Output<= n2;
      elsif(s="11110")then
        Output<= o2;
      elsif(s="11111")then
        Output<= p2;
      end if;
    end Process;
end Operation;

----------------------------------------------------------------------
