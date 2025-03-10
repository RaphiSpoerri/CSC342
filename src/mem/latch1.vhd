
-- Author: Raphael Spoerri

<<<<<<< HEAD
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

=======
library ieee;
use ieee.std_logic_1164.ALL;

entity sr_latch is port(
	s, r, w: in std_logic;
	q, p: out std_logic
); end entity;

architecture struct of sr_latch is
	signal q_signal, p_signal: std_logic;
begin
	p_signal <= (s and w) nor q_signal;
	p <= p_signal;
	q_signal <= (r and w) nor p_signal;
	q <= q_signal;
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity latch1 is port(
	w, d: in std_logic;
	q, p: out std_logic
); end entity;

architecture struct of latch1 is
	component sr_latch is port(
		s, r, w: in std_logic;
		q, p: out std_logic
	); end component;

	signal not_d, p_signal, q_signal: std_logic;
begin

	not_d <= (not d);
	sr_latch_comp: sr_latch port map(d, not_d, w, q, p);
end architecture;
>>>>>>> 55b43d42fd467abd13d663fe2471b53cd97a6c27
