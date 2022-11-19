----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/12/2022 10:38:29 PM
-- Design Name: 
-- Module Name: special_function_register_file - Behavioral
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

entity special_function_register_file is
    port(
        clk             : in std_logic;
        bit_or_byte_mode: in std_logic;
        write_enable    : in std_logic;
        
        address         : in std_logic_vector(6 downto 0);
        
        byte_input      : in std_logic_vector(7 downto 0);
        bit_input       : in std_logic;
        
        byte_read       : out std_logic_vector(7 downto 0);
        bit_read        : out std_logic;
        PSW             : out std_logic_vector(7 downto 0)
        );
end special_function_register_file;

architecture Behavioral of special_function_register_file is
type reg_ar is array (0 to 127) of std_logic_vector(7 downto 0);
signal state : reg_ar := (others=>X"00");
signal bit_address: std_logic_vector(6 downto 0);
constant PSW_address : std_logic_vector(6 downto 0) := "1010000";
begin
     process(clk,write_enable)
     begin
       if(falling_edge(clk)) then
           if (write_enable = '1') then
           
            if(bit_or_byte_mode = '0') then
                state(to_integer(unsigned( bit_address ) ))(to_integer(unsigned(address(2 downto 0)))) <= bit_input;
            else
               state(to_integer(unsigned(address))) <= byte_input;
            end if;
               
           end if;
       end if;
   end process;
    bit_address <= (address(6 downto 3) & "000");
    byte_read <= state(to_integer(unsigned(address)));
    bit_read <= state(to_integer(unsigned( bit_address ) ))(to_integer(unsigned(address(2 downto 0))));
    PSW <= state(to_integer(unsigned(PSW_address)));
end Behavioral;
