library IEEE;
use ieee.numeric_std.all;  
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SevenSegmentDisplay4Digits is
--  Port ( );
    port(number : in std_logic_vector(15 downto 0);
        clk : in std_logic;
        cat : out std_logic_vector(6 downto 0);
        an: out std_logic_vector(3 downto 0));
end SevenSegmentDisplay4Digits;

architecture Behavioral of SevenSegmentDisplay4Digits is


signal state: std_logic_vector(15 downto 0)  := X"0000";
signal outMuxCatod : std_logic_vector(3 downto 0);
begin
    --counter
    process(clk)
        begin
         if(rising_edge(clk)) then
          state <= state + 1;
         end if;
    end process;
    --mux anod
    process(state)
        begin 
            case state(15 downto 14) is  
            when "00" =>
                an <= "1110";
            when "01" => 
                an <= "1101";
            when "10" => 
                an <= "1011"; 
            when "11" => 
                an <= "0111";      
            when others =>     
            end case; 
        end process;    
       --mux digits
       process(an)
       begin
         case state(15 downto 14) is  
                  when "00" =>
                      outMuxCatod <= number(3 downto 0);
                  when "01" => 
                      outMuxCatod <= number(7 downto 4);
                  when "10" => 
                      outMuxCatod <= number(11 downto 8); 
                  when "11" => 
                      outMuxCatod <= number(15 downto 12);      
                  when others =>     
                  end case; 
       end process;
       --hex to sevent segment
       process(outMuxCatod)
       begin
                 --cat(0) <= outMuxCatod(0) OR outMuxCatod(2) OR (outMuxCatod(1) AND outMuxCatod(3)) OR (NOT outMuxCatod(1) AND NOT outMuxCatod(3));
                 --cat(1) <= (NOT outMuxCatod(1)) OR (NOT outMuxCatod(2) AND NOT outMuxCatod(3)) OR (outMuxCatod(2) AND outMuxCatod(3));
                 --cat(2) <= outMuxCatod(1) OR NOT outMuxCatod(2) OR outMuxCatod(3);
                 -- cat(3) <= (NOT outMuxCatod(1) AND NOT outMuxCatod(3)) OR (outMuxCatod(2) AND NOT outMuxCatod(3)) OR (outMuxCatod(1) AND NOT outMuxCatod(2) AND outMuxCatod(3)) OR (NOT outMuxCatod(1) AND outMuxCatod(2)) OR outMuxCatod(0);
                  --cat(4) <= (NOT outMuxCatod(1) AND NOT outMuxCatod(3)) OR (outMuxCatod(2) AND NOT outMuxCatod(3));
                  --cat(5) <= outMuxCatod(0) OR (NOT outMuxCatod(2) AND NOT outMuxCatod(3)) OR (outMuxCatod(1) AND NOT outMuxCatod(2)) OR (outMuxCatod(1) AND NOT outMuxCatod(3));
                  --cat(6) <= outMuxCatod(0) OR (outMuxCatod(1) AND NOT outMuxCatod(2)) OR ( NOT outMuxCatod(1) AND outMuxCatod(2)) OR (outMuxCatod(2) AND NOT outMuxCatod(3));
          
           with outMuxCatod Select
             cat<= "1111001" when "0001",   --1
                   "0100100" when "0010",   --2
                   "0110000" when "0011",   --3
                   "0011001" when "0100",   --4
                   "0010010" when "0101",   --5
                   "0000010" when "0110",   --6
                   "1111000" when "0111",   --7
                   "0000000" when "1000",   --8
                   "0010000" when "1001",   --9
                   "0001000" when "1010",   --A
                   "0000011" when "1011",   --b
                   "1000110" when "1100",   --C
                   "0100001" when "1101",   --d
                   "0000110" when "1110",   --E
                   "0001110" when "1111",   --F
                   "1000000" when others;   --0
       end process;
    
end Behavioral;