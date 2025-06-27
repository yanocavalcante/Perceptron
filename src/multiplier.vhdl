library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity relu is
  port (
    x  : in  unsigned(3 downto 0);
    w  : in  unsigned(3 downto 0)
    p  : out unsigned(7 downto 0)
  );
end entity;

architecture behavioral of relu is
begin
  process(x, w)
  begin
    p <= x * w;
  end process;
end architecture;
