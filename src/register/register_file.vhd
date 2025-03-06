


library ieee, work;
use ieee.std_logic_1164.all;
use work.processor.register32;

entity register_file is port (
	w: in std_logic;
	d: in std_logic_vector(33 downto 0);
	q1: out std_logic_vector(33 downto 0);
	q2: out std_logic_vector(33 downto 0)
); end entity;

architecture behav of register_file is begin
	r3: register32 port map(w, d, );
	r2: register32 port map(w, d, q(23 downto 16));
	r1: register32 port map(w, d, q(15 downto 8));
	r0: register32 port map(w, d, q(7 downto 0));
end architecture;

