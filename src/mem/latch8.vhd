
-- Author: Raphael Spoerri --

library ieee, work;
use ieee.std_logic_1164.all;
use work.spoerri_raphael.latch1;

entity latch8 is port (
	w: in std_logic;
	d: in std_logic_vector(7 downto 0);
	q: out std_logic_vector(7 downto 0)
); end entity;

architecture behav of latch8 is begin
	ff7: latch1 port map(w, d(7), q(7));
	ff6: latch1 port map(w, d(6), q(6));
	ff5: latch1 port map(w, d(5), q(5));
	ff4: latch1 port map(w, d(4), q(4));
	ff3: latch1 port map(w, d(3), q(3));
	ff2: latch1 port map(w, d(2), q(2));
	ff1: latch1 port map(w, d(1), q(1));
	ff0: latch1 port map(w, d(0), q(0));
end architecture;
