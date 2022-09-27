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
      Output:out std_logic_vector(162 downto 0)
      
      --Testing Purpose
      --AccRegOut,RRegOut,PxRegOut,PyRegOut,QxRegOut,QyRegOut,QzRegOut,T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut,AccMuxOut,AddMuxOut,SqrMuxOut,MulMuxOut,AddOut,MulOut,SqrOut,AndOut,OrOut,IncrementOut,DecrementOut,RShiftOut,LShiftOut:inout std_logic_vector(162 downto 0);
      --ZeroF:out std_logic
      --Testing Purpose
      );
end ECProcessor;
 
architecture Operation of ECProcessor is

component Datapath is
  port(
      Clock:in std_logic;
      Reset:in std_logic;      
      
      Input:in std_logic_vector(162 downto 0);
      
      AccMuxSel:in std_logic_vector(4 downto 0);
      AddMuxSel,SqrMuxSel,MulMuxSel:in std_logic_vector(3 downto 0);
      T1RegLoad,T2RegLoad,T3RegLoad,X3RegLoad,Y3RegLoad,Z3RegLoad:in std_logic;
      MemEnable,MemRW,AccRegLoad,PxRegLoad,PyRegLoad,QzRegLoad:in std_logic;
      QxRegLoad,QyRegLoad,PCLoad,PCMuxSel,IRLoad,MemMuxSel,StartSQR,StartMul,StartLShift,
      StartRShift,RRegLoad:in std_logic;
      
      --Testing
      --AccRegOut,RRegOut,PxRegOut,PyRegOut,QxRegOut,QyRegOut,QzRegOut,T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut,AccMuxOut,AddMuxOut,SqrMuxOut,MulMuxOut,AddOut,MulOut,SqrOut,AndOut,OrOut,IncrementOut,DecrementOut,RShiftOut,LShiftOut:inout std_logic_vector(162 downto 0);
      --Testing
      
      IR:out std_logic_vector(170 downto 0);
      Output:out std_logic_vector(162 downto 0);
      DoneSQR,DoneMul,DoneLShift,DoneRShift,ZeroF:out std_logic     
      );
end component;

component ControlUnit is
  port(              
      Clock:in std_logic;
      Reset:in std_logic;
      
      AccMuxSel:out std_logic_vector(4 downto 0);
      AddMuxSel,SqrMuxSel,MulMuxSel:out std_logic_vector(3 downto 0);
      T1RegLoad,T2RegLoad,T3RegLoad,X3RegLoad,Y3RegLoad,Z3RegLoad:out std_logic;
      MemEnable,MemRW,AccRegLoad,PxRegLoad,PyRegLoad,QzRegLoad:out std_logic;
      QxRegLoad,QyRegLoad,RRegLoad,PCLoad,PCMuxSel,IRLoad,MemMuxSel,StartSQR,StartMul,
      StartLShift,StartRShift:out std_logic;

      IR:in std_logic_vector(170 downto 0);
      DoneSQR,DoneMUl,DoneLShift,DoneRShift,ZeroF:in std_logic
      );
end component;

signal AccMuxSel:std_logic_vector(4 downto 0);
signal AddMuxSel,SqrMuxSel,MulMuxSel:std_logic_vector(3 downto 0);
signal T1RegLoad,T2RegLoad,T3RegLoad,X3RegLoad,Y3RegLoad,Z3RegLoad,RRegLoad:std_logic;
signal MemEnable,MemRW,AccRegLoad,PxRegLoad,PyRegLoad,QzRegLoad,ZeroF:std_logic;
signal QxRegLoad,QyRegLoad,PCLoad,PCMuxSel,IRLoad,MemMuxSel,DoneSQR,DoneMul,
DoneLShift,DoneRShift,StartSQR,StartMul,StartLShift,StartRShift:std_logic;
signal IR:std_logic_vector(170 downto 0);
    

begin

DataP :Datapath port map(Clock,Reset,Input,AccMuxSel,AddMuxSel,SqrMuxSel,MulMuxSel,
      T1RegLoad,T2RegLoad,T3RegLoad,X3RegLoad,Y3RegLoad,Z3RegLoad,MemEnable,MemRW,
      AccRegLoad,PxRegLoad,PyRegLoad,QzRegLoad,QxRegLoad,QyRegLoad,PCLoad,PCMuxSel,
      IRLoad,MemMuxSel,StartSQR,StartMul,StartLShift,StartRShift,RRegLoad,
      --Test
      --AccRegOut,RRegOut,PxRegOut,PyRegOut,QxRegOut,QyRegOut,QzRegOut,T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut,AccMuxOut,AddMuxOut,SqrMuxOut,MulMuxOut,AddOut,MulOut,SqrOut,AndOut,OrOut,IncrementOut,DecrementOut,RShiftOut,LShiftOut,
      --Test
      IR,Output,DoneSQR,DoneMul,
      DoneLShift,DoneRShift,ZeroF);
      
ControlU :ControlUnit port map(Clock,Reset,AccMuxSel,AddMuxSel,SqrMuxSel,MulMuxSel,T1RegLoad,T2RegLoad,
      T3RegLoad,X3RegLoad,Y3RegLoad,Z3RegLoad,MemEnable,MemRW,AccRegLoad,
      PxRegLoad,PyRegLoad,QzRegLoad,QxRegLoad,QyRegLoad,RRegLoad,PCLoad,PCMuxSel,IRLoad,MemMuxSel,StartSQR,StartMul,
      StartLShift,StartRShift,IR,DoneSQR,DoneMUl,DoneLShift,DoneRShift,ZeroF);
      
end Operation;
----------------------------------------------------------------------
