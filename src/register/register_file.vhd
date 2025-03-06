


library ieee, work;
use ieee.std_logic_1164.all;
use work.processor.flipflop8;

entity register_file is port (
	clk: in std_logic;
	d: in std_logic_vector(31 downto 0);
	q: inout std_logic_vector(31 downto 0)
); end entity;

architecture behav of register_file is begin
	ff8_3: flipflop8 port map(clk, d(31 downto 24), q(31 downto 24));
	ff8_2: flipflop8 port map(clk, d(23 downto 16), q(23 downto 16));
	ff8_1: flipflop8 port map(clk, d(15 downto 8), q(15 downto 8));
	ff8_0: flipflop8 port map(clk, d(7 downto 0), q(7 downto 0));
end architecture;

