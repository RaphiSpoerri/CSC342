
-- Author: Raphael Spoerri

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
