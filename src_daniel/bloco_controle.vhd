library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bloco_controle is
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
end bloco_controle;

architecture Behavioral of bloco_controle is
    type state_type is (IDLE, MULT, DONE);
    signal current_state, next_state : state_type;
    
begin
    state_transition: process(clk, rst)
    begin
        if rst = '1' then
            current_state <= IDLE;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;
    
    next_state_logic: process(current_state, start)
    begin
        case current_state is
            when IDLE =>
                if start = '1' then
                    next_state <= MULT;
                else
                    next_state <= IDLE;
                end if;
                
            when MULT =>
                next_state <= DONE;
                
            when DONE =>
                if start = '0' then
                    next_state <= IDLE;
                else
                    next_state <= DONE;
                end if;
                
            when others =>
                next_state <= IDLE;
        end case;
    end process;
    
    output_logic: process(current_state)
    begin
        enable_mult <= '0';
        enable_soma1 <= '0';
        enable_soma2 <= '0';
        enable_bias <= '0';
        enable_ativacao <= '0';
        ready <= '0';
        busy <= '0';
        
        case current_state is
            when IDLE =>
                ready <= '1';
                busy <= '0';
                
            when MULT =>
                enable_mult <= '1';
                enable_soma1 <= '1';
                enable_soma2 <= '1';
                enable_bias <= '1';
                enable_ativacao <= '1';
                busy <= '1';
                
            when DONE =>
                ready <= '1';
                busy <= '0';
                
            when others =>
                null;
        end case;
    end process;
    
end Behavioral;
