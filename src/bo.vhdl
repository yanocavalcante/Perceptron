library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sad_pack.all;


entity sad_bo is
    generic(
        bits_per_sample   : positive := 8;
        samples_per_block : positive := 64
    );
    port(
        clk        : in  std_logic;
        rst_a      : in  std_logic;
        commands   : in  std_logic_vector(2 downto 0);
        sample_ori : in  std_logic_vector(bits_per_sample - 1 downto 0);
        sample_can : in  std_logic_vector(bits_per_sample - 1 downto 0);
        sad_result : out std_logic_vector(
                        sad_length(bits_per_sample, samples_per_block)-1 downto 0
                     );
        status     : out std_logic_vector(1 downto 0)
    );
end entity sad_bo;
architecture structure of sad_bo is

    constant ACC_WIDTH : positive := sad_length(bits_per_sample, samples_per_block);

    signal x0, x1, x2, x3 : unsigned(inputs_size);
    signal w0, w1, w2, w3 : unsigned(inputs_size);
    signal y0, y1, y2, y3 : unsigned(2*inputs_size);

    signal sample_ori_u, sample_can_u : unsigned(bits_per_sample - 1 downto 0);
    signal diff_abs                   : unsigned(bits_per_sample - 1 downto 0);
    signal acc_in, acc_out            : unsigned(ACC_WIDTH - 1 downto 0);
    signal acc_sum                    : unsigned(ACC_WIDTH downto 0); -- corrigido: N+1 bits
    signal acc_clear, acc_enable      : std_logic;
    signal acc_input                  : unsigned(ACC_WIDTH - 1 downto 0);

begin

    sample_ori_u <= unsigned(sample_ori);
    sample_can_u <= unsigned(sample_can);

    acc_clear  <= commands(1); -- clear (início do bloco)
    acc_enable <= commands(0); -- soma (leitura ativa)




    mult_zero: entity work.multiplier
        generic map (N => inputs_size)
        port map (
            x => x0,
            w => w0,
            p => y0
        );

    mult_one: entity work.multiplier
        generic map (N => inputs_size)
        port map (
            x => x1,
            w => w1,
            p => y1
        );

    mult_two: entity work.multiplier
        generic map (N => inputs_size)
        port map (
            x => x2,
            w => w2,
            p => y2
        );

    mult_three: entity work.multiplier
        generic map (N => inputs_size)
        port map (
            x => x3,
            w => w3,
            p => y3
        );

    add_zero: entity work.adder
        generic map (N => 2 * inputs_size)
        port map (
            input_a => ,
            input_b => ,
            sum => 
        );
    add_one: entity work.adder
        generic map (N => 2 * inputs_size)
        port map (
            input_a => ,
            input_b => ,
            sum => 
        );

    bias_adder: entity work.adder
        generic map ()
        port map (
            input_a => ,
            input_b => ,
            sum =>
        );

    ac_func: entity work.relu
        generic map ()
        port map (
            x => ,
            y => output
        );

    perceptron_result <= output





    abs_inst : entity work.absolute_difference
        generic map(N => bits_per_sample)
        port map(
            input_a  => sample_ori_u,
            input_b  => sample_can_u,
            abs_diff => diff_abs
        );

    sum_inst : entity work.unsigned_adder
        generic map(N => ACC_WIDTH)
        port map(
            input_a => acc_out,
            input_b => resize(diff_abs, ACC_WIDTH),
            sum     => acc_sum
        );

    acc_input <= (others => '0') when acc_clear = '1' else acc_sum(ACC_WIDTH - 1 downto 0);

    reg_inst : entity work.unsigned_register
        generic map(N => ACC_WIDTH)
        port map(
            clk    => clk,
            enable => acc_clear or acc_enable,
            d      => acc_input,
            q      => acc_out
        );

    sad_result <= std_logic_vector(acc_out);
    status     <= (others => '0');

end architecture structure;