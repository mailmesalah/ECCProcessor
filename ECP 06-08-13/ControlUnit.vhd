----------------------------------------------------------------------
----------------------------------------------------------------------
--------------------------//Control Unit//----------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;

entity ControlUnit is
  port(              
      Clock:in std_logic;
      Reset:in std_logic;
      
      AddMuxSel,SqrMuxSel,MulMuxSel,AccMuxSel:out std_logic_vector(3 downto 0);
      T1RegLoad,T2RegLoad,T3RegLoad,X3RegLoad,Y3RegLoad,Z3RegLoad:out std_logic;
      AddOutLoad,SqrOutLoad,MulOutLoad,MemEnable,MemRW,AccRegLoad,PxRegLoad,PyRegLoad,PzRegLoad:out std_logic;
      QxRegLoad,QyRegLoad,PCLoad,PCMuxSel,IRLoad,MemMuxSel:out std_logic;

      IR:in std_logic_vector(170 downto 0)
      );
end ControlUnit;
 
architecture Operation of ControlUnit is
 
begin

  process(Clock)
     
    variable state:std_logic_vector(7 downto 0):="00000000";
     
  begin
    
    if(Reset='1' and Clock='1')then -- Reset State     
      state:="00000000";--NOP State or Start State
      
      AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
      MemMuxSel<='1';PCMuxSel<='1';
      T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
      AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
      PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
                          
    elsif(clock='1')then 
      case state is
        when "00000000" =>--Start State  
            state:="00000001";--Next State(Fetch State)         
            
            --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            
        when "00000001" =>--Fetch State  
            state:="00000010";--Next State         
            
            --Disable         
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';
            --Enable
            MemMuxSel<='0';PCMuxSel<='0';
            PCLoad<='1';IRLoad<='1';
            MemEnable<='1';MemRW<='1';
            
        when "00000010" =>--Decode State  
            state:=IR(170 downto 163);--Next State         
            
            --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            
        when "00000011" =>--IN Command  : Copy the input data to Accumulator
            state:="00000000";--Next State(Start State)         
            
            --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AccMuxSel<="1111";
            AccRegLoad<='1';
        
        when "00000100" =>--MVI Data Command : Data is Copied to Accumulator 
            state:="00000000";--Next State(Start State)         
            --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AccMuxSel<="1110";
            AccRegLoad<='1';
        
        when "00000101" =>--Mov A,T1 Command : T1 is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable  
            AccMuxSel<="0101";      
            AccRegLoad<='1';
            
        when "00000110" =>--Mov A,T2 Command : T2 is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable  
            AccMuxSel<="0110";      
            AccRegLoad<='1';
            
        when "00000111" =>--Mov A,T3 Command : T3 is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable  
            AccMuxSel<="0111";      
            AccRegLoad<='1';
            
        when "00001000" =>--Mov A,X3 Command : X3 is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable  
            AccMuxSel<="1000";      
            AccRegLoad<='1';
            
        when "00001001" =>--Mov A,Y3 Command : Y3 is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable  
            AccMuxSel<="1001";      
            AccRegLoad<='1';
            
        when "00001010" =>--Mov A,Z3 Command : Z3 is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable  
            AccMuxSel<="1010";      
            AccRegLoad<='1';
        
        when "00001011" =>--Mov A,Px Command : Px is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable  
            AccMuxSel<="0000";      
            AccRegLoad<='1';
            
        when "00001100" =>--Mov A,Py Command : Py is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable  
            AccMuxSel<="0001";      
            AccRegLoad<='1';
            
        when "00001101" =>--Mov A,Pz Command : Pz is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable  
            AccMuxSel<="0010";      
            AccRegLoad<='1';
            
        when "00001110" =>--Mov A,Qx Command : Qx is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable  
            AccMuxSel<="0011";      
            AccRegLoad<='1';
            
        when "00001111" =>--Mov A,Qy Command : Qy is copied to A  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable  
            AccMuxSel<="0100";      
            AccRegLoad<='1';
        
        when "00010000" =>--Mov Px Command : A is copied to Px  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable            
            PxRegLoad<='1';
        
        when "00010001" =>--Mov Py Command : A is copied to Py  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable            
            PyRegLoad<='1';
        
        when "00010010" =>--Mov Pz Command : A is copied to Pz  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable            
            PzRegLoad<='1';
        
        when "00010011" =>--Mov Qx Command : A is copied to Qx  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PyRegLoad<='0';PzRegLoad<='0';PxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable            
            QxRegLoad<='1';
        
        when "00010100" =>--Mov Qy Command : A is copied to Qy  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';PxRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable            
            QyRegLoad<='1';
        
        when "00010101" =>--Mov T1 Command : A is copied to T1  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            PxRegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable            
            T1RegLoad<='1';
        
        when "00010110" =>--Mov T2 Command : A is copied to T2  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';PxRegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable            
            T2RegLoad<='1';
        
        when "00010111" =>--Mov T3 Command : A is copied to T3  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";            
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';PxRegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable            
            T3RegLoad<='1';
        
        when "00011000" =>--Mov X3 Command : A is copied to X3  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';PxRegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable            
            X3RegLoad<='1';
        
        when "00011001" =>--Mov Y3 Command : A is copied to Y3  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';PxRegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable            
            Y3RegLoad<='1';
        
        when "00011010" =>--Mov Z3 Command : A is copied to Z3  
            state:="00000000";--Next State(Start State)         
        
	          --Disable                 
            AddMuxSel<="1111";SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";                  
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';PxRegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable            
            Z3RegLoad<='1';
        
        when "00011011" =>--Add T1 Command : Add Accumulator and T1 and Store the value in Accumulator  
            state:="00011100";--Next State         
        
            --Adding Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="0101";                            
            
        when "00011100" =>--Add T1 Command : Add Accumulator and T1 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="0101";AccMuxSel<="1011";                
            AccRegLoad<='1';
        
        when "00011101" =>--Add T2 Command : Add Accumulator and T2 and Store the value in Accumulator  
            state:="00011110";--Next State         
        
            --Adding Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="0110";                            
            
        when "00011110" =>--Add T2 Command : Add Accumulator and T2 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="0110";AccMuxSel<="1011";                
            AccRegLoad<='1';
            
        
        when "00011111" =>--Add T3 Command : Add Accumulator and T3 and Store the value in Accumulator  
            state:="00100000";--Next State         
        
            --Adding Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="0111";                            
            
        when "00100000" =>--Add T3 Command : Add Accumulator and T3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="0111";AccMuxSel<="1011";                
            AccRegLoad<='1';
            
        
        when "00100001" =>--Add X3 Command : Add Accumulator and X3 and Store the value in Accumulator  
            state:="00100010";--Next State         
        
            --Adding Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="1000";                            
            
        when "00100010" =>--Add X3 Command : Add Accumulator and X3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="1000";AccMuxSel<="1011";                
            AccRegLoad<='1';
            
        
        when "00100011" =>--Add Y3 Command : Add Accumulator and Y3 and Store the value in Accumulator  
            state:="00100100";--Next State         
        
            --Adding Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="1001";                            
            
        when "00100100" =>--Add Y3 Command : Add Accumulator and Y3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="1001";AccMuxSel<="1011";                
            AccRegLoad<='1';
            
        
        when "00100101" =>--Add Z3 Command : Add Accumulator and Z3 and Store the value in Accumulator  
            state:="00100110";--Next State         
        
            --Adding Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="1010";                            
            
        when "00100110" =>--Add Z3 Command : Add Accumulator and Z3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="1010";AccMuxSel<="1011";                
            AccRegLoad<='1';
            
        
        when "00100111" =>--Add Px Command : Add Accumulator and Px and Store the value in Accumulator  
            state:="00101000";--Next State         
        
            --Adding Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="0000";                            
            
        when "00101000" =>--Add Px Command : Add Accumulator and Px and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="0000";AccMuxSel<="1011";                
            AccRegLoad<='1';
            
        
        when "00101001" =>--Add Py Command : Add Accumulator and Py and Store the value in Accumulator  
            state:="00101010";--Next State         
        
            --Adding Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="0001";                            
            
        when "00101010" =>--Add Py Command : Add Accumulator and Py and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="0001";AccMuxSel<="1011";                
            AccRegLoad<='1';
            
        
        when "00101011" =>--Add Pz Command : Add Accumulator and Pz and Store the value in Accumulator  
            state:="00101100";--Next State         
        
            --Adding Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="0010";                            
            
        when "00101100" =>--Add Pz Command : Add Accumulator and Pz and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="0010";AccMuxSel<="1011";                
            AccRegLoad<='1';
            
        
        when "00101101" =>--Add Qx Command : Add Accumulator and Qx and Store the value in Accumulator  
            state:="00101110";--Next State         
        
            --Adding Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="0011";                            
            
        when "00101110" =>--Add Qx Command : Add Accumulator and Qx and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="0011";AccMuxSel<="1011";                
            AccRegLoad<='1';
            
        
        when "00101111" =>--Add Qy Command : Add Accumulator and Qy and Store the value in Accumulator  
            state:="00110000";--Next State         
        
            --Adding Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="0100";                            
            
        when "00110000" =>--Add Qy Command : Add Accumulator and Qy and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AddMuxSel<="0100";AccMuxSel<="1011";                
            AccRegLoad<='1';
            
        when "00110001" =>--Sqr T1 Command : Squaring T1 and Store the value in Accumulator  
            state:="00110010";--Next State         
        
            --Squaring Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="0101";                            
            
        when "00110010" =>--Sqr T1 Command : Squaring T1 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="0101";AccMuxSel<="1100";                
            AccRegLoad<='1';
        
        when "00110011" =>--Sqr T2 Command : Squaring T2 and Store the value in Accumulator  
            state:="00110100";--Next State         
        
            --Squaring Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="0110";                            
            
        when "00110100" =>--Sqr T2 Command : Squaring T2 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="0110";AccMuxSel<="1100";                
            AccRegLoad<='1';
            
        
        when "00110101" =>--Sqr T3 Command : Squaring T3 and Store the value in Accumulator  
            state:="00110110";--Next State         
        
            --Squaring Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="0111";                            
            
        when "00110110" =>--Sqr T3 Command : Squaring T3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="0111";AccMuxSel<="1100";                
            AccRegLoad<='1';
            
        
        when "00110111" =>--Sqr X3 Command : Squaring X3 and Store the value in Accumulator  
            state:="00111000";--Next State         
        
            --Squaring Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="1000";                            
            
        when "00111000" =>--Sqr X3 Command : Squaring X3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="1000";AccMuxSel<="1100";                
            AccRegLoad<='1';
            
        
        when "00111001" =>--Sqr Y3 Command : Squaring Y3 and Store the value in Accumulator  
            state:="00111010";--Next State         
        
            --Squaring Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="1001";                            
            
        when "00111010" =>--Sqr Y3 Command : Squaring Y3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="1001";AccMuxSel<="1100";                
            AccRegLoad<='1';
            
        
        when "00111011" =>--Sqr Z3 Command : Squaring Z3 and Store the value in Accumulator  
            state:="00111100";--Next State         
        
            --Squaring Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="1010";                            
            
        when "00111100" =>--Sqr Z3 Command : Squaring Z3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="1010";AccMuxSel<="1100";                
            AccRegLoad<='1';
            
        
        when "00111101" =>--Sqr Px Command : Squaring Px and Store the value in Accumulator  
            state:="00111110";--Next State         
        
            --Squaring Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="0000";                            
            
        when "00111110" =>--Sqr Px Command : Squaring Px and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="0000";AccMuxSel<="1100";                
            AccRegLoad<='1';
            
        
        when "00111111" =>--Sqr Py Command : Squaring Py and Store the value in Accumulator  
            state:="01000000";--Next State         
        
            --Squaring Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="0001";                            
            
        when "01000000" =>--Sqr Py Command : Squaring Py and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="0001";AccMuxSel<="1100";                
            AccRegLoad<='1';
            
        
        when "01000001" =>--Sqr Pz Command : Squaring Pz and Store the value in Accumulator  
            state:="01000010";--Next State         
        
            --Squaring Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="0010";                            
            
        when "01000010" =>--Sqr Pz Command : Squaring Pz and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="0010";AccMuxSel<="1100";                
            AccRegLoad<='1';
            
        
        when "01000011" =>--Sqr Qx Command : Squaring Qx and Store the value in Accumulator  
            state:="01000100";--Next State         
        
            --Squaring Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="0011";                            
            
        when "01000100" =>--Sqr Qx Command : Squaring Qx and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="0011";AccMuxSel<="1100";                
            AccRegLoad<='1';
            
        
        when "01000101" =>--Sqr Qy Command : Squaring Qy and Store the value in Accumulator  
            state:="01000110";--Next State         
        
            --Squaring Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="0100";                            
            
        when "01000110" =>--Sqr Qy Command : Squaring Qy and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            AddMuxSel<="1111";MulMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            SqrMuxSel<="0100";AccMuxSel<="1100";                
            AccRegLoad<='1';
            
        when "01000111" =>--Mul T1 Command : Multiply Accumulator and T1 and Store the value in Accumulator  
            state:="01001000";--Next State         
        
            --Multiplying Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="0101";                            
            
        when "01001000" =>--Mul T1 Command : Multiply Accumulator and T1 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="0101";AccMuxSel<="1101";                
            AccRegLoad<='1';
        
        when "01001001" =>--Mul T2 Command : Multiply Accumulator and T2 and Store the value in Accumulator    
            state:="01001010";--Next State         
        
            --Multiplying Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="0110";                            
            
        when "01001010" =>--Mul T2 Command : Multiply Accumulator and T2 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="0110";AccMuxSel<="1101";                
            AccRegLoad<='1';
            
        
        when "01001011" =>--Mul T3 Command : Multiply Accumulator and T3 and Store the value in Accumulator  
            state:="01001100";--Next State         
        
            --Multiplying Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="0111";                            
            
        when "01001100" =>--Mul T3 Command : Multiply Accumulator and T3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="0111";AccMuxSel<="1101";                
            AccRegLoad<='1';
            
        
        when "01001101" =>--Mul X3 Command : Multiply Accumulator and X3 and Store the value in Accumulator  
            state:="01001110";--Next State         
        
            --Multiplying Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="1000";                            
            
        when "01001110" =>--Mul X3 Command : Multiply Accumulator and X3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="1000";AccMuxSel<="1101";                
            AccRegLoad<='1';
            
        
        when "01001111" =>--Mul Y3 Command : Multiply Accumulator and Y3 and Store the value in Accumulator  
            state:="01010000";--Next State         
        
            --Multiplying Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="1001";                            
            
        when "01010000" =>--Mul Y3 Command : Multiply Accumulator and Y3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="1001";AccMuxSel<="1101";                
            AccRegLoad<='1';
            
        
        when "01010001" =>--Mul Z3 Command : Multiply Accumulator and Z3 and Store the value in Accumulator  
            state:="01010010";--Next State         
        
            --Multiplying Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="1010";                            
            
        when "01010010" =>--Mul Z3 Command : Multiply Accumulator and Z3 and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="1010";AccMuxSel<="1101";                
            AccRegLoad<='1';
            
        
        when "01010011" =>--Mul Px Command : Multiply Accumulator and Px and Store the value in Accumulator  
            state:="01010100";--Next State         
        
            --Multiplying Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="0000";                            
            
        when "01010100" =>--Mul Px Command : Multiply Accumulator and Px and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="0000";AccMuxSel<="1101";                
            AccRegLoad<='1';
            
        
        when "01010101" =>--Mul Py Command : Multiply Accumulator and Py and Store the value in Accumulator  
            state:="01010110";--Next State         
        
            --Multiplying Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="0001";                            
            
        when "01010110" =>--Mul Py Command : Multiply Accumulator and Py and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="0001";AccMuxSel<="1101";                
            AccRegLoad<='1';
            
        
        when "01010111" =>--Mul Pz Command : Multiply Accumulator and Pz and Store the value in Accumulator  
            state:="01011000";--Next State         
        
            --Multiplying Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="0010";                            
            
        when "01011000" =>--Mul Pz Command : Multiply Accumulator and Pz and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="0010";AccMuxSel<="1101";                
            AccRegLoad<='1';
            
        
        when "01011001" =>--Mul Qx Command : Multiply Accumulator and Qx and Store the value in Accumulator  
            state:="01011010";--Next State         
        
            --Multiplying Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="0011";                            
            
        when "01011010" =>--Mul Qx Command : Multiply Accumulator and Qx and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="0011";AccMuxSel<="1101";                
            AccRegLoad<='1';
            
        
        when "01011011" =>--Mul Qy Command : Multiply Accumulator and Qy and Store the value in Accumulator  
            state:="01011100";--Next State         
        
            --Multiplying Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";AccMuxSel<="1111";      
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="0100";                            
            
        when "01011100" =>--Mul Qy Command : Multiply Accumulator and Qy and Store the value in Accumulator  
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";AddMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MulMuxSel<="0100";AccMuxSel<="1101";                
            AccRegLoad<='1';
                
        when "01011101" =>--RD Address Command : Reads Data to Accumulator from memory at Specified Address in the instruction
            state:="01011110";--Next State         
        
            --Reading Data From Memory Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="0100";AddMuxSel<="1111";AccMuxSel<="1111";      
            PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MemMuxSel<='1';                            
            MemEnable<='1';MemRW<='0';
            
        when "01011110" =>--RD Address Command : Reads Data to Accumulator from memory at Specified Address in the instruction
            state:="00000000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="0100";AddMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            AccMuxSel<="1110";                
            AccRegLoad<='1';
        
        when "01011111" =>--WR Address Command : Writes Data from Accumulator to memory at Specified Address in the instruction
            state:="00000000";--Next State         
        
            --Writing Data to Memory
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="0100";AddMuxSel<="1111";AccMuxSel<="1111";      
            PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
            MemMuxSel<='1';                            
            MemEnable<='1';MemRW<='1';
            
        when "01100000" =>--Hlt Command : Halts the execution of Processor
            state:="01100000";--Next State(Start State)         
        
            --Copying to Accumulator Part
	          --Disable                 
            SqrMuxSel<="1111";MulMuxSel<="0100";AddMuxSel<="1111";AccMuxSel<="1111";
            MemMuxSel<='1';PCMuxSel<='1';
            T1RegLoad<='0';T2RegLoad<='0';T3RegLoad<='0';X3RegLoad<='0';Y3RegLoad<='0';Z3RegLoad<='0';
            AddOutLoad<='0';SqrOutLoad<='0';MulOutLoad<='0';MemEnable<='0';MemRW<='0';AccRegLoad<='0';
            PxRegLoad<='0';PyRegLoad<='0';PzRegLoad<='0';QxRegLoad<='0';QyRegLoad<='0';PCLoad<='0';IRLoad<='0';
            --Enable
                                                                
        when others     =>  state:="00000000";-- When not in any state

        end case;
    end if;
  end Process;

 
end Operation;

----------------------------------------------------------------------
