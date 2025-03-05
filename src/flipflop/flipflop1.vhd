


library ieee;
use ieee.std_logic_1164.all;

entity nor_gate is
	port(
		a, b: in std_logic;
		q: out std_logic
	);
end nor_gate;

architecture struct of nor_gate is
begin
	process(a, b) is begin
		q <= a nor b;
	end process;
end struct;

library ieee;
library work;
use ieee.std_logic_1164.all;
use work.processor.nor_gate;

entity flipflop1 is
	port(
		clk, d: in std_logic;
		q, qnot: inout std_logic
	);
end flipflop1;

architecture behav of flipflop1 is
	signal w1: std_logic := '0';
	signal w2: std_logic := '1';
begin
	nor1: nor_gate port map(w1, q, qnot);
	nor2: nor_gate port map(w2, qnot, q);
	process(clk, d, q) is begin
		w1 <= clk and d;
		w2 <= clk and not d;
	end process;
end behav;

