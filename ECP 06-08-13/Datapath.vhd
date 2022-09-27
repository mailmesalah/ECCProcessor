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
      
      AddMuxSel,SqrMuxSel,MulMuxSel,AccMuxSel:in std_logic_vector(3 downto 0);
      T1RegLoad,T2RegLoad,T3RegLoad,X3RegLoad,Y3RegLoad,Z3RegLoad:in std_logic;
      AddOutLoad,SqrOutLoad,MulOutLoad,MemEnable,MemRW,AccRegLoad,PxRegLoad,PyRegLoad,PzRegLoad:in std_logic;
      QxRegLoad,QyRegLoad,PCLoad,PCMuxSel,IRLoad,MemMuxSel:in std_logic;
      
      IR:out std_logic_vector(170 downto 0);
      Output:out std_logic_vector(162 downto 0)     
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
      Input : in  std_logic_vector(162 downto 0);
      Output: out std_logic_vector(162 downto 0)      
      );
end component;

component Adding is
  port(
      Input1: in std_logic_vector(162 downto 0);
      Input2: in std_logic_vector(162 downto 0);
      Output:out std_logic_vector(162 downto 0)
      );
end component;

component Multiplying is
  port(
      Input1: in std_logic_vector(162 downto 0);
      Input2: in std_logic_vector(162 downto 0);
      Output:out std_logic_vector(162 downto 0)
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

signal AddOut,MulOut,SqrOut,T1MuxOut,T2MuxOut,T3MuxOut,X3MuxOut,Y3MuxOut,Z3MuxOut,AccRegOut:std_logic_vector(162 downto 0);
signal T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut,PxRegOut,PyRegOut,PzRegOut,QxRegOut,QyRegOut:std_logic_vector(162 downto 0);
signal AddMuxOut,SqrMuxOut,MulMuxOut,AccMuxOut:std_logic_vector(162 downto 0);
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
  
  PxReg:Register163Bit port map(AccRegOut,Clock,Reset,PxRegLoad,PxRegOut);--Px Register
  PyReg:Register163Bit port map(AccRegOut,Clock,Reset,PyRegLoad,PyRegOut);--Py Register
  PzReg:Register163Bit port map(AccRegOut,Clock,Reset,PzRegLoad,PzRegOut);--Pz Register
  QxReg:Register163Bit port map(AccRegOut,Clock,Reset,QxRegLoad,QxRegOut);--Qx Register
  QyReg:Register163Bit port map(AccRegOut,Clock,Reset,QyRegLoad,QyRegOut);--Qy Register
  
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
  AccMux:Multiplexer16x1x163Bit port map(PxRegOut,PyRegOut,PzRegOut,QxRegOut,QyRegOut,T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut,AddOut,SqrOut,MulOut,MemoryOut(162 downto 0),Input,AccMuxSel,AccMuxOut);--Accumulator Input Mux
  
  AddMux:Multiplexer16x1x163Bit port map(PxRegOut,PyRegOut,PzRegOut,QxRegOut,QyRegOut,T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut,NotConnect,NotConnect,NotConnect,NotConnect,NotConnect,AddMuxSel,AddMuxOut);--Addition Input Mux
  SqrMux:Multiplexer16x1x163Bit port map(PxRegOut,PyRegOut,PzRegOut,QxRegOut,QyRegOut,T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut,NotConnect,NotConnect,NotConnect,NotConnect,NotConnect,SqrMuxSel,SqrMuxOut);--Squaring Input Mux  
  MulMux:Multiplexer16x1x163Bit port map(PxRegOut,PyRegOut,PzRegOut,QxRegOut,QyRegOut,T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut,NotConnect,NotConnect,NotConnect,NotConnect,NotConnect,MulMuxSel,MulMuxOut);--Mulitplication Input Mux
  
  MemMux:Multiplexer2x1x8Bit port map(PCRegOut,IRRegOut(162 downto 155),MemMuxSel,MemMuxOut);--Memory Mux
  PCMux :Multiplexer2x1x8Bit port map(Inc8Out,IRRegOut(162 downto 155),PCMuxSel,PCMuxOut);--Program Counter Mux
  
  --Operations
  Addition      :Adding       port map (AddMuxOut,AccRegOut,AddOut);--Addition
  Square        :Squaring     port map (SqrMuxOut,SqrOut);--Squaring
  Multiplication:Multiplying  port map (MulMuxOut,AccRegOut,MulOut);--Multiplication
  
  IncrementPC   :Increment8Bit  port map (PCRegOut,Inc8Out);--Incrementing PC
  --Arithmetic and Logic Unit--
   
   IR<=IRRegOut;
end Operation;
----------------------------------------------------------------------
