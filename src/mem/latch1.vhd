
-- Author: Raphael Spoerri

library ieee, work;
use ieee.std_logic_1164.all;
use work.spoerri_raphael.nor_gate;

entity latch1 is port (
	w, d: in std_logic;
	q: out std_logic := '0'
); end entity;

architecture behav of latch1 is
	signal w1: std_logic := '0';
	signal w2: std_logic := '1';
	signal conn, conn2: std_logic;
begin
	nor1: nor_gate port map(w1, conn2, conn);
	nor2: nor_gate port map(w2, conn, conn2);
	process(w, conn2) is begin
		w1 <= w and d;
		w2 <= w and not d;
		q <= conn2;
	end process;
end architecture;
