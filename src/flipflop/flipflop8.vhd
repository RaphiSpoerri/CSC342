
library ieee, work;
use ieee.std_logic_1164.all;
use work.processor.flipflop1;

entity flipflop8 is port (
	clk: in std_logic;
	d: in std_logic_vector(7 downto 0);
	q: out std_logic_vector(7 downto 0)
); end entity;

architecture behav of flipflop8 is begin
	ff7: flipflop1 port map(clk, d(7), q(7));
	ff6: flipflop1 port map(clk, d(6), q(6));
	ff5: flipflop1 port map(clk, d(5), q(5));
	ff4: flipflop1 port map(clk, d(4), q(4));
	ff3: flipflop1 port map(clk, d(3), q(3));
	ff2: flipflop1 port map(clk, d(2), q(2));
	ff1: flipflop1 port map(clk, d(1), q(1));
	ff0: flipflop1 port map(clk, d(0), q(0));
end architecture;
