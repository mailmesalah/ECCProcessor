----------------------------------------------------------------------
--------------------------//Program Counter//-------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;

entity ProgramCounter is
  port(
      Input: in std_logic_vector(7 downto 0);
      Clock: in std_logic;
      Reset: in std_logic;
      PCload:in std_logic;
      Output:out std_logic_vector(7 downto 0)
      );
end ProgramCounter;
 
architecture Operation of ProgramCounter is

begin
  process(Clock)
    variable PC:std_logic_vector(7 downto 0):="00000000";
    begin
      if(Reset='1' and Clock='1')then
        PC:="00000000";        
      elsif(PCload='1' and Clock='1')then
        PC:=Input;
      end if;
      Output<=PC;
    end process;
end Operation;


----------------------------------------------------------------------