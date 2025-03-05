
library ieee;
use ieee.std_logic_1164.all;

entity flipflop8 is
	port(
		clk: in std_logic;
		d: in std_logic_vector(7 downto 0);
		q: inout std_logic_vector(7 downto 0)
	);
end flipflop8;

architecture behav of flipflop8 is
	component flipflop1 is
		port(
			clk, d: in std_logic;
			q: inout std_logic
		);
	end component;
begin
	ff0: flipflop1 port map(clk, d(7), q(7));
end architecture;
