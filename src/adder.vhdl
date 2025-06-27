library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity adder is
	generic(
		N : positive := 8 
	);
	port(
		input_a : in  unsigned(N - 1 downto 0);
		input_b : in  unsigned(N - 1 downto 0);
		sum     : out unsigned(N downto 0)      
	);
end adder;

architecture arch of adder is
begin
    sum <= resize(input_a, N +1) + resize(input_b, N+1);
end architecture arch;