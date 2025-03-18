
-- Author: Raphael Spoerri --

library ieee, work;

use ieee.std_logic_1164.all;
use work.spoerri_raphael.all;

entity testbench is
end testbench;

architecture tb of testbench is
	signal clk: std_logic;
	signal d, q1, q0: std_logic_vector(31 downto 0);
begin
	reg: register_file port map(clk, "00", d, "00", q1, "00", q0);

	process is begin
		report to_string(q1);
		clk <= '1';
		d <= zeros32;
		wait for 5 ns;
		clk <= '0';
		wait for 100 ns;
		report to_string(q1);
		wait for 5 ns;
		
		clk <= '1';
		d <= "10000000000000000000000000000000";
		wait for 10 ns;
		
		report to_string(q1);
		if q1 /= "10000000000000000000000000000000" then
			report "Test #1 failed" severity error;
		end if;
		clk <= '0';
		d <= "01000000000000000000000000000000";
		wait for 5 ns;
		if q1 /= "10000000000000000000000000000000" then
			report "Test #2 failed" severity error;
		end if;
		
		report to_string(q1);

		clk <= '1';
		d <= "00011000000000000000000000000000";
		wait for 5 ns;
		
		report to_string(q1);
		if q1 /= "00011000000000000000000000000000" then
			report "Test #3 failed" severity error;
		end if;
		clk <= '0';
		d <= "01000000000000000000000000000000";
		wait for 5 ns;
		if q1 /= "00011000000000000000000000000000" then
			report "Test #4 failed" severity error;
		end if;
		
		report to_string(q1);
		wait;
	end process;
end architecture;
	

