
-- Author: Raphael Spoerri --

library ieee, work;
use ieee.std_logic_1164.all;
use work.spoerri_raphael.zeros32;

entity mux_4x1 is port (
	addr: in std_logic_vector(1 downto 0);
	bus0, bus1, bus2, bus3: in std_logic_vector(31 downto 0) := zeros32;
	q: out std_logic_vector(31 downto 0) := zeros32
); end entity;

architecture struct of mux_4x1 is begin
	process(addr, bus0, bus1, bus2, bus3) is begin
		foreach: for i in 0 to 31 loop
			q(i) <= (addr(0) and addr(1) and bus3(i))
				or (not addr(0) and addr(1) and bus2(i))
				or (addr(0) and not addr(1) and bus1(i))
				or (not addr(0) and not addr(1) and bus0(i));
		end loop;
	end process;
end architecture;
