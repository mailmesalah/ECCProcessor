-------------------------------Coded by Sely--------------------------

----------------------------------------------------------------------
----------------------------------------------------------------------
-------------------------//Multiplying//---------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use std.textio.all;
  use ieee.std_logic_textio.all;

entity Multiplying is
  port(
      Clock : in  std_logic;
      Reset : in  std_logic;
      Start : in  std_logic;
      A     : in  std_logic_vector(4 downto 0);
      B     : in  std_logic_vector(4 downto 0);
      Done  : out std_logic;
      Output: out std_logic_vector(4 downto 0)      
      );
end Multiplying;
 
architecture Operation of Multiplying is

begin

   process(Clock)
       variable vA:std_logic_vector(4 downto 0):="00000";
       variable vB:std_logic_vector(4 downto 0):="00000";
       variable vMul:std_logic_vector(5 downto 0):="000000";
       variable vRedPoly:std_logic_vector(4 downto 0):="00101";
       variable vStart:std_logic:='0';
       variable i:integer:=0;
       variable myLine : LINE;
       FILE f: TEXT open WRITE_MODE is "C:\output.txt"; 
   begin
      if(Clock='1' and Reset='1')then
         Output<="00000";
         Done<='0';
      elsif(Clock='1' and Start='1' and vStart='0')then
         --Starts Here
         Done<='0';
         vStart:='1';
         i:=4;
         vA:=A;
         vB:=B;
         vMul:='0'&vA;                      
      elsif(Clock='1' and Start='1' and vStart='1')then
          i:=i-1;          
          vMul:=vMul(4 downto 0)&'0';
         
          if(vB(i)='1')then
             vMul(4 downto 0):= vMul(4 downto 0) xor vA;
          end if;
         
          if(vMul(5)='1')then
              vMul(4 downto 0):= vMul(4 downto 0) xor vRedPoly;          
          end if;
          
          if(i=0)then
             vStart:='0';
             Done<='1';
             Output<=vMul(4 downto 0);               
          end if;  
      
      elsif(Clock='1' and Start='0' and vStart='1')then
         vStart:='0';     
      end if;
    
    if(Clock='1')then
    write(myLine, string'("---"));
    write(myLine, string'("vStart:"));    
    write(myLine, std_logic(vStart)); 
    write(myLine, string'("i:"));
    write(myLine, integer'(i));
    write(myLine, string'("Start:"));
    write(myLine, std_logic(Start));
    write(myLine, string'("A:"));
    write(myLine, A);
    write(myLine, string'("B:"));
    write(myLine, B);
    write(myLine, string'("vA:"));
    write(myLine, vA);
    write(myLine, string'("vB:"));
    write(myLine, vB);
    write(myLine, string'("Clock:"));
    write(myLine, Clock);
    write(myLine, string'("vMul:"));  
    write(myLine, vMul(4 downto 0)); 
    writeline(f, myLine); 
    end if;
      --report "hai";
      --if(clock='1')then
      --   report "---";
      --   report "vStart " & std_logic'image(vStart);         
      --   report "i " & integer'image(i);
         --report "vMul" & string'(vMul);
      --   report "---";
         --Output<=vMul(162 downto 0);
      --end if;
   end process;
 
end Operation;

----------------------------------------------------------------------
----------------------------------------------------------------------