----------------------------------------------------------------------
------------------------------//Anding//------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity Anding is
  port(
      Input1: in std_logic_vector(162 downto 0);
      Input2: in std_logic_vector(162 downto 0);
      Output:out std_logic_vector(162 downto 0)
      );
end Anding;
 
architecture Operation of Anding is

begin
  process(Input1,Input2)
    begin
      Output<=Input1 and Input2;
    end process;
end Operation;
