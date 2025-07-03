library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2to1 is
    generic (
        WIDTH : integer := 8
    );
    Port ( 
        sel : in STD_LOGIC;
        input0 : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        input1 : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        output : out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );
end mux_2to1;

architecture Behavioral of mux_2to1 is
begin
    output <= input0 when sel = '0' else input1;
end Behavioral;
