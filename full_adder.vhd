library ieee;
use ieee.std_logic_1164.all;

entity full_adder is port (
	lhs, rhs, cin: in std_logic;
	cout, sum: out std_logic
); end entity;


architecture struct of full_adder is
	signal adder_connect, carry1, carry2: std_logic;
	
	component half_adder is port (
		left, right: in std_logic;
		sum, carry: out std_logic
	); end component;
begin
	half1: half_adder port map(lhs, rhs, adder_connect, carry1);
	half2: half_adder port map(adder_connect, cin, sum, carry2);

	process(carry1, carry2) is begin
		cout <= carry1 or carry2;
	end process;
end architecture;
