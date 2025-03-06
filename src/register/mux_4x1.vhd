
library ieee;
use ieee.std_logic_1164.all;

entity mux_4x1 is port (
	addr: in std_logic_vector(1 downto 0);
	bus0, bus1, bus2, bus3: in std_logic_vector(31 downto 0);
	q: out std_logic_vector(31 downto 0)
); end entity;

architecture struct of mux_4x1 is begin
	process(addr, buses) is begin
		for i := 0 to 31 generate
			q(i) <= (addr(0) and addr(1) and bus3(i))
				or (not addr(0) and addr(1) and bus2(i))
				or (addr(0) and not addr(1) and bus1(i))
				or (not addr(0) and not addr(1) and bus0(i));
		end generate;
	end process;
end architecture;