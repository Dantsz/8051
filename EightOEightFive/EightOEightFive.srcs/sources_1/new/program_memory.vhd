----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2022 02:30:59 PM
-- Design Name: 
-- Module Name: program_memory - Behavioral
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
use ieee.numeric_std.to_integer;
use ieee.numeric_std.unsigned;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity program_memory is
port( addr: in std_logic_vector(7 downto 0);
      instr: out std_logic_vector(23 downto 0)
);
end program_memory;

architecture Behavioral of program_memory is
type progmem is array (0 to 255) of std_logic_vector(23 downto 0);
signal state : progmem := (others=>X"000000000000");
begin
    instr <= state(to_integer(unsigned(addr)));

end Behavioral;
