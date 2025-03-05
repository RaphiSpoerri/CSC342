library ieee;
use ieee.std_logic_1164.all;

entity half_adder is port (
	left, right: in std_logic;
	sum, carry: out std_logic
); end entity;

architecture struct of half_adder is begin
	process(left, right) is begin
		sum <= left xor right;
		carry <= left and right;
	end process;
end architecture;
