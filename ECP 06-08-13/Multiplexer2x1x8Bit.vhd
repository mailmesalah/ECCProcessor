----------------------------------------------------------------------
----------------------------------------------------------------------
-------------------------//MUX 2x1  8bit//----------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
----------------------------
entity Multiplexer2x1x8Bit is
  port(
      a,b:in std_logic_vector(7 downto 0);
      s:in std_logic;
      Output:out std_logic_vector(7 downto 0)
      );
end Multiplexer2x1x8Bit;
----------------------------
architecture Operation of Multiplexer2x1x8Bit is
begin
  process(s,a,b)
    begin
      if(s='0')then
        Output<= a;
      elsif(s='1')then
        Output<= b;
      end if;
      
    end Process;
end Operation;

----------------------------------------------------------------------
