library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity perceptron_top is
    Port ( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        start : in STD_LOGIC;
        x_input : in STD_LOGIC_VECTOR (15 downto 0);
        w_input : in STD_LOGIC_VECTOR (15 downto 0);
        bias : in STD_LOGIC_VECTOR (7 downto 0);
        threshold : in STD_LOGIC_VECTOR (10 downto 0);
        resultado : out STD_LOGIC;
        resultado_bruto : out STD_LOGIC_VECTOR (10 downto 0);
        ready : out STD_LOGIC;
        busy : out STD_LOGIC
    );
end perceptron_top;

architecture Behavioral of perceptron_top is
    component bloco_operativo
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
    end component;
    
    component bloco_controle
        Port ( 
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            start : in STD_LOGIC;
            mult_done : in STD_LOGIC;
            soma_done : in STD_LOGIC;
            ativacao_done : in STD_LOGIC;
            enable_mult : out STD_LOGIC;
            enable_soma1 : out STD_LOGIC;
            enable_soma2 : out STD_LOGIC;
            enable_bias : out STD_LOGIC;
            enable_ativacao : out STD_LOGIC;
            ready : out STD_LOGIC;
            busy : out STD_LOGIC
        );
    end component;
    
    signal enable_mult, enable_soma1, enable_soma2, enable_bias, enable_ativacao : STD_LOGIC;
    signal mult_done, soma_done, ativacao_done : STD_LOGIC;
    
begin
    bloco_op: bloco_operativo
        port map (
            clk => clk,
            rst => rst,
            x_input => x_input,
            w_input => w_input,
            bias => bias,
            threshold => threshold,
            enable_mult => enable_mult,
            enable_soma1 => enable_soma1,
            enable_soma2 => enable_soma2,
            enable_bias => enable_bias,
            enable_ativacao => enable_ativacao,
            resultado_final => resultado,
            resultado_bruto => resultado_bruto,
            mult_done => mult_done,
            soma_done => soma_done,
            ativacao_done => ativacao_done
        );
    
    bloco_ctrl: bloco_controle
        port map (
            clk => clk,
            rst => rst,
            start => start,
            mult_done => mult_done,
            soma_done => soma_done,
            ativacao_done => ativacao_done,
            enable_mult => enable_mult,
            enable_soma1 => enable_soma1,
            enable_soma2 => enable_soma2,
            enable_bias => enable_bias,
            enable_ativacao => enable_ativacao,
            ready => ready,
            busy => busy
        );
        
end Behavioral;
