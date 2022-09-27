--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:42:17 07/16/2013
-- Design Name:   
-- Module Name:   F:/VHDL projeect/full_163bitmul/full_163bitmul_tb.vhd
-- Project Name:  full_163bitmul
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: full_163bitmul
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
 
ENTITY full_163bitmul_tb IS
END full_163bitmul_tb;
 
ARCHITECTURE behavior OF full_163bitmul_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT full_163bitmul
    PORT(
         a : IN  std_logic_vector(162 downto 0);
         b : IN  std_logic;
         clk : IN  std_logic;
         reset : IN  std_logic;
         c : OUT  std_logic_vector(162 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(162 downto 0) := (others => '0');
   signal b : std_logic := '0';
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal c : std_logic_vector(162 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: full_163bitmul PORT MAP (
          a => a,
          b => b,
          clk => clk,
          reset => reset,
          c => c
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
        wait for 5 ns;
	    reset <= '1';
	    wait for 10 ns;
	    reset <= '0';
        wait for 10 ns;
	    a <= "1011011111101110000001010101111111100001101010000111111000000111100000011110101010101100111010011100101010111101011110001010111100101011000010101101011010101111010";
        b <= '1';
	    wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
        b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
        b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		b <= '0';
		wait for 10 ns;
		a <= "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
		b <='0';
		
      -- insert stimulus here 

      wait;
   end process;

END;
