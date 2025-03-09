
library ieee, work;

use ieee.std_logic_1164.all;
use work.machine.all;

entity testbench is
end testbench;

architecture tb of testbench is
	signal run, done: std_logic := '0';
	signal init: std_logic := '0';
	signal stmt: std_logic_vector(31 downto 0);
begin
	cpu: assembler port map(init, run, stmt, done);
	
	process is begin
		init <= '1';
		wait for 20 ns;
		stmt <= addiu & r1 & r1 & zeros32(7 downto 0) & "00001111";
		run <= '1';
		wait until done = '1';
	
		--report to_string(res);
		wait;
	end process;
end architecture;
	

