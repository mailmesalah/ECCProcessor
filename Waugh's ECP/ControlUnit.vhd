----------------------------------------------------------------------
----------------------------------------------------------------------
--------------------------//Control Unit//----------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;

entity ControlUnit is
  port(              
      Clock:in std_logic;
      Reset:in std_logic;
      OutputOn:out std_logic;
      IRload: out std_logic;
      SUBmux: out std_logic_vector(1 downto 0);
      Amux: out std_logic_vector(2 downto 0)
      );
end ControlUnit;
 
architecture Operation of ControlUnit is
 
begin

  process(Clock)
     
    variable state:std_logic_vector(7 downto 0):="00000000";
     
  begin
    
    if(Reset='1' and Clock='1')then     state:="00000000";
                          
    elsif(clock='1')then 
      case state is
        when "00000000" =>  state:="00000001";--Start state                          
        
        when "00000001" =>  state:="00000010";--Point Addition state                           
        when "00000001" =>  state:="00000010";--T1?Z1·x2.
        when "00000001" =>  state:="00000010";--T2?Z12.
        when "00000001" =>  state:="00000010";--X3?X1+T1.           
        when "00000001" =>  state:="00000010";--T1?Z1·X3.
        when "00000001" =>  state:="00000010";--T3?T2·y2.
        when "00000001" =>  state:="00000010";--Y3?Y1+T3.  
        when "00000001" =>  
          if(x)then--If X3 = 0 then
            --If Y3 = 0 then use Algorithm 3.24 to compute
            --(X3 : Y3 : Z3) = 2(x2 : y2 : 1) and return(X3 : Y3 : Z3).
            state:="00000010";--
          else--Else return(?).
            state:="00000010";--
          end if;  
        when "00000001" =>  state:="00000010";--Z3?T12 .  
        when "00000001" =>  state:="00000010";--T3?T1·Y3.
        when "00000001" =>  state:="00000010";--If a = 1 then T1?T1 +T2.
          --T2?X32.
        when "00000001" =>  state:="00000010";--X3?T2·T1.
        when "00000001" =>  state:="00000010";--T2?Y32.
        when "00000001" =>  state:="00000010";--X3?X3+T2.
        when "00000001" =>  state:="00000010";--X3?X3+T3.
        when "00000001" =>  state:="00000010";--T2?x2·Z3.
        when "00000001" =>  state:="00000010";--T2?T2+X3.
        when "00000001" =>  state:="00000010";--T1?Z32.
        when "00000001" =>  state:="00000010";--T3?T3+Z3.
        when "00000001" =>  state:="00000010";--Y3?T3·T2.
        when "00000001" =>  state:="00000010";--T2?x2+y2.
        when "00000001" =>  state:="00000010";--T3?T1·T2.
        when "00000001" =>  state:="00000010";--Y3?Y3+T3.
        when "00000001" =>  state:="00000010";--Return(X3:Y3:Z3).
        when "00000001" =>  state:="00000010";--
        
        when "00000010" =>  state:="00000010";--Point Doubling state 
        when "00000011" =>  state:="00000010";--Point Multiplication state 
        when "00000100" =>  state:="00000000";--Outputs Available
        when "00000101" =>  state:="00000110";--Nop State
        when others     =>  state:="00000000";-- When not in any state

        end case;
    end if;
  end Process;

 
end Operation;

----------------------------------------------------------------------
