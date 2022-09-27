----------------------------------------------------------------------
----------------------------//Decrementing//--------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity Decrementing is
  port(
      Input: in std_logic_vector(162 downto 0);
      Output:out std_logic_vector(162 downto 0)
      );
end Decrementing;
 
architecture Operation of Decrementing is

begin
  process(Input)
    variable x:std_logic_vector(162 downto 0);
    begin
      x:=Input-1;
      Output<=x(162 downto 0);
    end process;
end Operation;


----------------------------------------------------------------------