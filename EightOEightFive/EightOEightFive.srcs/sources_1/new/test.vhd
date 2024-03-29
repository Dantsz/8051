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
signal debouncer_counter :std_logic_vector(23 downto 0);
signal increment_twelve: std_logic;

signal alu_control : std_logic_vector(1 downto 0);
signal alu_output: std_logic_vector(7 downto 0);

signal acumulator: std_logic_vector(7 downto 0);
signal acumulator_write : std_logic;
signal acumulator_zero : std_logic;

signal aux_c_out : std_logic;

signal uc_state : std_logic_vector(11 downto 0);

signal bus_wire: std_logic_vector(15 downto 0);
signal bus_input_control: std_logic_vector(7 downto 0);

signal mem_out: std_logic_vector(7 downto 0);
signal mem_write: std_logic;

signal temp_reg1: std_logic_vector(7 downto 0);
signal temp_reg2: std_logic_vector(7 downto 0);
signal write_to_temp_control: std_logic_vector(1 downto 0);


signal instruction_pointer: std_logic_vector(7 downto 0);
signal ip_input_control: std_logic_vector(3 downto 0);
signal write_ip_to_decode: std_logic;

signal program_data_out: std_logic_vector(7 downto 0);
signal opcode: std_logic_vector(7 downto 0);

signal bit_or_byte_memory_operation: std_logic;

signal comp: std_logic_vector(2 downto 0);

begin

    alu: entity work.alu(Behavioral)
    port map(
        a => temp_reg1,
        b => temp_reg2,
        sel => alu_control,
        rez => alu_output,
        carry_out => open,
        aux_carry_out => aux_c_out,
        ov => open
    );
    acumulator_zero <= '1' when acumulator = X"00" else '0';
    comparating: entity work.comparator(Behavioral)
    port map(a => temp_reg1,
             b => temp_reg2,
             comp => comp);
    uc: entity work.ControlUnit(Behavioral)
    port map(
           clk                      => clk,
           advance                  => increment_signal,
           instr                    => opcode,
           acumulator_zero          => acumulator_zero,
           comp                     => comp,
           acumulator_write         => acumulator_write,
           bus_in_address           => bus_input_control,
           alu_control              => alu_control,
           direct_register_acces    => open,
           write_to_temp            => write_to_temp_control,
           ip_input_control         => ip_input_control,
           write_memory             => mem_write,
           write_ip_to_decode       => write_ip_to_decode,
           bit_or_byte_memory_operation => bit_or_byte_memory_operation,
           state                    => uc_state
    );
    instruction_decode: entity work.instruction_decoder(Behavioral)
    port map(
        clk => clk,
        we => write_ip_to_decode,
        data_in => program_data_out,
        data_out => opcode
        
    );
    bus_control: process(clk,bus_input_control)
    begin
        if rising_edge(clk) then 
            case bus_input_control is
                when "00000001" => bus_wire(7 downto 0) <= mem_out;
                when "00000010" => bus_wire(7 downto 0) <= alu_output;
                --when "00000011" => bus_wire(7 downto 0) <= program_data_out(15 downto 8);
                when "00000100" => bus_wire(7 downto 0) <= program_data_out(7 downto 0);
                when "00000101" => bus_wire(7 downto 0) <= acumulator;
          
                
                when "10000001" => bus_wire(15 downto 8) <= mem_out;
                when "10000010" => bus_wire(15 downto 8) <= alu_output;
                --when "10000011" => bus_wire(15 downto 8) <= program_data_out(15 downto 8);
                when "10000100" => bus_wire(15 downto 8) <= program_data_out(7 downto 0);
                when "10000101" => bus_wire(15 downto 8) <= acumulator;
           
                
                when others => bus_wire <= bus_wire;
            end case;
        end if;
    end process;
    
    acumulator_control: process(clk,acumulator_write)
    begin
        if rising_edge(clk) then 
            if acumulator_write = '1' then
                acumulator <= bus_wire(7 downto 0);
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
                temp_reg2 <= bus_wire(7 downto 0);
            end if;
        end if;
    end process;
    memory: entity work.memory_module(Behavioral)
    port map(
           clk => clk,   
           bit_or_byte_mode => bit_or_byte_memory_operation,
           write_enable   =>  mem_write,
           
           address   => bus_wire(15 downto 8)     ,
           
           byte_input   =>  bus_wire(7 downto 0),
           bit_input    =>  bus_wire(1),
           
           byte_read    => mem_out,
           bit_read     => led(0), 
           PSW => led(15 downto 8)
    );
    instruction_pointer_control: process(clk)
    begin
        if rising_edge(clk) then
           if increment_signal = '1' then
            case ip_input_control is
                when "0001" => instruction_pointer <= instruction_pointer + 1;
                when "0011" => instruction_pointer <= instruction_pointer + bus_wire(15 downto 8);
                when others => instruction_pointer <= instruction_pointer;
            end case;             
            end if;
        end if;
    end process;
    program_data:entity work.program_memory(Behavioral)
    port map(
    addr => instruction_pointer,
    instr => program_data_out
    );
    
    --debouncer: entity work.Debouncer(Behavioral)
    --port map(
    --clk => clk,
    --input => btn(0),
    --output => increment_signal
    --);
    debouncer: process(clk)
    begin
    if rising_edge(clk) then 
        debouncer_counter <= debouncer_counter + 1;
    end if;
    end process; 
    increment_signal <= '1' when debouncer_counter = X"000" else '0';
    
    ssd: entity work.SevenSegmentDisplay4Digits(Behavioral)
    port map(
        number => temp_reg2  &  temp_reg1 ,--"0000" & uc_state , 
        clk => clk,
        cat => cat,
        an  => an
    );
    led(3 downto 1 ) <= comp;
    --led(15 downto 8) <= acumulator;
end Behavioral;
