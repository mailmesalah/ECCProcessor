----------------------------------------------------------------------
----------------------------------------------------------------------
------------------------------//Register//----------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;

entity Register163Bit is
  port(
      Input: in std_logic_vector(162 downto 0);
      Clock: in std_logic;
      Reset: in std_logic;
      RLoad:in std_logic;
      Output:out std_logic_vector(162 downto 0)
      );
end Register163Bit;
 
architecture Operation of Register163Bit is

begin
  process(Clock)
    variable IR:std_logic_vector(162 downto 0):="0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    begin
      if(Reset='1' and Clock='1')then
        IR:="0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";        
      elsif(RLoad='1' and Clock='1')then
        IR:=Input;      
      end if;
      
      Output<=IR;
    end process;
end Operation;


----------------------------------------------------------------------