
library ieee;
use ieee.std_logic_1164.all;

entity flipflop8 is
	port(
		clk: in std_logic;
		d: in std_logic_vector(31 downto 0);
		q: out std_logic_vector(31 downto 0);
	);
end flipflop8;

architecture behav of flipflop8 is
begin
	ff0: flipflop1 port map(clk, d)
end flipflop8;
