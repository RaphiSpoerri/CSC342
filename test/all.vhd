
library ieee, work;

use ieee.std_logic_1164.all;
use work.machine.all;

entity testbench is
end testbench;

architecture tb of testbench is
	signal clk, overflow: std_logic := '0';
	signal stmt, res: std_logic_vector(31 downto 0);
begin
	cpu: processor port map(clk, stmt, res, overflow);
	
	process is begin
		stmt <= ADDU & r2 & r1 & r1 & unused;
		wait for 10 ns;
		report to_string(stmt);
		clk <= '1';
		wait for 100 ns;
		report to_string(res);
		wait;
	end process;
end architecture;
	

