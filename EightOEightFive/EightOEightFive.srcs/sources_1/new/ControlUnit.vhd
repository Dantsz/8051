----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2022 01:16:19 PM
-- Design Name: 
-- Module Name: ControlUnit - Behavioral
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

entity ControlUnit is
 port( clk : in std_logic;
       advance: in std_logic;
       instr: in std_logic_vector(23 downto 0);
       
       acumulator_write : out std_logic;
       bus_in_address : out std_logic_vector(7 downto 0);
       alu_control: out std_logic_vector(1 downto 0);
       direct_register_acces: out std_logic;
       write_to_temp: out std_logic_vector(1 downto 0);
       ip_input_control: out std_logic_vector(3 downto 0);
       write_memory: out std_logic;
       
       state: out std_logic_vector(27 downto 0)
 );
end ControlUnit;

architecture Behavioral of ControlUnit is
signal instruction_state: std_logic_vector(3 downto 0) := X"0";
signal reset_state: std_logic;
constant clocks_per_instruction_cycle_plus_one : std_logic_vector(3 downto 0) := X"B";
begin
state <= instr & instruction_state;
generate_signals: process(instr,instruction_state)
    begin
    case instr(23 downto 16) is 
    when X"25" => --ADD a, Direct
        case instruction_state is
            when "0000" => 
                              acumulator_write       <= '0';
                              bus_in_address         <= "10000011";
                              alu_control            <= "00";
                              direct_register_acces  <= '0';
                              write_to_temp          <= "00";
                              write_memory           <= '0';
                              ip_input_control       <= "0000";
                              reset_state            <= '0';
            when "0001" => 
                              acumulator_write       <= '0';
                              bus_in_address         <= "00000001";
                              alu_control            <= "00";
                              direct_register_acces  <= '0';
                              write_to_temp          <= "00";
                              write_memory           <= '0';
                              ip_input_control       <= "0000";
                              reset_state            <= '0';
            when "0010" => 
                              acumulator_write       <= '0';
                              bus_in_address         <= "00000000";
                              alu_control            <= "00";
                              direct_register_acces  <= '0';
                              write_memory           <= '0';
                              write_to_temp          <= "11";
                              ip_input_control       <= "0000";
                              reset_state            <= '0';
            when "0011" => 
                              acumulator_write       <= '0';
                              bus_in_address         <= "00000010";
                              alu_control            <= "00";
                              direct_register_acces  <= '0';
                              write_to_temp          <= "00";
                              write_memory           <= '0';
                              ip_input_control       <= "0000";
                              reset_state            <= '0';
            when others => 
                              acumulator_write       <= '1';
                              bus_in_address         <= "00000000";
                              alu_control            <= "00";
                              direct_register_acces  <= '0';
                              write_to_temp          <= "00";
                              write_memory           <= '0';
                              ip_input_control       <= "0001";
                              reset_state            <= '1';
            end case;
    when X"74" => --MOV A Imm
         case instruction_state is
               when "0000" => 
                                 acumulator_write       <= '0';
                                 bus_in_address         <= "00000011";
                                 alu_control            <= "00";
                                 direct_register_acces  <= '0';
                                 write_to_temp          <= "00";
                                 write_memory           <= '0';
                                 ip_input_control       <= "0000";
                                 reset_state            <= '0';
               when others => 
                                 acumulator_write       <= '1';
                                 bus_in_address         <= "00000000";
                                 alu_control            <= "00";
                                 direct_register_acces  <= '0';
                                 write_to_temp          <= "00";
                                 write_memory           <= '0';
                                 ip_input_control       <= "0001";
                                 reset_state            <= '1';
               end case;
     when X"75" => --MOV direct Imm
          case instruction_state is
                when "0000" => 
                                  acumulator_write       <= '0';
                                  bus_in_address         <= "00000100";
                                  alu_control            <= "00";
                                  direct_register_acces  <= '0';
                                  write_to_temp          <= "00";
                                  write_memory           <= '0';
                                  ip_input_control       <= "0000";
                                  reset_state            <= '0';
                when "0001" => 
                                 acumulator_write       <= '0';
                                 bus_in_address         <= "10000011";
                                 alu_control            <= "00";
                                 direct_register_acces  <= '0';
                                 write_to_temp          <= "00";
                                 write_memory           <= '0';
                                 ip_input_control       <= "0000";
                                 reset_state            <= '0';
                when others => 
                                  acumulator_write       <= '0';
                                  bus_in_address         <= "00000000";
                                  alu_control            <= "00";
                                  direct_register_acces  <= '0';
                                  write_to_temp          <= "00";
                                  write_memory           <= '1';
                                  ip_input_control       <= "0001";
                                  reset_state            <= '1';
                end case;
      when X"F5" => --MOV direct A
             case instruction_state is
                   when "0000" => 
                                     acumulator_write       <= '0';
                                     bus_in_address         <= "00000101";
                                     alu_control            <= "00";
                                     direct_register_acces  <= '0';
                                     write_to_temp          <= "00";
                                     write_memory           <= '0';
                                     ip_input_control       <= "0000";
                                     reset_state            <= '0';
                   when "0001" => 
                                    acumulator_write       <= '0';
                                    bus_in_address         <= "10000011";
                                    alu_control            <= "00";
                                    direct_register_acces  <= '0';
                                    write_to_temp          <= "00";
                                    write_memory           <= '0';
                                    ip_input_control       <= "0000";
                                    reset_state            <= '0';
                   when others => 
                                     acumulator_write       <= '0';
                                     bus_in_address         <= "00000000";
                                     alu_control            <= "00";
                                     direct_register_acces  <= '0';
                                     write_to_temp          <= "00";
                                     write_memory           <= '1';
                                     ip_input_control       <= "0001";
                                     reset_state            <= '1';
                   end case;    
    when others => 
         acumulator_write       <= '0';
         bus_in_address         <= "00000000";
         alu_control            <= "00";
         direct_register_acces  <= '0';
         write_to_temp          <= "00";
         write_memory           <= '0';
         ip_input_control       <= "0001";
         reset_state            <= '1';
    end case;
end process;

increment_state: process(clk)
    begin
    if rising_edge(clk) then 
    if advance = '1' then 
        if reset_state = '1' then 
         instruction_state <= X"0";
        elsif instruction_state = clocks_per_instruction_cycle_plus_one then
          instruction_state <= X"0";
        else          
            instruction_state <= instruction_state + 1;
       
        end if;
     end if;
     end if;
end process;

end Behavioral;
