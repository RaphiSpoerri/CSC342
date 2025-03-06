library ieee, work;

use ieee.std_logic_1164.all;
use work.processor.adder8;

entity adder32 is port (
	lhs, rhs: in std_logic_vector(31 downto 0);
	inv, cin: in std_logic;
	cout: out std_logic;
	sum: out std_logic_vector(31 downto 0)
); end entity;

architecture behav of adder32 is
	signal carry: std_logic_vector(0 to 2);
begin
	a0: adder8 port map(lhs(31 downto 24), rhs(31 downto 24), inv, cin,	  carry(0), sum(31 downto 24));
	a1: adder8 port map(lhs(23 downto 16), rhs(23 downto 16), inv, carry(0), carry(1), sum(23 downto 16));
	a2: adder8 port map(lhs(15 downto 8), rhs(15 downto 8), inv, carry(1), carry(2), sum(15 downto 8));
	a3: adder8 port map(lhs(7 downto 0), rhs(7 downto 0), inv, carry(2), cout,	 sum(7 downto 0));
end architecture;


