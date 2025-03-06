
library ieee, work;

use ieee.std_logic_1164.all;
use work.processor.all;

entity testbench is
end testbench;

architecture tab of testbench is
	signal clk: std_logic;
	signal s: std_logic_vector(5 downto 0);
	signal d, q1, q0: std_logic_vector(31 downto 0);
begin
	reg: register_file port map(clk, s(1 downto 0), s(3 downto 2), s(5 downto 4), d, q1, q0);

	process is begin
		s <= "000000";
		d <= not ("00000000"&"00000000"&"00000000"&"00000000");
		clk <= '1';
		wait for 5 ns;
		report to_string(q1) & ":" & to_string(q0);
		wait;
	end process;
end architecture;
	
