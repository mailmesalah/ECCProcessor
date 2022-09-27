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
      
      Px,Py,Pz,Qx,Qy,k:in std_logic_vector(162 downto 0);
      
      AddMux1Sel,AddMux2Sel,SquareMuxSel,MulMux1Sel,MulMux2Sel:in std_logic_vector(3 downto 0);
      T1MuxSel,T2MuxSel,T3MuxSel,X3MuxSel,Y3MuxSel,Z3MuxSel:in std_logic_vector(1 downto 0);
      T1RegLoad,T2RegLoad,T3RegLoad,X3RegLoad,Y3RegLoad,Z3RegLoad:in std_logic;
      AddOutLoad,SqrOutLoad,MulOutLoad:in std_logic;
      
      AddOutput:out std_logic_vector(162 downto 0);
      SqrOutput:out std_logic_vector(162 downto 0);
      MulOutput:out std_logic_vector(162 downto 0)
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

component Multiplexer16x1x162Bit is
   port(
      a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p:in std_logic_vector(162 downto 0);
      s:in std_logic_vector(3 downto 0);
      Output:out std_logic_vector(162 downto 0)
      );
end component;

component Mux4x1x163 is
  port(
    a,b,c,d:in std_logic_vector(162 downto 0);
    s:in std_logic_vector(1 downto 0);
    Output:out std_logic_vector(162 downto 0));
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

signal AddOut,MulOut,SqrOut,T1MuxOut,T2MuxOut,T3MuxOut,X3MuxOut,Y3MuxOut,Z3MuxOut:std_logic_vector(162 downto 0);
signal T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut:std_logic_vector(162 downto 0);
signal AddOut,MulOut,SqrOut,T1MuxOut,T2MuxOut,T3MuxOut,X3MuxOut,Y3MuxOut,Z3MuxOut:std_logic_vector(162 downto 0);
signal AddMux1Out,AddMux2Out,SqrMuxOut,MulMux1Out,MulMux2Out:std_logic_vector(162 downto 0);

begin
  
  
  --Registers--   
  AddOut:Register163Bit port map(AddOut,Clock,Reset,AddOutLoad,AddOutput);--Point Addition Output
  MulOut:Register163Bit port map(MulOut,Clock,Reset,MulOutLoad,MulOutput);--Point Multiplication Output
  SqrOut:Register163Bit port map(SqrOut,Clock,Reset,SqrOutLoad,SqrOutput);--Point Doubling Output
  
  T1Reg:Register163Bit port map(T1MuxOut,Clock,Reset,T1RegLoad,T1RegOut);--T1 Register
  T2Reg:Register163Bit port map(T2MuxOut,Clock,Reset,T2RegLoad,T2RegOut);--T2 Register
  T3Reg:Register163Bit port map(T3MuxOut,Clock,Reset,T3RegLoad,T3RegOut);--T3 Register
  X3Reg:Register163Bit port map(X3MuxOut,Clock,Reset,X3RegLoad,X3RegOut);--X3 Register
  Y3Reg:Register163Bit port map(Y3MuxOut,Clock,Reset,Y3RegLoad,Y3RegOut);--Y3 Register
  Z3Reg:Register163Bit port map(Z3MuxOut,Clock,Reset,Z3RegLoad,Z3RegOut);--Z3 Register
  --Registers--
  
  --Arithmetic and Logic Unit--
  --Muxes used
  AddMux1:Mux16x1x162 port map(Px,Py,Pz,Qx,Qy,T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut,,,,,,AddMux1Sel,AddMux1Out);--Addition Input1 Mux
  AddMux2:Mux16x1x162 port map(Px,Py,Pz,Qx,Qy,T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut,,,,,,AddMux2Sel,AddMux2Out);--Addition Input2 Mux
  SqrMux :Mux16x1x162 port map(Px,Py,Pz,Qx,Qy,T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut,,,,,,SqrMuxSel,SqrMuxOut);--Squaring Input Mux  
  MulMux1:Mux16x1x162 port map(Px,Py,Pz,Qx,Qy,T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut,,,,,,MulMux1Sel,MulMux1Out);--Mulitplication Input1 Mux
  MulMux2:Mux16x1x162 port map(Px,Py,Pz,Qx,Qy,T1RegOut,T2RegOut,T3RegOut,X3RegOut,Y3RegOut,Z3RegOut,,,,,,MulMux2Sel,MulMux2Out);--Multiplication Input1 Mux
  
  T1Mux:Mux4x1x162 port map(AddOut,SqrOut,MulOut,,T1MuxSel,T1MuxOut);--T1 Input Mux
  T2Mux:Mux4x1x162 port map(AddOut,SqrOut,MulOut,,T2MuxSel,T2MuxOut);--T2 Input Mux
  T3Mux:Mux4x1x162 port map(AddOut,SqrOut,MulOut,,T3MuxSel,T3MuxOut);--T3 Input Mux
  X3Mux:Mux4x1x162 port map(AddOut,SqrOut,MulOut,,X3MuxSel,X3MuxOut);--X3 Input Mux
  Y3Mux:Mux4x1x162 port map(AddOut,SqrOut,MulOut,,Y3MuxSel,Y3MuxOut);--Y3 Input Mux
  Z3Mux:Mux4x1x162 port map(AddOut,SqrOut,MulOut,,Z3MuxSel,Z3MuxOut);--Z3 Input Mux
  
  --Operations
  Addition      :Adding       port map (AddMux1Out,AddMux2Out,AddOut);--Addition
  Square        :Squaring     port map (SqrMuxOut,SqrOut);--Squaring
  Multiplication:Multiplying  port map (MulMux1Out,MulMux2Out,MulOut);--Multiplication
  --Arithmetic and Logic Unit--
   
end Operation;
----------------------------------------------------------------------
