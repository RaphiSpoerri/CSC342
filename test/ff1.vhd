
library ieee;
library work;

use ieee.std_logic_1164.all;
use work.processor.all;

entity testbench is
end testbench;

architecture tab of testbench is
	signal clk, d: std_logic;
	signal q: std_logic := '0';
begin
	ff: flipflop1 port map(clk => clk, d => d, q => q);

	process is begin
		d <= '0';
		clk <= '1';
		wait for 5 ns;
		if q /= '0' then
			report "#1 Fail" severity error;
		end if;
		report std_logic'image(clk) & ":" & std_logic'image(d) & ":" & std_logic'image(q);

		d <= '1';
		clk <= '0';
		wait for 5 ns;
		if q /= '0' then
			report "#2 Fail" severity error;
		end if;
		report std_logic'image(clk) & ":" & std_logic'image(d) & ":" & std_logic'image(q);

		d <= '1';
		clk <= '1';
		wait for 5 ns;
		if q /= '1' then
			report "#3 Fail" severity error;
		end if;
		report std_logic'image(clk) & ":" & std_logic'image(d) & ":" & std_logic'image(q);


		d <= '0';
		clk <= '0';
		wait for 5 ns;
		if q /= '1' then
			report "#4 Fail" severity error;
		end if;
		report std_logic'image(clk) & ":" & std_logic'image(d) & ":" & std_logic'image(q);

		d <= '0';
		clk <= '1';
		wait for 5 ns;
		if q /= '0' then
			report "#5 Fail" severity error;
		end if;
		report std_logic'image(clk) & ":" & std_logic'image(d) & ":" & std_logic'image(q);

		wait;
	end process;
end architecture;
	
