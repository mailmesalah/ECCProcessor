----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:29:07 07/28/2013 
-- Design Name: 
-- Module Name:    full_163bitgfadder - Behavioral 
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

entity Adding is
    Port ( a : in  STD_LOGIC_VECTOR (162 downto 0);
           b : in  STD_LOGIC_VECTOR (162 downto 0);
           c : out  STD_LOGIC_VECTOR (162 downto 0));
end Adding;

architecture Behavioral of Adding is

begin

c <= a xor b;
end Behavioral;

