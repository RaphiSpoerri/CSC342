
library ieee, work;

use ieee.std_logic_1164.all;
use work.machine.all;

entity testbench is
end testbench;

architecture tb of testbench is
	signal clk, sub, signed, imm, overflow, exec: std_logic := '0';
	signal stmt, res, reg2: std_logic_vector(31 downto 0);
	signal reg1, dest: std_logic_vector(1 downto 0);
	signal flags: std_logic_vector(2 downto 0);
	signal regs: std_logic_vector(35 downto 0);
	type Instructions is array(natural range <>) of std_logic_vector(31 downto 0);
	constant program: Instructions := (
		addi & r1 & r1 & "00000000" & "00000010",
		addi & r0 & r0 & "00000000" & "00000010",
		add & r2 & r1 & r0 & unused
	);
begin
	p1: processor port map(clk, sub, signed, imm, reg1, dest, reg2, res, overflow);
	a2: assembler port map(exec, stmt, flags, regs);
	process is begin
		--stmt <= ADDU & r2 & r1 & r1 & unused;
		imm <= '1';
		reg2 <= zeros32;
		reg1 <= "00";
		dest <= "00";
		clk <= '1';
		wait for 15 ns;
		clk <= '0';
		wait for 5 ns;

		for i in 0 to program'length - 1 loop

			stmt <= program(i);
			exec <= '1';
			wait for 15 ns;

			report to_string(flags);
			exec <= '0';
			wait for 5 ns;
		end loop;

		--report to_string(stmt);
		report to_string(res);
		wait;
	end process;
end architecture;
	

