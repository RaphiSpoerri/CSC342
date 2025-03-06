
library ieee;
library work;
use ieee.std_logic_1164.all;
use work.processor.all;

entity testbench is
end entity;

architecture tab of testbench is
	signal lhs, rhs, sum: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
	signal cout: std_logic;
begin
	adder: alu32 port map(lhs, rhs, '1', cout, sum);

	process is begin
		lhs <= "00000000000000000000000000011000";
		rhs <= "00000000000000000000000000000111";
		wait for 200 ns;
		report to_string(sum);

		wait;
	end process;
end architecture;
	
