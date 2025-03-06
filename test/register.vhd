
library ieee;
library work;

use ieee.std_logic_1164.all;
use work.processor.all;

entity testbench is
end testbench;

architecture tab of testbench is
	signal clk: std_logic;
	signal d, q: std_logic_vector(31 downto 0);
begin
	reg: register32 port map(clk, d, q);

	process is begin
		d <= '0';
		clk <= '1';
		

		wait;
	end process;
end architecture;
	
