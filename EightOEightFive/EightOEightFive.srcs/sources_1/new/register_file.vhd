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
     bank_select: in std_logic_vector(1 downto 0);
     register_select: in std_logic_vector(2 downto 0);
     
     write_value : in std_logic_vector(7 downto 0);
     read_value: out std_logic_vector(7 downto 0);
     clk: in std_logic;
     write_enable: in std_logic
    );
end register_file;

architecture Behavioral of register_file is
type reg_ar is array (0 to 31) of std_logic_vector(7 downto 0);
signal state : reg_ar := (others=>X"00");
signal reg_addr: std_logic_vector(4 downto 0);
begin
    reg_addr <= bank_select & register_select;
    process(clk,write_enable)
    begin
        if(falling_edge(clk)) then
            if (write_enable = '1') then
                state(to_integer(unsigned(reg_addr))) <= write_value;
            end if;
        end if;
    end process;
    read_value <= state(to_integer(unsigned(reg_addr)));
end Behavioral;
