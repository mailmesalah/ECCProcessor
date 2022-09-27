----------------------------------------------------------------------
-----------------------//Instruction Register//-----------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;

entity InstructionRegister is
  port(
      Input : in  std_logic_vector(170 downto 0);
      Clock : in  std_logic;
      Reset : in  std_logic;
      IRload: in  std_logic;
      Output: out std_logic_vector(170 downto 0)
      );
end InstructionRegister;
 
architecture Operation of InstructionRegister is

begin
  process(Clock)
    variable IR:std_logic_vector(170 downto 0):="000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    begin
      if(Reset='1' and Clock='1')then
        IR:="000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";        
      elsif(IRload='1' and Clock='1')then
        IR:=Input;
      end if;
      
      Output<=IR;
    end process;
end Operation;


----------------------------------------------------------------------