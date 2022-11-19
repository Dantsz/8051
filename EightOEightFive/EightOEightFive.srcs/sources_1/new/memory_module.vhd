----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/17/2022 10:31:20 PM
-- Design Name: 
-- Module Name: memory_module - Behavioral
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
use work.bitfield;
use work.special_function_register_file;
use work.register_file;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory_module is
port(
     clk: in std_logic;
     address: in std_logic_vector(7 downto 0);
     write_enable: in std_logic;
     bit_or_byte_mode: in std_logic;--if 0 it will write the bit, if one it will write the byte
    
     byte_input      : in std_logic_vector(7 downto 0);
     bit_input       : in std_logic;
           
     byte_read       : out std_logic_vector(7 downto 0);
     bit_read        : out std_logic;
     
     PSW             : out std_logic_vector(7 downto 0)
    );
end memory_module;

architecture Behavioral of memory_module is
signal sfr_bit_output : std_logic;
signal sfr_byte_output: std_logic_vector(7 downto 0);

signal bitfield_out: std_logic;
signal register_file_out : std_logic_vector(7 downto 0);
begin
sfr: entity work.special_function_register_file(Behavioral)
    port map(
               clk => clk,   
               bit_or_byte_mode => bit_or_byte_mode,
               write_enable   => write_enable and address(7),
               
               address   => address(6 downto 0),
               
               byte_input   =>  byte_input  ,
               bit_input    =>  bit_input  ,
               
               byte_read    => sfr_byte_output,
               bit_read     => sfr_bit_output,
               PSW => PSW  
    );
bitmem: entity work.bitfield(Behavioral) 
    port map(clk => clk,
             addr => address(6 downto 0),
             set => write_enable and (not bit_or_byte_mode)  and (not address(7)) and bit_input,
             unset => write_enable and (not bit_or_byte_mode)  and (not address(7)) and (not bit_input),
             bit_out => bitfield_out);
register_file: entity work.register_file(Behavioral)
port map(
     ra => address(6 downto 0),
     wa => address(6 downto 0),
    
     write_value => byte_input,
     read_value => register_file_out,
    
     clk => clk,
     write_enable => write_enable and not address(7)
    );
    byte_read <= register_file_out when address(7) = '0' else sfr_byte_output;
    bit_read <=  bitfield_out when address(7) = '0' else sfr_bit_output;
end Behavioral;
