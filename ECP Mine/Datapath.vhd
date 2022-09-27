----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------//Data Path//-----------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity Datapath is
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
end Datapath;
 

architecture Operation of DataPath is

component Register163Bit is
  port(
      Input: in std_logic_vector(162 downto 0);
      Clock: in std_logic;
      Reset: in std_logic;
      RLoad:in std_logic;
      Output:out std_logic_vector(162 downto 0)
      );
end Component;

component Multiplexer32x1x163Bit is
  port(
      a1,b1,c1,d1,e1,f1,g1,h1,i1,j1,k1,l1,m1,n1,o1,p1:in std_logic_vector(162 downto 0);
      a2,b2,c2,d2,e2,f2,g2,h2,i2,j2,k2,l2,m2,n2,o2,p2:in std_logic_vector(162 downto 0);
      s:in std_logic_vector(4 downto 0);
      Output:out std_logic_vector(162 downto 0)
      );
end component;

component Multiplexer16x1x163Bit is
   port(
      a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p:in std_logic_vector(162 downto 0);
      s:in std_logic_vector(3 downto 0);
      Output:out std_logic_vector(162 downto 0)
      );
end component;

component Multiplexer4x1x163Bit is
  port(
      a,b,c,d:in std_logic_vector(162 downto 0);
      s:in std_logic_vector(1 downto 0);
      Output:out std_logic_vector(162 downto 0)
      );
end component;

component Multiplexer2x1x8Bit is
  port(
      a,b:in std_logic_vector(7 downto 0);
      s:in std_logic;
      Output:out std_logic_vector(7 downto 0)
      );
end component;

component Squaring is
  port(
      Clock : in  std_logic;
      Reset : in  std_logic;
      Start : in  std_logic;
      Input : in  std_logic_vector(162 downto 0);
      Done  : out std_logic;
      Output: out std_logic_vector(162 downto 0)      
      );
end component;

component Adding is
  port(
      A     : in  std_logic_vector(162 downto 0);
      B     : in  std_logic_vector(162 downto 0);
      Output: out std_logic_vector(162 downto 0)      
      );
end component;

component Multiplying is
  port(
      Clock : in  std_logic;
      Reset : in  std_logic;
      Start : in  std_logic;
      A     : in  std_logic_vector(162 downto 0);
      B     : in  std_logic_vector(162 downto 0);
      Done  : out std_logic;
      Output: out std_logic_vector(162 downto 0)      
      );
end component;

component ProgramCounter is
  port(
      Input: in std_logic_vector(7 downto 0);
      Clock: in std_logic;
      Reset: in std_logic;
      PCload:in std_logic;
      Output:out std_logic_vector(7 downto 0)
      );
end component;

component InstructionRegister is
  port(
      Input : in  std_logic_vector(170 downto 0);
      Clock : in  std_logic;
      Reset : in  std_logic;
      IRload: in  std_logic;
      Output: out std_logic_vector(170 downto 0)
      );
end component;

component Memory is
  port(
      Clock: in std_logic;
      Address: in std_logic_vector(7 downto 0);--Address
      Data:in std_logic_vector(162 downto 0);--Always from Accumulator      
      MemEnable:in std_logic;
      RW:in std_logic;
      Output:out std_logic_vector(170 downto 0)
      );
end component;

component Increment8Bit is
  port(
      input:in std_logic_vector(7 downto 0);
      output:out std_logic_vector(7 downto 0)
      );
end component;  

component Anding is
  port(
      Input1: in std_logic_vector(162 downto 0);
      Input2: in std_logic_vector(162 downto 0);
      Output:out std_logic_vector(162 downto 0)
      );
end component;

component Oring is
  port(
      Input1: in std_logic_vector(162 downto 0);
      Input2: in std_logic_vector(162 downto 0);
      Output:out std_logic_vector(162 downto 0)
      );
end component;

component Incrementing is
  port(
      Input: in std_logic_vector(162 downto 0);
      Output:out std_logic_vector(162 downto 0)
      );
end component;

component Decrementing is
  port(
      Input: in std_logic_vector(162 downto 0);
      Output:out std_logic_vector(162 downto 0)
      );
end component;

component RightShift is
  port(
      Clock: in std_logic;
      Reset: in std_logic;
      Start: in std_logic;
      Input: in std_logic_vector(162 downto 0);
      Count: in std_logic_vector(162 downto 0);
      Output:out std_logic_vector(162 downto 0);
      Done: out std_logic
      );
end component;

component LeftShift is
  port(
      Clock: in std_logic;
      Reset: in std_logic;
      Start: in std_logic;
      Input: in std_logic_vector(162 downto 0);
      Count: in std_logic_vector(162 downto 0);
      Output:out std_logic_vector(162 downto 0);
      Done: out std_logic
      );
end component;

component ZeroFlag is
  port(
      AccIn: in std_logic_vector(162 downto 0);
      FlagO:out std_logic
      );
end component;


signal AddOut,MulOut,SqrOut,AccRegOut:std_logic_vector(162 downto 0);
signal T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut,PxRegOut,PyRegOut,QzRegOut,QxRegOut,QyRegOut:std_logic_vector(162 downto 0);
signal AddMuxOut,SqrMuxOut,MulMuxOut,AccMuxOut,RRegOut,AndOut,OrOut,IncrementOut,DecrementOut,RShiftOut,LShiftOut:std_logic_vector(162 downto 0);
signal MemMuxOut,PCMuxOut,PCRegOut,Inc8Out:std_logic_vector(7 downto 0);
signal MemoryOut,IRRegOut:std_logic_vector(170 downto 0);

signal NotConnect:std_logic_vector(162 downto 0);

begin
  
  --Memory Unit--
  RAM:Memory port map(Clock,MemMuxOut,AccRegOut,MemEnable,MemRW,MemoryOut);--Memory
    
  --Memory Unit--
  
  --Arithmetic and Logic Unit--
  --Registers--   
  AccReg:Register163Bit port map(AccMuxOut,Clock,Reset,AccRegLoad,AccRegOut);--Accumulator Register
  RReg  :Register163Bit port map(AccRegOut,Clock,Reset,RRegLoad,RRegOut);--R  Register
  
  PxReg:Register163Bit port map(AccRegOut,Clock,Reset,PxRegLoad,PxRegOut);--Px Register
  PyReg:Register163Bit port map(AccRegOut,Clock,Reset,PyRegLoad,PyRegOut);--Py Register  
  QxReg:Register163Bit port map(AccRegOut,Clock,Reset,QxRegLoad,QxRegOut);--Qx Register
  QyReg:Register163Bit port map(AccRegOut,Clock,Reset,QyRegLoad,QyRegOut);--Qy Register
  QzReg:Register163Bit port map(AccRegOut,Clock,Reset,QzRegLoad,QzRegOut);--Qz Register
  
  T1Reg:Register163Bit port map(AccRegOut,Clock,Reset,T1RegLoad,T1RegOut);--T1 Register
  T2Reg:Register163Bit port map(AccRegOut,Clock,Reset,T2RegLoad,T2RegOut);--T2 Register
  T3Reg:Register163Bit port map(AccRegOut,Clock,Reset,T3RegLoad,T3RegOut);--T3 Register
  X3Reg:Register163Bit port map(AccRegOut,Clock,Reset,X3RegLoad,X3RegOut);--X3 Register
  Y3Reg:Register163Bit port map(AccRegOut,Clock,Reset,Y3RegLoad,Y3RegOut);--Y3 Register
  Z3Reg:Register163Bit port map(AccRegOut,Clock,Reset,Z3RegLoad,Z3RegOut);--Z3 Register
  
  PCReg:ProgramCounter port map(PCMuxOut,Clock,Reset,PCLoad,PCRegOut);--Program Counter Register
  IRReg:InstructionRegister port map(MemoryOut,Clock,Reset,IRLoad,IRRegOut);--Instruction Register
  --Registers--
    
  --Muxes used
  AccMux:Multiplexer32x1x163Bit port map(PxRegOut,PyRegOut,QzRegOut,QxRegOut,QyRegOut,T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut,AddOut,SqrOut,MulOut,IRRegOut(162 downto 0),Input,AndOut,OrOut,IncrementOut,DecrementOut,RShiftOut,LShiftOut,RRegOut,MemoryOut(162 downto 0),NotConnect,NotConnect,NotConnect,NotConnect,NotConnect,NotConnect,NotConnect,NotConnect,AccMuxSel,AccMuxOut);--Accumulator Input Mux
  
  AddMux:Multiplexer16x1x163Bit port map(PxRegOut,PyRegOut,QzRegOut,QxRegOut,QyRegOut,T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut,NotConnect,NotConnect,NotConnect,NotConnect,NotConnect,AddMuxSel,AddMuxOut);--Addition Input Mux
  SqrMux:Multiplexer16x1x163Bit port map(PxRegOut,PyRegOut,QzRegOut,QxRegOut,QyRegOut,T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut,NotConnect,NotConnect,NotConnect,NotConnect,NotConnect,SqrMuxSel,SqrMuxOut);--Squaring Input Mux  
  MulMux:Multiplexer16x1x163Bit port map(PxRegOut,PyRegOut,QzRegOut,QxRegOut,QyRegOut,T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut,NotConnect,NotConnect,NotConnect,NotConnect,NotConnect,MulMuxSel,MulMuxOut);--Mulitplication Input Mux
  
  MemMux:Multiplexer2x1x8Bit port map(PCRegOut,IRRegOut(162 downto 155),MemMuxSel,MemMuxOut);--Memory Mux
  PCMux:Multiplexer2x1x8Bit port map(Inc8Out,IRRegOut(162 downto 155),PCMuxSel,PCMuxOut);--Program Counter Mux
  
  --Operations
  Addition:Adding port map(AddMuxOut,AccRegOut,AddOut);--Addition
  Square:Squaring port map(Clock,Reset,StartSQR,SqrMuxOut,DoneSQR,SqrOut);--Squaring
  Multiplication:Multiplying port map (Clock,Reset,StartMul,MulMuxOut,AccRegOut,DoneMul,MulOut);--Multiplication
  
  AndAR         :Anding       port map (AccRegOut,RRegOut,AndOut);--Anding
  OrAR          :Oring        port map (AccRegOut,RRegOut,OrOut);--Oring
  Increment     :Incrementing port map (AccRegOut,IncrementOut);--Incrementing
  Decrement     :Decrementing port map (AccRegOut,DecrementOut);--Decrementing
  RightShiftA   :RightShift   port map (Clock,Reset,StartRShift,AccRegOut,RRegOut,RShiftOut,DoneRShift);--Right Shifting
  LeftShiftA    :LeftShift    port map (Clock,Reset,StartLShift,AccRegOut,RRegOut,LShiftOut,DoneLShift);--Left Shifting
  
  ZeroFl        :ZeroFlag     port map (AccRegOut,ZeroF);--ZeroFlag
  
  IncrementPC   :Increment8Bit  port map (PCRegOut,Inc8Out);--Incrementing PC
  --Arithmetic and Logic Unit--
   
   IR<=IRRegOut;
   Output<=AccRegOut;
end Operation;
----------------------------------------------------------------------
