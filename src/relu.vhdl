library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity relu is
  port (
    x  : in  signed(7 downto 0);
    y  : out signed(7 downto 0)
  );
end entity;

architecture behavioral of relu is
begin
  process(x)
  begin
    if x > 0 then
      y <= x;
    else
      y <= (others => '0');
    end if;
  end process;
end architecture;
