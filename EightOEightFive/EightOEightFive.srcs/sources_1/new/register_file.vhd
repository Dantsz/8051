----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2022 01:16:04 PM
-- Design Name: 
-- Module Name: register_file - Behavioral
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register_file is
    port(
     ra1 : in std_logic_vector(7 downto 0);
     ra2 : in std_logic_vector(7 downto 0);
     wa : in std_logic_vector(7 downto 0);
     
     write_value : in std_logic_vector(7 downto 0);
     read_value_1: out std_logic_vector(7 downto 0);
     read_value_2: out std_logic_vector(7 downto 0);
     
     clk: in std_logic;
     write_enable: in std_logic
    );
end register_file;

architecture Behavioral of register_file is
type reg_ar is array (0 to 255) of std_logic_vector(7 downto 0);
signal state : reg_ar := (others=>X"00");
begin

    process(clk,write_enable)
    begin
        if(falling_edge(clk)) then
            if (write_enable = '1') then
                state(to_integer(unsigned(wa))) <= write_value;
            end if;
        end if;
    end process;
    read_value_1 <= state(to_integer(unsigned(ra1)));
    read_value_2 <= state(to_integer(unsigned(ra2)));
end Behavioral;