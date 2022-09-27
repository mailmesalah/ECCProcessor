----------------------------------------------------------------------
----------------------------------------------------------------------
-------------------------//MUX 4x1  163bit//----------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
----------------------------
entity Multiplexer4x1x163Bit is
  port(
      a,b,c,d:in std_logic_vector(162 downto 0);
      s:in std_logic_vector(1 downto 0);
      Output:out std_logic_vector(162 downto 0)
      );
end Multiplexer4x1x163Bit;
----------------------------
architecture Operation of Multiplexer4x1x163Bit is
begin
  process(s,a,b,c,d)
    begin
      if(s="00")then
        Output<= a;
      elsif(s="01")then
        Output<= b;
      elsif(s="10")then
        Output<= c;
      elsif(s="11")then
        Output<= d;
      end if;
    end Process;
end Operation;

----------------------------------------------------------------------
