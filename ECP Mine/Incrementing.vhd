----------------------------------------------------------------------
----------------------------//Incrementing//--------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity Incrementing is
  port(
      Input: in std_logic_vector(162 downto 0);
      Output:out std_logic_vector(162 downto 0)
      );
end Incrementing;
 
architecture Operation of Incrementing is

begin
  process(Input)
    variable x:std_logic_vector(162 downto 0);
    begin
      x:=Input+1;
      Output<=x(162 downto 0);
    end process;
end Operation;


----------------------------------------------------------------------