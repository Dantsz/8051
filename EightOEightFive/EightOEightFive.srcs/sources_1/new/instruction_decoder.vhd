----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2022 09:02:46 PM
-- Design Name: 
-- Module Name: instruction_decoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instruction_decoder is
    port(
        instr: std_logic_vector(23 downto 0);
        opcode: out std_logic_vector(7 downto 0);
        param_1: out std_logic_vector(7 downto 0);
        param_2: out std_logic_vector(7 downto 0)
        
    );
end instruction_decoder;

architecture Behavioral of instruction_decoder is

begin
    opcode <= instr(7 downto 0);
    param_1 <= instr(15 downto 8);
    param_2 <= instr(23 downto 16);
    
end Behavioral;
