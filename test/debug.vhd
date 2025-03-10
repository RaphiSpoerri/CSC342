
-- Author: Raphael Spoerri --

library ieee, work;

use ieee.std_logic_1164.all;
use work.spoerri_raphael.all;

entity testbench is
end testbench;

architecture tb of testbench is
	signal clk, sub, signed, imm, overflow: std_logic := '0';
	signal stmt, res, reg2: std_logic_vector(31 downto 0);
	signal reg1, dest: std_logic_vector(1 downto 0);
begin
	cpu: processor port map(clk, sub, signed, imm, reg1, dest, reg2, res, overflow);
	
	process is begin
		--stmt <= ADDU & r2 & r1 & r1 & unused;
		imm <= '1';
		reg2 <= zeros32(23 downto 0) & "00001111";
		reg1 <= "00";
		dest <= "00";
		clk <= '1';
		wait for 15 ns;
		clk <= '0';
		wait for 5 ns;
		report to_string(res);
		imm <= '0';
		reg2(0) <= '0';
		reg2(1) <= '0';
		wait for 1 ns;
		clk <= '1';
		wait for 15 ns;
		clk <= '0';
		
		--report to_string(stmt);
		report to_string(res);
		wait;
	end process;
end architecture;
	

