
-------------------------------Coded by Sely--------------------------

----------------------------------------------------------------------
----------------------------------------------------------------------
-------------------------//Squaring//---------------------------

library ieee;
  use ieee.std_logic_1164.all;

entity Squaring is
  port(
      Clock : in  std_logic;
      Reset : in  std_logic;
      Start : in  std_logic;
      Input : in  std_logic_vector(162 downto 0);
      Done  : out std_logic;
      Output: out std_logic_vector(162 downto 0)      
      );
end Squaring;
 
architecture Operation of Squaring is

begin
  process(Clock)
    variable x:std_logic_vector(324 downto 0);
    variable vRedPoly:std_logic_vector(163 downto 0):="10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011001001";
    variable i:integer:=0;
    variable vStart:std_logic:='0';
    begin
    
      --Squaring
      
      
      
      if(Clock='1' and Reset='1')then
         Output<="0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
         Done<='0';
      elsif(Clock='1' and Start='1' and vStart='0')then
         --Starts Here
         Done<='0';
         vStart:='1';
         i:=324;
         
         x:=Input(162)&'0'&Input(161)&'0'&Input(160)&'0'&Input(159)&'0'&Input(158)&'0'&Input(157)&'0'&Input(156)&'0'&Input(155)&'0'&
         Input(154)&'0'&Input(153)&'0'&Input(152)&'0'&Input(151)&'0'&Input(150)&'0'&Input(149)&'0'&Input(148)&'0'&Input(147)&'0'&Input(146)&'0'&Input(145)&'0'&
         Input(144)&'0'&Input(143)&'0'&Input(142)&'0'&Input(141)&'0'&Input(140)&'0'&Input(139)&'0'&Input(138)&'0'&Input(137)&'0'&Input(136)&'0'&Input(135)&'0'&
         Input(134)&'0'&Input(133)&'0'&Input(132)&'0'&Input(131)&'0'&Input(130)&'0'&Input(129)&'0'&Input(128)&'0'&Input(127)&'0'&Input(126)&'0'&Input(125)&'0'&
         Input(124)&'0'&Input(123)&'0'&Input(122)&'0'&Input(121)&'0'&Input(120)&'0'&Input(119)&'0'&Input(118)&'0'&Input(117)&'0'&Input(116)&'0'&Input(115)&'0'&
         Input(114)&'0'&Input(113)&'0'&Input(112)&'0'&Input(111)&'0'&Input(110)&'0'&Input(109)&'0'&Input(108)&'0'&Input(107)&'0'&Input(106)&'0'&Input(105)&'0'&
         Input(104)&'0'&Input(103)&'0'&Input(102)&'0'&Input(101)&'0'&Input(100)&'0'&Input(99)&'0'&Input(98)&'0'&Input(97)&'0'&Input(96)&'0'&Input(95)&'0'&
         Input(94)&'0'&Input(93)&'0'&Input(92)&'0'&Input(91)&'0'&Input(90)&'0'&Input(89)&'0'&Input(88)&'0'&Input(87)&'0'&Input(86)&'0'&Input(85)&'0'&
         Input(84)&'0'&Input(83)&'0'&Input(82)&'0'&Input(81)&'0'&Input(80)&'0'&Input(79)&'0'&Input(78)&'0'&Input(77)&'0'&Input(76)&'0'&Input(75)&'0'&
         Input(74)&'0'&Input(73)&'0'&Input(72)&'0'&Input(71)&'0'&Input(70)&'0'&Input(69)&'0'&Input(68)&'0'&Input(67)&'0'&Input(66)&'0'&Input(65)&'0'&
         Input(64)&'0'&Input(63)&'0'&Input(62)&'0'&Input(61)&'0'&Input(60)&'0'&Input(59)&'0'&Input(58)&'0'&Input(57)&'0'&Input(56)&'0'&Input(55)&'0'&
         Input(54)&'0'&Input(53)&'0'&Input(52)&'0'&Input(51)&'0'&Input(50)&'0'&Input(49)&'0'&Input(48)&'0'&Input(47)&'0'&Input(46)&'0'&Input(45)&'0'&
         Input(44)&'0'&Input(43)&'0'&Input(42)&'0'&Input(41)&'0'&Input(40)&'0'&Input(39)&'0'&Input(38)&'0'&Input(37)&'0'&Input(36)&'0'&Input(35)&'0'&
         Input(34)&'0'&Input(33)&'0'&Input(32)&'0'&Input(31)&'0'&Input(30)&'0'&Input(29)&'0'&Input(28)&'0'&Input(27)&'0'&Input(26)&'0'&Input(25)&'0'&
         Input(24)&'0'&Input(23)&'0'&Input(22)&'0'&Input(21)&'0'&Input(20)&'0'&Input(19)&'0'&Input(18)&'0'&Input(17)&'0'&Input(16)&'0'&Input(15)&'0'&
         Input(14)&'0'&Input(13)&'0'&Input(12)&'0'&Input(11)&'0'&Input(10)&'0'&Input(9)&'0'&Input(8)&'0'&Input(7)&'0'&Input(6)&'0'&Input(5)&'0'&
         Input(4)&'0'&Input(3)&'0'&Input(2)&'0'&Input(1)&'0'&Input(0);
         
      elsif(Clock='1' and Start='1' and vStart='1')then
          i:=i-1;          
          
          if(x(i)='1')then
              x(i downto i-163):= x(i downto i-163) xor vRedPoly;          
          end if;
          
          if(i=163)then
             vStart:='0';
             Done<='1';
             Output<=x(162 downto 0);               
          end if;  
      
      elsif(Clock='1' and Start='0' and vStart='1')then
         vStart:='0';     
      end if;
      
    end process;
        
end Operation;

----------------------------------------------------------------------
----------------------------------------------------------------------