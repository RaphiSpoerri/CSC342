
library ieee;
library work;

use ieee.std_logic_1164.all;
use work.processor.all;

entity testbench is
end testbench;

architecture tab of testbench is
	signal clk, d: std_logic;
	signal q: std_logic;
	signal qnot: std_logic;
begin
  ff: flipflop1 port map(clk => clk, d => d, q => q, qnot => qnot);

  process is begin
	d <= '0';
	clk <= '1';
	wait for 20 ns;
	report std_logic'image(q);
	clk <= '0';
	wait for 10 ns;
	report std_logic'image(q);
	--d <= '0';
	--wait for 10 ns;
	--report std_logic'image(q);

	assert false report "Test done." severity note;
	wait;
  end process;
end architecture;
	
