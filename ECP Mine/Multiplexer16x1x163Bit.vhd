----------------------------------------------------------------------
----------------------------------------------------------------------
-------------------------//MUX 16x1  163bit//----------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
----------------------------
entity Multiplexer16x1x163Bit is
  port(
      a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p:in std_logic_vector(162 downto 0);     
      s:in std_logic_vector(3 downto 0);
      Output:out std_logic_vector(162 downto 0)
      );
end Multiplexer16x1x163Bit;
----------------------------
architecture Operation of Multiplexer16x1x163Bit is
begin
  process(s,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p)
    begin
      if(s="0000")then
        Output<= a;
      elsif(s="0001")then
        Output<= b;
      elsif(s="0010")then
        Output<= c;
      elsif(s="0011")then
        Output<= d;
      elsif(s="0100")then
        Output<= e;
      elsif(s="0101")then
        Output<= f;
      elsif(s="0110")then
        Output<= g;
      elsif(s="0111")then
        Output<= h;
      elsif(s="1000")then
        Output<= i;
      elsif(s="1001")then
        Output<= j;
      elsif(s="1010")then
        Output<= k;
      elsif(s="1011")then
        Output<= l;
      elsif(s="1100")then
        Output<= m;
      elsif(s="1101")then
        Output<= n;
      elsif(s="1110")then
        Output<= o;
      elsif(s="1111")then
        Output<= p;      
      end if;
    end Process;
end Operation;

----------------------------------------------------------------------
