
-- Author: Raphael Spoerri --

library ieee, work;

use ieee.std_logic_1164.all;
use work.spoerri_raphael.all;

entity testbench is
end testbench;

architecture tab of testbench is
	signal clk: std_logic;
	signal d: std_logic_vector(31 downto 0);
	signal q: std_logic_vector(31 downto 0);
begin
	reg: register32 port map(clk, d, q);

	process is begin
		clk <= '1';
		d <= zeros32;
		wait for 5 ns;
		d <= "10000000000000000000000000000000";
		clk <= '0';
		wait for 100 ns;
		report to_string(q);
		clk <= '1';
		d <= "10000000000000000000000000000000";
		wait for 5 ns;
		
		report to_string(q);
		if q /= "10000000000000000000000000000000" then
			report "Test #1 failed" severity error;
		end if;
		clk <= '0';
		d <= "01000000000000000000000000000000";
		wait for 5 ns;
		if q /= "10000000000000000000000000000000" then
			report "Test #2 failed" severity error;
		end if;
		
		report to_string(q);

		clk <= '1';
		d <= "00011000000000000000000000000000";
		wait for 5 ns;
		
		report to_string(q);
		if q /= "00011000000000000000000000000000" then
			report "Test #3 failed" severity error;
		end if;
		clk <= '0';
		d <= "01000000000000000000000000000000";
		wait for 5 ns;
		if q /= "00011000000000000000000000000000" then
			report "Test #4 failed" severity error;
		end if;
		
		report to_string(q);

		wait;
	end process;
end architecture;
	

