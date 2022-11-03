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

entity modul_principal is
    Port ( clk : in std_logic;
           btn: in std_logic_vector(4 downto  0);
           sw : in std_logic_vector(15 downto 0);
           led: out std_logic_vector(15 downto 0);
           an: out std_logic_vector(3 downto 0);
           cat: out std_logic_vector(6 downto 0));
end modul_principal;

architecture Behavioral of modul_principal is
begin
 
end Behavioral;