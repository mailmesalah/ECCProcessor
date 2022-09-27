--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:42:47 07/28/2013
-- Design Name:   
-- Module Name:   F:/VHDL projeect/full_163bitgfadder/full_163bitgfadder_tb.vhd
-- Project Name:  full_163bitgfadder
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: full_163bitgfadder
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY full_163bitgfadder_tb IS
END full_163bitgfadder_tb;
 
ARCHITECTURE behavior OF full_163bitgfadder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT full_163bitgfadder
    PORT(
         a : IN  std_logic_vector(162 downto 0);
         b : IN  std_logic_vector(162 downto 0);
         c : OUT  std_logic_vector(162 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(162 downto 0) := (others => '0');
   signal b : std_logic_vector(162 downto 0) := (others => '0');

 	--Outputs
   signal c : std_logic_vector(162 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: full_163bitgfadder PORT MAP (
          a => a,
          b => b,
          c => c
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.

          a <= "1011011111101110000001010101111111100001101010000111111000000111100000011110101010101100111010011100101010111101011110001010111100101011000010101101011010101111010";
          b <= "1010011000101110110001010101111111100001101010000111101010100111101111010010101010101100111010011100101010110101011110001010111100101011000010101101011010101000011";
   wait for 10 ns;
          a <= "1000011010111110000001010101110111001111101010000110010000000110010100011110101010101100111010011111111010111101011110001010111100101011000010101101011010101111010";
          b <= "1011010011101110000001010101100111100001101010110100111011000111100000011110101010101100111010011100101010111101011110001010111100101011000010101101011010101111010";




      -- insert stimulus here 

      wait;
   end process;

END;
