
-- Author: Raphael Spoerri --

library ieee, work;
use ieee.std_logic_1164.all;
use work.spoerri_raphael.half_adder;

entity full_adder is port (
	lhs, rhs, cin: in std_logic;
	cout, sum: out std_logic
); end entity;

architecture struct of full_adder is
	signal adder_connect, carry1, carry2: std_logic;
begin
	half1: half_adder port map(lhs, rhs, carry1, adder_connect);
	half2: half_adder port map(adder_connect, cin, carry2, sum);

	process(carry1, carry2) is begin
		cout <= carry1 or carry2;
	end process;
end architecture;
