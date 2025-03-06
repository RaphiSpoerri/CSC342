
library ieee;
use ieee.std_logic_1164.all;

entity half_adder is port (
	lhs, rhs: in std_logic;
	cout, sum: out std_logic
); end entity;

architecture struct of half_adder is begin
	process(lhs, rhs) is begin
		sum <= lhs xor rhs;
		cout <= lhs and rhs;
	end process;
end architecture;
