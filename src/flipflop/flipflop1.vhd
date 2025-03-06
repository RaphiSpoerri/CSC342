


library ieee;
library work;
use ieee.std_logic_1164.all;
use work.processor.nor_gate;

entity flipflop1 is port (
	clk, d: in std_logic;
	q: inout std_logic
); end entity;

architecture behav of flipflop1 is
	signal w1: std_logic := '0';
	signal w2: std_logic := '1';
	signal conn: std_logic;
begin
	nor1: nor_gate port map(w1, q, conn);
	nor2: nor_gate port map(w2, conn, q);
	process(clk) is begin
		w1 <= clk and d;
		w2 <= clk and not d;
	end process;
end architecture;

