library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package Types is
  function to_string(n: std_logic_vector) return string;
end package;

package body Types is
	function to_string(n: std_logic_vector) return string is
		variable b: string (1 to n'length) := (others => NUL);
		variable stri: integer := 1; 
	begin
	    for i in n'range loop
	        b(stri) := std_logic'image(N((i)))(2);
	    	stri := stri+1;
	    end loop;
		return b;
	end function;
end package body;

library IEEE, work;
use IEEE.std_logic_1164.all, work.Types.all;

entity testbench is
-- empty
end testbench;

architecture tb of testbench is
	component adder32 is
		port(
			lhs, rhs: in std_logic_vector(31 downto 0);
	        inv, cin: in std_logic;
	        cout: out std_logic;
	        sum: out std_logic_vector(31 downto 0)
		);
	end component;
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
