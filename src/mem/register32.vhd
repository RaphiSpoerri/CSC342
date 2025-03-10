
-- Author: Raphael Spoerri --

library ieee, work;
use ieee.std_logic_1164.all;

use work.spoerri_raphael.all;
entity register32 is port (
	w: in std_logic;
	d: in std_logic_vector(31 downto 0);
	q: out std_logic_vector(31 downto 0)
); end entity;

architecture behav of register32 is begin
	ff8_3: latch8 port map(w, d(31 downto 24), q(31 downto 24));
	ff8_2: latch8 port map(w, d(23 downto 16), q(23 downto 16));
	ff8_1: latch8 port map(w, d(15 downto 8), q(15 downto 8));
	ff8_0: latch8 port map(w, d(7 downto 0), q(7 downto 0));
end architecture;

