library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity funcao_ativacao is
    Port ( 
        entrada : in STD_LOGIC_VECTOR (10 downto 0);
        threshold : in STD_LOGIC_VECTOR (10 downto 0);
        saida : out STD_LOGIC
    );
end funcao_ativacao;

architecture Behavioral of funcao_ativacao is
begin
    saida <= '1' when unsigned(entrada) >= unsigned(threshold) else '0';
end Behavioral;
