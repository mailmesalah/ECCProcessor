----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:18:11 08/03/2013 
-- Design Name: 
-- Module Name:    square_163bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity square_163bit is
port (
a: in std_logic_vector(162 downto 0);
clk : in std_logic;
reset : in std_logic;
c: out std_logic_vector(162 downto 0)
);
end square_163bit;

architecture Behavioral of square_163bit is
signal sig, temp, m, xor_sigtemp: std_logic_vector(162 downto 0);
signal xor1, xor2: std_logic :='0';

begin
P1:PROCESS(a,xor_sigtemp,sig,temp,m)
begin
sig(162) <= a(81);
temp(7) <= a(82);
temp(162) <= a(159);
xor1 <= a(160) xor a(161); 
xor2 <= a(161) xor a(162);

m(0) <= a(160);
m(1) <= a(160) xor a(162); 
m(2) <= a(161); 
m(3) <= xor1;
m(4) <= a(82) xor a(160);
m(5) <= xor2; 
m(6) <= a(83) xor xor1;
m(7) <= '0'; 
m(8) <= a(84) xor xor1;
m(9) <= '0';
m(10) <= a(85) xor xor2;
m(11) <= '0'; 
m(12) <= a(86) xor a(162);
m(13) <= '0';

m(162) <= a(161);

for j in 0 to 6 loop
temp(j) <= '0'; 
end loop;

for i in 4 to 80 loop 
sig(2*i) <= a(i); 
sig(2*i + 1) <= a(i+82); 

temp(2*i) <= a(i+78); 
temp(2*i + 1) <= a(i+79); 

m(2*i) <= a(i+80); 
m(2*i + 1) <= '0'; 
end loop;

for j in 0 to 162 loop 
xor_sigtemp(j) <= sig(j) xor temp(j); 
c(j) <= xor_sigtemp(j) xor m(j); 
end loop;
end process;


end Behavioral;


