
-------------------------------Coded by Sely--------------------------

----------------------------------------------------------------------
----------------------------------------------------------------------
-------------------------//Squaring//---------------------------

library ieee;
  use ieee.std_logic_1164.all;
  --use ieee.std_logic_arith.all;
  --use ieee.std_logic_unsigned.all;
  --use ieee.numeric_std.all;

entity Squaring is
  port(
      Input : in  std_logic_vector(162 downto 0);
      Output: out std_logic_vector(162 downto 0)      
      );
end Squaring;
 
architecture Operation of Squaring is

begin
  process(Input)
    variable x:std_logic_vector(324 downto 0);
    variable polyRed:std_logic_vector(162 downto 0):="1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011001001";
    variable j:integer:=0;
    variable k:integer;
    begin
    
      --Squaring
      j:=0;
      for i in 0 to 162 loop          
	        x(j):=Input(i);
	        j:=j+1;	        
	        if(i/=162)then
	          x(j):='0';
            j:=j+1;
           end if;
      end loop;
      
      --Reduction
      for i in 324 downto 162 loop      
	       
	       if(x(i)='1') then
            k:=162;
	           for j in i downto (i-162) loop
	               x(j):=x(j) xor polyRed(k);
	               k:=k-1;		
	           end loop;	            

	       end if;	 
	 
      end loop;
      
      Output<=x(162 downto 0);
    
    end process;
        
end Operation;

----------------------------------------------------------------------
----------------------------------------------------------------------