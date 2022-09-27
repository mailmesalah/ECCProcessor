----------------------------------------------------------------------
--------------------------//Program Counter//-------------------------
    
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.std_logic_arith.all;  
------------------------------------------------- 
entity Increment8Bit is
  port(
      input:in std_logic_vector(7 downto 0);
      output:out std_logic_vector(7 downto 0)
      );
end Increment8Bit;  
    
-------------------------------------------------  
architecture Operation of Increment8Bit is
  begin
    process(input)
      begin
        output<=input+'1';
      end process;
end Operation;
----------------------------------------------------------------------