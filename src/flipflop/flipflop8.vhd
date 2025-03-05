
library ieee;
library work;
use ieee.std_logic_1164.all;
use work.processor.flipflop1;

entity flipflop8 is
	port(
		clk: in std_logic;
		d: in std_logic_vector(7 downto 0);
		q: inout std_logic_vector(7 downto 0)
	);
end flipflop8;

architecture behav of flipflop8 is
begin
	ff7: flipflop1 port map(clk, d(7), q(7));
	ff6: flipflop1 port map(clk, d(6), q(6));
end architecture;
