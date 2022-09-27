----------------------------------------------------------------------
---------------------//Eliptic Curve Processor//----------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;

entity ECProcessor is
  port(
      Clock: in std_logic;
      Input: in std_logic_vector(162 downto 0);      
      Reset: in std_logic;
      Output:out std_logic_vector(162 downto 0));
end ECProcessor;
 
architecture Operation of ECProcessor is

component Datapath is
  port(
      Clock:in std_logic;
      Reset:in std_logic;      
      
      Input:in std_logic_vector(162 downto 0);
      
      AddMuxSel,SqrMuxSel,MulMuxSel,AccMuxSel:in std_logic_vector(3 downto 0);
      T1RegLoad,T2RegLoad,T3RegLoad,X3RegLoad,Y3RegLoad,Z3RegLoad:in std_logic;
      AddOutLoad,SqrOutLoad,MulOutLoad,MemEnable,MemRW,AccRegLoad,PxRegLoad,PyRegLoad,PzRegLoad:in std_logic;
      QxRegLoad,QyRegLoad,PCLoad,PCMuxSel,IRLoad,MemMuxSel:in std_logic;
      
      IR:out std_logic_vector(170 downto 0);
      Output:out std_logic_vector(162 downto 0)     
      );
end component;

component ControlUnit is
  port(              
      Clock:in std_logic;
      Reset:in std_logic;
      
      AddMuxSel,SqrMuxSel,MulMuxSel,AccMuxSel:out std_logic_vector(3 downto 0);
      T1RegLoad,T2RegLoad,T3RegLoad,X3RegLoad,Y3RegLoad,Z3RegLoad:out std_logic;
      AddOutLoad,SqrOutLoad,MulOutLoad,MemEnable,MemRW,AccRegLoad,PxRegLoad,PyRegLoad,PzRegLoad:out std_logic;
      QxRegLoad,QyRegLoad,PCLoad,PCMuxSel,IRLoad,MemMuxSel:out std_logic;

      IR:in std_logic_vector(170 downto 0)
      );
end component;

signal AddMuxSel,SqrMuxSel,MulMuxSel,AccMuxSel:std_logic_vector(3 downto 0);
signal T1RegLoad,T2RegLoad,T3RegLoad,X3RegLoad,Y3RegLoad,Z3RegLoad:std_logic;
signal AddOutLoad,SqrOutLoad,MulOutLoad,MemEnable,MemRW,AccRegLoad,PxRegLoad,PyRegLoad,PzRegLoad:std_logic;
signal QxRegLoad,QyRegLoad,PCLoad,PCMuxSel,IRLoad,MemMuxSel:std_logic;
signal IR:std_logic_vector(170 downto 0);
    

begin

DataP     :Datapath port map(Clock,Reset,Input,AddMuxSel,SqrMuxSel,MulMuxSel,AccMuxSel,T1RegLoad,T2RegLoad,
                  T3RegLoad,X3RegLoad,Y3RegLoad,Z3RegLoad,AddOutLoad,SqrOutLoad,MulOutLoad,MemEnable,
                  MemRW,AccRegLoad,PxRegLoad,PyRegLoad,PzRegLoad,QxRegLoad,QyRegLoad,PCLoad,PCMuxSel,
                  IRLoad,MemMuxSel,IR,Output);
      
ControlU  :ControlUnit port map(Clock,Reset,AddMuxSel,SqrMuxSel,MulMuxSel,AccMuxSel,T1RegLoad,T2RegLoad,T3RegLoad,
                  X3RegLoad,Y3RegLoad,Z3RegLoad,AddOutLoad,SqrOutLoad,MulOutLoad,MemEnable,MemRW,AccRegLoad,PxRegLoad,
                  PyRegLoad,PzRegLoad,QxRegLoad,QyRegLoad,PCLoad,PCMuxSel,IRLoad,MemMuxSel,IR);
end Operation;
----------------------------------------------------------------------
