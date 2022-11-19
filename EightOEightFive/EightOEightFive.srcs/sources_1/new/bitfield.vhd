----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2022 10:29:40 PM
-- Design Name: 
-- Module Name: bitfield - Behavioral
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

entity bitfield is
    port(clk : in std_logic;
         addr: in std_logic_vector(6 downto 0);
         set: in std_logic;
         unset: in std_logic;
         bit_out: out std_logic
         );
end bitfield;

architecture Behavioral of bitfield is
type bit_ar is array (0 to 127) of std_logic;
signal state: bit_ar:= (others=>'0');
begin
process(clk,set,unset)
    begin
        if(falling_edge(clk)) then
        if (set xor unset) = '1' then
            if (set = '1') then
                state(to_integer(unsigned(addr))) <= '1';
            elsif (unset = '1') then
                state(to_integer(unsigned(addr))) <= '0';
            end if;
        end if;
        end if;
    end process;
bit_out <= state(to_integer(unsigned(addr)));
end Behavioral;
