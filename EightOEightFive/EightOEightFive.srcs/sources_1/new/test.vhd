----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/21/2022 04:33:55 PM
-- Design Name: 
-- Module Name: test - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test is
Port( clk : in std_logic;
      btn: in std_logic_vector(4 downto  0);
      sw : in std_logic_vector(15 downto 0);
      led: out std_logic_vector(15 downto 0);
      an: out std_logic_vector(3 downto 0);
      cat: out std_logic_vector(6 downto 0));
end test;

architecture Behavioral of test is
signal number : std_logic_vector(15 downto 0):= X"0000";
signal increment_signal : std_logic;
signal alu_select: std_logic_vector(0 downto 0);

signal acumulator: std_logic_vector(7 downto 0);
signal acumulator_input: std_logic_vector(7 downto 0);
begin
    
  
   
    alu: entity work.alu(Behavioral)
    port map(
        a => acumulator,
        b => sw(7 downto 0),
        sel => "0",
        rez => acumulator_input,
        carry_out => led(0),
        aux_carry_out => led(1),
        ov => led(2)
    );
    
    accumulator_process: process(clk) 
    begin
        if rising_edge(clk) then
            if increment_signal = '1' then
                acumulator <= acumulator_input;
            end if;
        end if;
    end process;
    
    debouncer: entity work.Debouncer(Behavioral)
    port map(
    clk => clk,
    input => btn(0),
    output => increment_signal
    );
       
    ssd: entity work.SevenSegmentDisplay4Digits(Behavioral)
    port map(
        number => X"00" & acumulator,
        clk => clk,
        cat => cat,
        an  => an
    );

end Behavioral;
