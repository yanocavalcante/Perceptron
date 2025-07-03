library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity somador_generico is
    generic (
        INPUT_WIDTH : integer := 8;
        OUTPUT_WIDTH : integer := 9
    );
    Port ( 
        a : in STD_LOGIC_VECTOR (INPUT_WIDTH-1 downto 0);
        b : in STD_LOGIC_VECTOR (INPUT_WIDTH-1 downto 0);
        soma : out STD_LOGIC_VECTOR (OUTPUT_WIDTH-1 downto 0)
    );
end somador_generico;

architecture Behavioral of somador_generico is
begin
    soma <= STD_LOGIC_VECTOR(resize(unsigned(a), OUTPUT_WIDTH) + resize(unsigned(b), OUTPUT_WIDTH));
end Behavioral;
