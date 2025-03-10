
-- Author: Raphael Spoerri --

library ieee;
use ieee.std_logic_1164.all;

entity nor_gate is port (
	a, b: in std_logic;
	q: out std_logic
); end entity;

architecture struct of nor_gate is begin
	process(a, b) is begin
		q <= a nor b;
	end process;
end struct;
