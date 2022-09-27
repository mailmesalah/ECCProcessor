----------------------------------------------------------------------
------------------------------//Right Shifting//------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity RightShift is
  port(
      Clock: in std_logic;
      Reset: in std_logic;
      Start: in std_logic;
      Input: in std_logic_vector(162 downto 0);
      Count: in std_logic_vector(162 downto 0);
      Output:out std_logic_vector(162 downto 0);
      Done: out std_logic
      );
end RightShift;
 
architecture Operation of RightShift is

begin
  process(Clock)
      variable vIn:std_logic_vector(162 downto 0):="0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      variable vCount:std_logic_vector(162 downto 0):="0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      variable vStart:std_logic:='0';
   begin
      if(Clock='1' and Reset='1')then          
         vIn:="0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
         vCount:="0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
         vStart:='0';
         Done<='0';
      elsif(Clock='1' and Start='1' and vStart='0')then
         vIn:=Input;
         vCount:=Count;
         vStart:='1';
         Done<='0';
      elsif(Clock='1' and Start='1' and vStart='1')then
         if(vCount=0)then
            vStart:='0';
            Done<='1';
            Output<=vIn;
         else
            vCount:=vCount-1;
            vIn(162 downto 0):='0'&vIn(162 downto 1);    
         end if;                               
      end if;      
   end process;
end Operation;


----------------------------------------------------------------------