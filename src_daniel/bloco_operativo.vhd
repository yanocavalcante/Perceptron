library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bloco_operativo is
    Port ( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        x_input : in STD_LOGIC_VECTOR (15 downto 0);
        w_input : in STD_LOGIC_VECTOR (15 downto 0);
        bias : in STD_LOGIC_VECTOR (7 downto 0);
        threshold : in STD_LOGIC_VECTOR (10 downto 0);
        enable_mult : in STD_LOGIC;
        enable_soma1 : in STD_LOGIC;
        enable_soma2 : in STD_LOGIC;
        enable_bias : in STD_LOGIC;
        enable_ativacao : in STD_LOGIC;
        resultado_final : out STD_LOGIC;
        resultado_bruto : out STD_LOGIC_VECTOR (10 downto 0);
        mult_done : out STD_LOGIC;
        soma_done : out STD_LOGIC;
        ativacao_done : out STD_LOGIC
    );
end bloco_operativo;

architecture Behavioral of bloco_operativo is
    component somador_generico
        generic (
            INPUT_WIDTH : integer := 8;
            OUTPUT_WIDTH : integer := 9
        );
        Port ( 
            a : in STD_LOGIC_VECTOR (INPUT_WIDTH-1 downto 0);
            b : in STD_LOGIC_VECTOR (INPUT_WIDTH-1 downto 0);
            soma : out STD_LOGIC_VECTOR (OUTPUT_WIDTH-1 downto 0)
        );
    end component;
    
    component funcao_ativacao
        Port ( 
            entrada : in STD_LOGIC_VECTOR (10 downto 0);
            threshold : in STD_LOGIC_VECTOR (10 downto 0);
            saida : out STD_LOGIC
        );
    end component;
    
    signal x0, x1, x2, x3 : STD_LOGIC_VECTOR (3 downto 0);
    signal w0, w1, w2, w3 : STD_LOGIC_VECTOR (3 downto 0);
    signal produto0, produto1, produto2, produto3 : STD_LOGIC_VECTOR (7 downto 0);
    signal soma01, soma23 : STD_LOGIC_VECTOR (8 downto 0);
    signal soma_total : STD_LOGIC_VECTOR (9 downto 0);
    signal resultado_com_bias : STD_LOGIC_VECTOR (10 downto 0);
    signal resultado_ativacao : STD_LOGIC;
    signal resultado_registrado : STD_LOGIC;
    signal resultado_bruto_reg : STD_LOGIC_VECTOR (10 downto 0);
    
begin
    x0 <= x_input(3 downto 0);
    x1 <= x_input(7 downto 4);
    x2 <= x_input(11 downto 8);
    x3 <= x_input(15 downto 12);
    
    w0 <= w_input(3 downto 0);
    w1 <= w_input(7 downto 4);
    w2 <= w_input(11 downto 8);
    w3 <= w_input(15 downto 12);
    
    produto0 <= STD_LOGIC_VECTOR(unsigned(x0) * unsigned(w0));
    produto1 <= STD_LOGIC_VECTOR(unsigned(x1) * unsigned(w1));
    produto2 <= STD_LOGIC_VECTOR(unsigned(x2) * unsigned(w2));
    produto3 <= STD_LOGIC_VECTOR(unsigned(x3) * unsigned(w3));
    
    somador1: somador_generico 
        generic map (INPUT_WIDTH => 8, OUTPUT_WIDTH => 9)
        port map (a => produto0, b => produto1, soma => soma01);
        
    somador2: somador_generico 
        generic map (INPUT_WIDTH => 8, OUTPUT_WIDTH => 9)
        port map (a => produto2, b => produto3, soma => soma23);
        
    somador3: somador_generico 
        generic map (INPUT_WIDTH => 9, OUTPUT_WIDTH => 10)
        port map (a => soma01, b => soma23, soma => soma_total);
        
    somador_bias_inst: somador_generico 
        generic map (INPUT_WIDTH => 10, OUTPUT_WIDTH => 11)
        port map (a => soma_total, b => ("00" & bias), soma => resultado_com_bias);
    
    ativacao_inst: funcao_ativacao
        port map (entrada => resultado_com_bias, threshold => threshold, saida => resultado_ativacao);
    
    process(clk, rst)
    begin
        if rst = '1' then
            resultado_registrado <= '0';
            resultado_bruto_reg <= (others => '0');
        elsif rising_edge(clk) then
            if enable_mult = '1' then
                resultado_registrado <= resultado_ativacao;
                resultado_bruto_reg <= resultado_com_bias;
            end if;
        end if;
    end process;
    
    resultado_final <= resultado_registrado;
    resultado_bruto <= resultado_bruto_reg;
    
    mult_done <= enable_mult;
    soma_done <= enable_mult;
    ativacao_done <= enable_mult;
    
end Behavioral;
