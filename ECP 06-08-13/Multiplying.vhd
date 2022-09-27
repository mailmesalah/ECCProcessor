-------------------------------Coded by Sely--------------------------

----------------------------------------------------------------------
----------------------------------------------------------------------
-------------------------//Multiplying//---------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity Multiplying is
  port(
      A     : in  std_logic_vector(162 downto 0);
      B     : in  std_logic_vector(162 downto 0);
      Start : inout  std_logic;
      Clock : in  std_logic;
      Reset : in  std_logic;
      Done  : out  std_logic;
      Output: out std_logic_vector(162 downto 0)      
      );
end Multiplying;
 
architecture Operation of Multiplying is

component Mul is
    Port( 
        a : in  STD_LOGIC_VECTOR (162 downto 0);
        b : in  STD_LOGIC;
        clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        c : out  STD_LOGIC_VECTOR (162 downto 0));
end component;

signal InputMux:std_logic;
signal OutLine :std_logic_vector(162 downto 0);

begin
  
  Mult:Mul port map(A,'1',Clock,Reset,OutLine);
  
  Output <= A xor B;   
  
  process(Clock)
    variable vStart : std_logic:='0';
    variable vCount  : integer:=0;
  begin
    if(Reset='1' and Clock='1')then
      Done<='0';
      vStart:='0';
      vCount:=0;
      InputMux<='0';
      Output<="0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    elsif(Clock='1' and Start='1' and vStart='0')then
      Done<='0';
      vStart:='1';
      vCount:=0;
      InputMux<='0';
    elsif(Clock='1' and vStart='1' and vCount<163)then
      InputMux<='1';
      vCount:=vCount+1;
    elsif(Clock='1' and vStart='1' and vCount>=163)then
      vCount:=0;
      vStart:='0';
      Done<='1';
      InputMux<='1';
      Output<=OutLine;
    end if;
      
  end Process;
end Operation;

----------------------------------------------------------------------
----------------------------------------------------------------------