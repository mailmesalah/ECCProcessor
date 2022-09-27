----------------------------------------------------------------------
---------------------------//Zero Flag//------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;

entity ZeroFlag is
  port(
      AccIn: in std_logic_vector(162 downto 0);
      FlagO:out std_logic
      );
end ZeroFlag;
 
architecture Operation of ZeroFlag is

begin
  process(AccIn)
    variable Fl:std_logic:='0';
    begin
       Fl:='0';
       for i in 0 to 162 loop  
          Fl:=Fl or AccIn(i);
       end loop;
       
       FlagO<= not Fl;
    end process;
end Operation;


----------------------------------------------------------------------