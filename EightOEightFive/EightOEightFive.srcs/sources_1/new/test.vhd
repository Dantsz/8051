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
signal increment_twelve: std_logic;

signal alu_select: std_logic_vector(1 downto 0) := "00";
signal alu_output: std_logic_vector(7 downto 0);

signal acumulator: std_logic_vector(7 downto 0);
signal acumulator_write : std_logic;

signal aux_c_out : std_logic;

signal uc_state : std_logic_vector(27 downto 0);

signal bus_wire: std_logic_vector(7 downto 0);
signal bus_input_control: std_logic_vector(2 downto 0);

signal mem_out: std_logic_vector(7 downto 0);
signal mem_write: std_logic;

signal temp_reg1: std_logic_vector(7 downto 0);
signal temp_reg2: std_logic_vector(7 downto 0);
signal write_to_temp_control: std_logic_vector(1 downto 0);

begin

    alu: entity work.alu(Behavioral)
    port map(
        a => temp_reg1,
        b => temp_reg2,
        sel => alu_select,
        rez => alu_output,
        carry_out => open,
        aux_carry_out => aux_c_out,
        ov => open
    );
    
  
    uc: entity work.ControlUnit(Behavioral)
    port map(
           clk                      => clk,
           advance                  => increment_signal,
           instr                    => "00100101" & "00100101" & "00100101",
           
           acumulator_write         => acumulator_write,
           bus_in_address           => bus_input_control,
           alu_control              => open,
           direct_register_acces    => open,
           write_to_temp            => write_to_temp_control,
           advance_sp               => open,
           write_memory             => mem_write,
           
           state                    => uc_state
    );
    bus_control: process(clk,bus_input_control)
    begin
        if rising_edge(clk) then 
            case bus_input_control is
                when "001" => bus_wire <= mem_out;
                when "010" => bus_wire <= alu_output;
                when others => bus_wire <= bus_wire;
            end case;
        end if;
    end process;
    acumulator_control: process(clk,acumulator_write)
    begin
        if rising_edge(clk) then 
            if acumulator_write = '1' then
                acumulator <= bus_wire;
            end if;
        end if;
    end process;
    temp_registers: process(clk,write_to_temp_control)
    begin
        if rising_edge(clk) then
            if write_to_temp_control(0) then
                temp_reg1 <= acumulator;
            end if;
            if write_to_temp_control(1) then
                temp_reg2 <= bus_wire;
            end if;
        end if;
    end process;
    memory: entity work.memory_module(Behavioral)
    port map(
           clk => clk,   
           bit_or_byte_mode => sw(15),
           write_enable   =>  mem_write,
           
           address   => sw(7 downto 0)     ,
           
           byte_input   =>  bus_wire  ,
           bit_input    =>  aux_c_out  ,
           
           byte_read    => mem_out,
           bit_read     => led(0), 
           PSW => led(15 downto 8)
    );
    
   
    
    debouncer: entity work.Debouncer(Behavioral)
    port map(
    clk => clk,
    input => btn(0),
    output => increment_signal
    );
       
    ssd: entity work.SevenSegmentDisplay4Digits(Behavioral)
    port map(
        number => acumulator  &  bus_wire,
        clk => clk,
        cat => cat,
        an  => an
    );

end Behavioral;
