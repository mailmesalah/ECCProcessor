
-------------------------------Coded by Sely--------------------------

----------------------------------------------------------------------
----------------------------------------------------------------------
-------------------------//Adding//---------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity Adding is
  port(
      A     : in  std_logic_vector(162 downto 0);
      B     : in  std_logic_vector(162 downto 0);
      Output: out std_logic_vector(162 downto 0)      
      );
end Adding;
 
architecture Operation of Adding is

begin
  Output <= A xor B;    
end Operation;

----------------------------------------------------------------------
----------------------------------------------------------------------