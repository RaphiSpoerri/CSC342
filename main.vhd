


library IEEE;
library work;
use IEEE.std_logic_1164.all;

use work.processor.all;


entity testbench is
-- empty
end testbench;

architecture tb of testbench is
	signal l, r, sum: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
	signal cout: std_logic;

begin
  DUT: adder32 port map(l, r, '1', '1', cout, sum);

  process is begin
	l <= "00000000000000000000000000011000";
	r <= "00000000000000000000000000000111";
	wait for 200 ns;
	report to_string(sum);

    assert false report "Test done." severity note;
    wait;
  end process;
end tb;
