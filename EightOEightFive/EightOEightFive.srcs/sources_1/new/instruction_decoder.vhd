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
        data_in: in std_logic_vector(7 downto 0);
        we: in std_logic;
        clk: in std_logic;
        data_out: out std_logic_vector(7 downto 0)
    );
end instruction_decoder;

architecture Behavioral of instruction_decoder is
signal state : std_logic_vector(7 downto 0);
begin
    process(clk,we)
    begin
        if(rising_edge(clk) ) then
            if(we = '1') then
                state <= data_in;
            end if;
        end if;
    end process;
    data_out <= state;
end Behavioral;
