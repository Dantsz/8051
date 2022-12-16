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
      instr: out std_logic_vector(7 downto 0)
);
end program_memory;

architecture Behavioral of program_memory is
type progmem is array (0 to 255) of std_logic_vector(7 downto 0);
signal state : progmem := (
                            --X"741010",--MOV A Imm
                            --X"252525",--ADD a, Direct
                            --X"E5"   MOV A Direct
                            --X"F5" - MOV Direct A
                            -- X"75D069",--MOV direct Imm
                            -- x"b5" -- cmpjg Direct Offset   
                            -- 0   1    2 
                            X"75",X"20",X"19",
                            -- 3   4    5
                            X"75",X"21",X"2D",
                            --6     7
                            X"E5",X"20",
                            --8     9
                            X"95",X"21",
                            --10  11
                            X"60",X"18",
                            --12 13
                            X"E5",X"20",
                            --14  15  16
                            X"B5",X"21",X"B",
                            --17  18
                            X"F5",X"22",
                            --19 20
                            X"E5",X"21",
                            --21 22
                            X"F5",X"20",
                            --23 24
                            X"E5",X"22",
                            --25 26
                            X"F5",X"21",
                            --27 28
                            X"E5",X"20",
                            --29  30
                            X"95",X"21",
                            --31  32
                            X"F5",X"20", 
                            --33  34
                            X"70",X"E4",
                            --35 36
                            X"E5",X"20",
                            X"F5",X"D0",
                            
                            
                            
                            
                            -- X"74",X"00",
                             --X"75",X"13",X"01",
                             --X"25",X"13",
                            -- X"B5",X"77","11110111",
                             
                          --   X"25",X"12",
                             --X"00",
                           --  
                           --  X"F5", X"D0",
                            -- X"00",
                             
                           --  X"75",X"12",X"69",  
                                                      
                           --  X"25",X"12",--X"00",
                             
                           --  X"F5",X"D0",--X"00",
                             
                            -- X"75",X"12",X"69",
                             
                             --X"25",X"12",--X"00",
                             
                             --X"F5",X"D0",--X"00",--MOV d0 A
                            others=>X"00");
begin
    instr <= state(to_integer(unsigned(addr)));

end Behavioral;
