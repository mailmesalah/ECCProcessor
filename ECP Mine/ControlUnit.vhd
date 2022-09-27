----------------------------------------------------------------------
----------------------------------------------------------------------
--------------------------//Control Unit//----------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use IEEE.std_logic_textio.all;

entity ControlUnit is
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
end ControlUnit;
 
architecture Operation of ControlUnit is
 
begin

  process(Clock)
     
    variable state:std_logic_vector(7 downto 0):="00000000";
    variable decodeWait,fetchWait,WRWait,Halted:std_logic:='0';
    
  begin
    
    if(Reset='1' and Clock='1')then -- Reset State     
      state:="00000000";--NOP State or Start State
      
      Halted:='0';
      AccMuxSel<="11111"; 
      AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
      MemMuxSel<='0';PCMuxSel<='0';
      T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
      MemEnable<='0';MemRW<='0';AccRegLoad<='0';
      PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
      StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';                    
    elsif(clock='1')then 
      case state is
        when "00000000" =>--Start State  
            state:="00000001";--Next State(Fetch State)         

            --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            
        when "00000001" =>--Fetch State  
                                    
            --Disable         
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            if(fetchWait='0')then
               MemMuxSel<='0';PCMuxSel<='0';
               PCLoad<='1';
               MemEnable<='1';MemRW<='1';
               
               fetchWait:='1';    
            else               
               IRLoad<='1';
               
               fetchWait:='0';
               state:="00000010";--Next State         
            end if;
                        
        when "00000010" =>--Decode State
                    
            --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
        
            if(decodeWait='0')then               
               decodeWait:='1';
            else  
               decodeWait:='0';
               state:=IR(170 downto 163);--Next State            
            end if; 
        
        when "00000011" =>--IN Command  : Copy the input data to Accumulator
            state:="00000000";--Next State(Start State)         
            
            --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AccMuxSel<="01111";
            AccRegLoad<='1';
        
        when "00000100" =>--MVI Data Command : Data is Copied to Accumulator 
            state:="00000000";--Next State(Start State)         
            --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AccMuxSel<="01110";
            AccRegLoad<='1';
        
        when "00000101" =>--Mov A,T1 Command : T1 is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable  
            AccMuxSel<="00101";      
            AccRegLoad<='1';
            
        when "00000110" =>--Mov A,T2 Command : T2 is copied to A  
            state:="00000000";--Next State(Start State)         
        
	         AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable  
            AccMuxSel<="00110";      
            AccRegLoad<='1';
            
        when "00000111" =>--Mov A,T3 Command : T3 is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable  
            AccMuxSel<="00111";      
            AccRegLoad<='1';
            
        when "00001000" =>--Mov A,X3 Command : X3 is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable  
            AccMuxSel<="01000";      
            AccRegLoad<='1';
            
        when "00001001" =>--Mov A,Y3 Command : Y3 is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable  
            AccMuxSel<="01001";      
            AccRegLoad<='1';
            
        when "00001010" =>--Mov A,Z3 Command : Z3 is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable  
            AccMuxSel<="01010";      
            AccRegLoad<='1';
        
        when "00001011" =>--Mov A,Px Command : Px is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable  
            AccMuxSel<="00000";      
            AccRegLoad<='1';
            
        when "00001100" =>--Mov A,Py Command : Py is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable  
            AccMuxSel<="00001";      
            AccRegLoad<='1';
            
        when "00001101" =>--Mov A,Qz Command : Qz is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable  
            AccMuxSel<="00010";      
            AccRegLoad<='1';
            
        when "00001110" =>--Mov A,Qx Command : Qx is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable  
            AccMuxSel<="00011";      
            AccRegLoad<='1';
            
        when "00001111" =>--Mov A,Qy Command : Qy is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable  
            AccMuxSel<="00100";      
            AccRegLoad<='1';
        
        when "00010000" =>--Mov Px Command : A is copied to Px  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable            
            PxRegLoad<='1';
        
        when "00010001" =>--Mov Py Command : A is copied to Py  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable            
            PyRegLoad<='1';
        
        when "00010010" =>--Mov Qz Command : A is copied to Qz  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable            
            QzRegLoad<='1';
        
        when "00010011" =>--Mov Qx Command : A is copied to Qx  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable            
            QxRegLoad<='1';
        
        when "00010100" =>--Mov Qy Command : A is copied to Qy  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable            
            QyRegLoad<='1';
        
        when "00010101" =>--Mov T1 Command : A is copied to T1  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable            
            T1RegLoad<='1';
        
        when "00010110" =>--Mov T2 Command : A is copied to T2  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable            
            T2RegLoad<='1';
        
        when "00010111" =>--Mov T3 Command : A is copied to T3  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable            
            T3RegLoad<='1';
        
        when "00011000" =>--Mov X3 Command : A is copied to X3  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable            
            X3RegLoad<='1';
        
        when "00011001" =>--Mov Y3 Command : A is copied to Y3  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable            
            Y3RegLoad<='1';
        
        when "00011010" =>--Mov Z3 Command : A is copied to Z3  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable            
            Z3RegLoad<='1';
        
        when "00011011" =>--Add T1 Command : Add Accumulator and T1 and Store the value in Accumulator  
            state:="00011100";--Next State         
        
            --Adding Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="0101";                            
            
        when "00011100" =>--Add T1 Command : Add Accumulator and T1 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="0101";AccMuxSel<="01011";                
            AccRegLoad<='1';
        
        when "00011101" =>--Add T2 Command : Add Accumulator and T2 and Store the value in Accumulator  
            state:="00011110";--Next State         
        
            --Adding Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="0110";                            
            
        when "00011110" =>--Add T2 Command : Add Accumulator and T2 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="0110";AccMuxSel<="01011";                
            AccRegLoad<='1';
            
        
        when "00011111" =>--Add T3 Command : Add Accumulator and T3 and Store the value in Accumulator  
            state:="00100000";--Next State         
        
            --Adding Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="0111";                            
            
        when "00100000" =>--Add T3 Command : Add Accumulator and T3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="0111";AccMuxSel<="01011";                
            AccRegLoad<='1';
            
        
        when "00100001" =>--Add X3 Command : Add Accumulator and X3 and Store the value in Accumulator  
            state:="00100010";--Next State         
        
            --Adding Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="1000";                            
            
        when "00100010" =>--Add X3 Command : Add Accumulator and X3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="1000";AccMuxSel<="01011";                
            AccRegLoad<='1';
            
        
        when "00100011" =>--Add Y3 Command : Add Accumulator and Y3 and Store the value in Accumulator  
            state:="00100100";--Next State         
        
            --Adding Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="1001";                            
            
        when "00100100" =>--Add Y3 Command : Add Accumulator and Y3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="1001";AccMuxSel<="01011";                
            AccRegLoad<='1';
            
        
        when "00100101" =>--Add Z3 Command : Add Accumulator and Z3 and Store the value in Accumulator  
            state:="00100110";--Next State         
        
            --Adding Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="1010";                            
            
        when "00100110" =>--Add Z3 Command : Add Accumulator and Z3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="1010";AccMuxSel<="01011";                
            AccRegLoad<='1';
            
        
        when "00100111" =>--Add Px Command : Add Accumulator and Px and Store the value in Accumulator  
            state:="00101000";--Next State         
        
            --Adding Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="0000";                            
            
        when "00101000" =>--Add Px Command : Add Accumulator and Px and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="0000";AccMuxSel<="01011";                
            AccRegLoad<='1';
            
        
        when "00101001" =>--Add Py Command : Add Accumulator and Py and Store the value in Accumulator  
            state:="00101010";--Next State         
        
            --Adding Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="0001";                            
            
        when "00101010" =>--Add Py Command : Add Accumulator and Py and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="0001";AccMuxSel<="01011";                
            AccRegLoad<='1';
            
        
        when "00101011" =>--Add Qz Command : Add Accumulator and Qz and Store the value in Accumulator  
            state:="00101100";--Next State         
        
            --Adding Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="0010";                            
            
        when "00101100" =>--Add Qz Command : Add Accumulator and Qz and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="0010";AccMuxSel<="01011";                
            AccRegLoad<='1';
            
        
        when "00101101" =>--Add Qx Command : Add Accumulator and Qx and Store the value in Accumulator  
            state:="00101110";--Next State         
        
            --Adding Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="0011";                            
            
        when "00101110" =>--Add Qx Command : Add Accumulator and Qx and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="0011";AccMuxSel<="01011";                
            AccRegLoad<='1';
            
        
        when "00101111" =>--Add Qy Command : Add Accumulator and Qy and Store the value in Accumulator  
            state:="00110000";--Next State         
        
            --Adding Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="0100";                            
            
        when "00110000" =>--Add Qy Command : Add Accumulator and Qy and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AddMuxSel<="0100";AccMuxSel<="01011";                
            AccRegLoad<='1';
            
        when "00110001" =>--Sqr T1 Command : Squaring T1 and Store the value in Accumulator  
                    
            --Squaring Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            
            if(DoneSQR='1')then
               StartSQR<='0';
               state:="00110010";--Next State         
            else
               SqrMuxSel<="0101";
               StartSQR<='1';               
            end if;
                                        
            
        when "00110010" =>--Sqr T1 Command : Squaring T1 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            SqrMuxSel<="0101";AccMuxSel<="01100";                
            AccRegLoad<='1';
        
        when "00110011" =>--Sqr T2 Command : Squaring T2 and Store the value in Accumulator  
                    
            --Squaring Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
                
            if(DoneSQR='1')then
               StartSQR<='0';
               state:="00110100";--Next State         
            else
               SqrMuxSel<="0110";                        
               StartSQR<='1';               
            end if;
            
        when "00110100" =>--Sqr T2 Command : Squaring T2 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            SqrMuxSel<="0110";AccMuxSel<="01100";                
            AccRegLoad<='1';
            
        
        when "00110101" =>--Sqr T3 Command : Squaring T3 and Store the value in Accumulator              
        
            --Squaring Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
                                       
            if(DoneSQR='1')then
               StartSQR<='0';
               state:="00110110";--Next State         
            else
               SqrMuxSel<="0111"; 
               StartSQR<='1';               
            end if;
            
        when "00110110" =>--Sqr T3 Command : Squaring T3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            SqrMuxSel<="0111";AccMuxSel<="01100";                
            AccRegLoad<='1';
            
        
        when "00110111" =>--Sqr X3 Command : Squaring X3 and Store the value in Accumulator  
                    
            --Squaring Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            
            if(DoneSQR='1')then
               StartSQR<='0';
               state:="00111000";--Next State         
            else
               SqrMuxSel<="1000";                            
               StartSQR<='1';               
            end if;
            
        when "00111000" =>--Sqr X3 Command : Squaring X3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            SqrMuxSel<="1000";AccMuxSel<="01100";                
            AccRegLoad<='1';
            
        
        when "00111001" =>--Sqr Y3 Command : Squaring Y3 and Store the value in Accumulator  
                    
            --Squaring Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
                                        
            if(DoneSQR='1')then
               StartSQR<='0';
               state:="00111010";--Next State         
            else
               SqrMuxSel<="1001";
               StartSQR<='1';               
            end if;
            
        when "00111010" =>--Sqr Y3 Command : Squaring Y3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            SqrMuxSel<="1001";AccMuxSel<="01100";                
            AccRegLoad<='1';
            
        
        when "00111011" =>--Sqr Z3 Command : Squaring Z3 and Store the value in Accumulator  
                    
            --Squaring Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
                                        
            if(DoneSQR='1')then
               StartSQR<='0';
               state:="00111100";--Next State         
            else
               SqrMuxSel<="1010";
               StartSQR<='1';               
            end if;
            
        when "00111100" =>--Sqr Z3 Command : Squaring Z3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            SqrMuxSel<="1010";AccMuxSel<="01100";                
            AccRegLoad<='1';
            
        
        when "00111101" =>--Sqr Px Command : Squaring Px and Store the value in Accumulator  
                             
            --Squaring Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
                                        
            if(DoneSQR='1')then
               StartSQR<='0';
               state:="00111110";--Next State
            else
               SqrMuxSel<="0000";
               StartSQR<='1';               
            end if;
            
        when "00111110" =>--Sqr Px Command : Squaring Px and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            SqrMuxSel<="0000";AccMuxSel<="01100";                
            AccRegLoad<='1';
            
        
        when "00111111" =>--Sqr Py Command : Squaring Py and Store the value in Accumulator  
                             
            --Squaring Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
                                        
            if(DoneSQR='1')then
               StartSQR<='0';
               state:="01000000";--Next State
            else
               SqrMuxSel<="0001";
               StartSQR<='1';               
            end if;
            
        when "01000000" =>--Sqr Py Command : Squaring Py and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            SqrMuxSel<="0001";AccMuxSel<="01100";                
            AccRegLoad<='1';
            
        
        when "01000001" =>--Sqr Qz Command : Squaring Qz and Store the value in Accumulator  
                    
            --Squaring Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            
            if(DoneSQR='1')then
               StartSQR<='0';
               state:="01000010";--Next State         
            else
               SqrMuxSel<="0010"; 
               StartSQR<='1';               
            end if;                           
            
        when "01000010" =>--Sqr Qz Command : Squaring Qz and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            SqrMuxSel<="0010";AccMuxSel<="01100";                
            AccRegLoad<='1';
            
        
        when "01000011" =>--Sqr Qx Command : Squaring Qx and Store the value in Accumulator  
                      
            --Squaring Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
                                        
            if(DoneSQR='1')then
               StartSQR<='0';
               state:="01000100";--Next State       
            else
               SqrMuxSel<="0011";
               StartSQR<='1';               
            end if;
            
        when "01000100" =>--Sqr Qx Command : Squaring Qx and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            SqrMuxSel<="0011";AccMuxSel<="01100";                
            AccRegLoad<='1';
            
        
        when "01000101" =>--Sqr Qy Command : Squaring Qy and Store the value in Accumulator  
                             
            --Squaring Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable             
            if(DoneSQR='1')then
               StartSQR<='0';
               state:="01000110";--Next State
            else
               SqrMuxSel<="0100";
               StartSQR<='1';               
            end if;                            
            
        when "01000110" =>--Sqr Qy Command : Squaring Qy and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            SqrMuxSel<="0100";AccMuxSel<="01100";                
            AccRegLoad<='1';
            
        when "01000111" =>--Mul T1 Command : Multiply Accumulator and T1 and Store the value in Accumulator              
                          
            --Multiplying Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            if(DoneMul='1')then
               StartMul<='0';
               state:="01001000";--Next State        
            else
               MulMuxSel<="0101";
               StartMul<='1';
               state:="01000111";--Next State(Same State)         
            end if;                                        
            
        when "01001000" =>--Mul T1 Command : Multiply Accumulator and T1 and Store the value in Accumulator              
            state:="00000000";--Next State(Start State)         
            
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AccMuxSel<="01101";                
            AccRegLoad<='1';
        
        when "01001001" =>--Mul T2 Command : Multiply Accumulator and T2 and Store the value in Accumulator    
            --Multiplying Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            if(DoneMul='1')then
               StartMul<='0';
               state:="01001010";--Next State        
            else
               MulMuxSel<="0110";                            
               StartMul<='1';
               state:="01001001";--Next State(Same State)         
            end if;            
            
        when "01001010" =>--Mul T2 Command : Multiply Accumulator and T2 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AccMuxSel<="01101";                
            AccRegLoad<='1';
            
        
        when "01001011" =>--Mul T3 Command : Multiply Accumulator and T3 and Store the value in Accumulator  
            
            --Multiplying Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            if(DoneMul='1')then
               StartMul<='0';
               state:="01001100";--Next State        
            else
               MulMuxSel<="0111";                            
               StartMul<='1';
               state:="01001011";--Next State(Same State)         
            end if;
            
        when "01001100" =>--Mul T3 Command : Multiply Accumulator and T3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AccMuxSel<="01101";                
            AccRegLoad<='1';
            
        
        when "01001101" =>--Mul X3 Command : Multiply Accumulator and X3 and Store the value in Accumulator  
            
            --Multiplying Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            if(DoneMul='1')then
               StartMul<='0';
               state:="01001110";--Next State        
            else
               MulMuxSel<="1000";                            
               StartMul<='1';
               state:="01001101";--Next State(Same State)         
            end if;
            
        when "01001110" =>--Mul X3 Command : Multiply Accumulator and X3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AccMuxSel<="01101";                
            AccRegLoad<='1';
            
        
        when "01001111" =>--Mul Y3 Command : Multiply Accumulator and Y3 and Store the value in Accumulator  
            
            --Multiplying Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            if(DoneMul='1')then
               StartMul<='0';
               state:="01010000";--Next State        
            else
               MulMuxSel<="1001";                            
               StartMul<='1';
               state:="01001111";--Next State(Same State)         
            end if;
            
        when "01010000" =>--Mul Y3 Command : Multiply Accumulator and Y3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AccMuxSel<="01101";                
            AccRegLoad<='1';
            
        
        when "01010001" =>--Mul Z3 Command : Multiply Accumulator and Z3 and Store the value in Accumulator  
            
            --Multiplying Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            if(DoneMul='1')then
               StartMul<='0';
               state:="01010010";--Next State        
            else
               MulMuxSel<="1010";                            
               StartMul<='1';
               state:="01010001";--Next State(Same State)         
            end if;
            
        when "01010010" =>--Mul Z3 Command : Multiply Accumulator and Z3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AccMuxSel<="01101";                
            AccRegLoad<='1';
            
        
        when "01010011" =>--Mul Px Command : Multiply Accumulator and Px and Store the value in Accumulator  
            
            --Multiplying Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            if(DoneMul='1')then
               StartMul<='0';
               state:="01010100";--Next State        
            else
               MulMuxSel<="0000";                            
               StartMul<='1';
               state:="01010011";--Next State(Same State)         
            end if;
            
        when "01010100" =>--Mul Px Command : Multiply Accumulator and Px and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AccMuxSel<="01101";                
            AccRegLoad<='1';
            
        
        when "01010101" =>--Mul Py Command : Multiply Accumulator and Py and Store the value in Accumulator  
            
            --Multiplying Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            if(DoneMul='1')then
               StartMul<='0';
               state:="01010110";--Next State        
            else
               MulMuxSel<="0001";                            
               StartMul<='1';
               state:="01010101";--Next State(Same State)         
            end if;
            
        when "01010110" =>--Mul Py Command : Multiply Accumulator and Py and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AccMuxSel<="01101";                
            AccRegLoad<='1';
            
        
        when "01010111" =>--Mul Qz Command : Multiply Accumulator and Qz and Store the value in Accumulator  
            
            --Multiplying Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            if(DoneMul='1')then
               StartMul<='0';
               state:="01011000";--Next State        
            else
               MulMuxSel<="0010";                            
               StartMul<='1';
               state:="01010111";--Next State(Same State)         
            end if;
            
        when "01011000" =>--Mul Qz Command : Multiply Accumulator and Qz and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AccMuxSel<="01101";                
            AccRegLoad<='1';
            
        
        when "01011001" =>--Mul Qx Command : Multiply Accumulator and Qx and Store the value in Accumulator  
            
            --Multiplying Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            if(DoneMul='1')then
               StartMul<='0';
               state:="01011010";--Next State        
            else
               MulMuxSel<="0011";                            
               StartMul<='1';
               state:="01011001";--Next State(Same State)         
            end if;
            
        when "01011010" =>--Mul Qx Command : Multiply Accumulator and Qx and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AccMuxSel<="01101";                
            AccRegLoad<='1';
            
        
        when "01011011" =>--Mul Qy Command : Multiply Accumulator and Qy and Store the value in Accumulator  
            
            --Multiplying Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            if(DoneMul='1')then
               StartMul<='0';
               state:="01011100";--Next State        
            else
               MulMuxSel<="0100";                            
               StartMul<='1';
               state:="01011011";--Next State(Same State)         
            end if;
            
        when "01011100" =>--Mul Qy Command : Multiply Accumulator and Qy and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AccMuxSel<="01101";                
            AccRegLoad<='1';
                
        when "01011101" =>--RD Address Command : Reads Data to Accumulator from memory at Specified Address in the instruction
            state:="01011110";--Next State         
        
            --Reading Data From Memory Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            MemMuxSel<='1';                            
            MemEnable<='1';MemRW<='1';
            
        when "01011110" =>--RD Address Command : Reads Data to Accumulator from memory at Specified Address in the instruction
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable            
            AccMuxSel<="10111";                
            AccRegLoad<='1';
        
        when "01011111" =>--WR Address Command : Writes Data from Accumulator to memory at Specified Address in the instruction
            
            --Writing Data to Memory
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            
            if(WRWait='0')then
               WRWait:='1';
               state:="01011111";--Next State         
               
               MemMuxSel<='1';                            
               MemEnable<='1';MemRW<='0';
            else
               WRWait:='0';
               state:="00000000";--Next State
               
               MemMuxSel<='1';         
            end if;
            
            
        when "01100000" =>--And R Command : And Accumulator with Register R
            state:="00000000";--Next State         
        
            --Anding A with R
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AccRegLoad<='1';
            AccMuxSel<="10000";
        
        when "01100001" =>--Or R Command : And Accumulator with Register R
            state:="00000000";--Next State         
        
            --Oring A with R
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AccRegLoad<='1';
            AccMuxSel<="10001";
        
        when "01100010" =>--Inc Command : And Accumulator with Register R
            state:="00000000";--Next State         
        
            --Incrementing A 
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AccRegLoad<='1';
            AccMuxSel<="10010";
        
        when "01100011" =>--Dec Command : And Accumulator with Register R
            state:="00000000";--Next State         
        
            --Decrementing A 
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            AccRegLoad<='1';
            AccMuxSel<="10011";
            
        when "01100100" =>--RShift R Command : Right Shift Accumulator with Register R
                    
            --Right Shifting A with R
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            if(DoneRShift='1')then
               state:="00000000";--Next State         
               StartRShift<='0';
               AccRegLoad<='1';
               AccMuxSel<="10100";
            else
               state:="01100100";--Next State         
               StartRShift<='1';               
            end if;
            
        when "01100101" =>--LShift R Command : Left Shift Accumulator with Register R
        
            --Left Shifting A with R
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
            if(DoneLShift='1')then
               state:="00000000";--Next State         
               StartLShift<='0';
               AccRegLoad<='1';
               AccMuxSel<="10101";
            else
               state:="01100101";--Next State         
               StartLShift<='1';               
            end if;
        
        when "01100110" =>--Mov A,R Command : R is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable  
            AccMuxSel<="10110";      
            AccRegLoad<='1';
        
        when "01100111" =>--Mov R,A Command : A is copied to R  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable              
            RRegLoad<='1';
                    
        when "01101000" =>--JMP Address Command : Jump execution to the specified   
            state:="01101001";--Next State(Start State)         
            --1st Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable                                       
            PCMuxSel<='1';
            PCLoad<='1';
        
        when "01101001" =>--JMP Address Command : Jump execution to the specified address  
            state:="00000000";--Next State(Start State)         
            --2nd Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable                                       
            PCMuxSel<='1';            
            MemMuxSel<='0';
            MemEnable<='1';MemRW<='1';
            
        when "01101010" =>--JZ Address Command : Jump execution to the specified address if Accumulator is Zero
            --1st Part                 
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable      
            if(ZeroF='1')then
              state:="01101011";--Next State
                                               
              PCMuxSel<='1';
              PCLoad<='1';
            else
              state:="00000000";--Next State(Start State)         
            end if;
        
        when "01101011" =>--JZ Address Command : Jump execution to the specified address if Accumulator is Zero  
            state:="00000000";--Next State(Start State)         
            --2nd Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable                                       
            PCMuxSel<='1';            
            MemMuxSel<='0';
            MemEnable<='1';MemRW<='1';    
            
        when "01101100" =>--JNZ Address Command : Jump execution to the specified address if accumulator is not Zero   
            --1st Part                 
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable      
            if(ZeroF='0')then
              state:="01101101";--Next State(Start State)
                                               
              PCMuxSel<='1';
              PCLoad<='1';
            else
              state:="00000000";--Next State(Start State)         
            end if;
        
        when "01101101" =>--JNZ Address Command : Jump execution to the specified address if accumulator is not Zero
            state:="00000000";--Next State(Start State)         
            --2nd Part
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable                                       
            PCMuxSel<='1';            
            MemMuxSel<='0';
            MemEnable<='1';MemRW<='1';    
                        
        when "01101110" =>--Hlt Command : Halts the execution of Processor
            state:="01101110";--Next State(Hlt State)         
        
            Halted:='1';
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            --Enable
        
        when "UUUUUUUU" =>
            if(Halted='1')then
              state:="01101110";--Next State(Halt State)         
            else
              state:="00000000";--Next State(Start State)         
            end if;
        
	          --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            
        when others     =>-- When not in any state
            state:="01101110";--Go to Halt State
            
            --Disable                 
            AccMuxSel<="11111"; 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";     
            MemMuxSel<='0';PCMuxSel<='0';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            StartMul<='0';StartLShift<='0';StartRShift<='0';RRegLoad<='0';
            
        end case;
    end if;
  end Process;

 
end Operation;

----------------------------------------------------------------------
