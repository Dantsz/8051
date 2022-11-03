----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/13/2022 08:37:46 PM
-- Design Name: 
-- Module Name: alu - Behavioral
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

entity alu is
 port( a : in std_logic_vector(7 downto 0 );
       b : in std_logic_vector(7 downto 0 );
       sel: in std_logic_vector(0 downto 0);
       rez : out std_logic_vector(7 downto 0);
       --PSW
       --PSW.7
        carry_out : out std_logic;
       --PSW.6
        aux_carry_out: out std_logic;
       --PSW.2
        ov:  out std_logic
       );
end alu;

architecture Behavioral of alu is
signal unsigned_buffer: unsigned(8 downto 0);
signal auxiliary_unsigned_buffer: unsigned(4 downto 0);
begin
process(a,b,sel)
begin
    case sel is
        when "0" =>           
            rez <= std_logic_vector(unsigned_buffer(7 downto 0));   
        when "1" => 
            rez <= std_logic_vector(signed(a) + signed(b));
    end case;
end process;
unsigned_buffer <= unsigned("0" & a) + unsigned(b);
auxiliary_unsigned_buffer <= unsigned("0" & a(3 downto 0)) + unsigned(b(3 downto 0));
carry_out <= unsigned_buffer(8);  
aux_carry_out <= auxiliary_unsigned_buffer(4);
ov <= '1' when (signed(a) > 0 and signed(b) > 0 and signed(a) + signed(b) < 0) or (signed(a) < 0 and signed(b) < 0 and signed(a) + signed(b) > 0) else '0';
end Behavioral;
