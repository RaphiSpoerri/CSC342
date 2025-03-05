library ieee;
library work;
use ieee.std_logic_1164.all;
use work.processor.full_adder;

entity adder8 is
	port(
		lhs, rhs: in std_logic_vector(7 downto 0);
		inv, cin: in std_logic;
		cout: out std_logic;
		sum: out std_logic_vector(7 downto 0)
	);
end entity;

architecture behav of adder8 is
	signal carry: std_logic_vector(6 downto 0);
	signal inverter: std_logic_vector(7 downto 0);
begin
	fa0: full_adder port map(lhs(0), inverter(0), cin,      carry(0), sum(0));
	fa1: full_adder port map(lhs(1), inverter(1), carry(0), carry(1), sum(1));
	fa2: full_adder port map(lhs(2), inverter(2), carry(1), carry(2), sum(2));
	fa3: full_adder port map(lhs(3), inverter(3), carry(2), carry(3), sum(3));
	fa4: full_adder port map(lhs(4), inverter(4), carry(3), carry(4), sum(4));
	fa5: full_adder port map(lhs(5), inverter(5), carry(4), carry(5), sum(5));
	fa6: full_adder port map(lhs(6), inverter(6), carry(5), carry(6), sum(6));
	fa7: full_adder port map(lhs(7), inverter(7), carry(6), cout,     sum(7));

	process(rhs, inv) is begin
		inverter(0) <= rhs(0) xor inv;
		inverter(1) <= rhs(1) xor inv;
		inverter(2) <= rhs(2) xor inv;
		inverter(3) <= rhs(3) xor inv;
		inverter(4) <= rhs(4) xor inv;
		inverter(5) <= rhs(5) xor inv;
		inverter(6) <= rhs(6) xor inv;
		inverter(7) <= rhs(7) xor inv;
	end process;
end architecture;


