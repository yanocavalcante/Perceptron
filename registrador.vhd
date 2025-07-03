library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registrador is
    generic (
        WIDTH : integer := 8
    );
    Port ( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        enable : in STD_LOGIC;
        data_in : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        data_out : out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );
end registrador;

architecture Behavioral of registrador is
begin
    process(clk, rst)
    begin
        if rst = '1' then
            data_out <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                data_out <= data_in;
            end if;
        end if;
    end process;
end Behavioral;
