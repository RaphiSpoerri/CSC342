
-- Author: Raphael Spoerri --

library ieee, work;

use ieee.std_logic_1164.all;
use work.spoerri_raphael.all;

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
		addi & r1 & r0 & "00000000" & "00000010",
		addi & r0 & r2 & "00000000" & "00000010",
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
		report to_string(res);
		dest <= "11";
		reg2 <= zeros32(23 downto 0) & "00001111";
		wait for 5 ns;
		clk <= '1';
		wait for 15 ns;
		clk <= '0';
		report to_string(res);
		reg1 <= "11";
		wait for 5 ns;
		clk <= '1';
		wait for 15 ns;
		clk <= '0';
		report to_string(res);


		wait for 5 ns;
		clk <= '1';
		wait for 15 ns;
		clk <= '0';
		report to_string(res);
		wait for 5 ns;

		for i in 0 to program'length - 1 loop

			stmt <= program(i);
			exec <= '1';
			wait for 15 ns;
			exec <= '0';
			report to_string(flags) & ":" & std_logic'image(flags(0));
			sub <= flags(0);
			signed <= flags(1);
			imm <= flags(2);
			dest <= regs(1 downto 0);
			reg1 <= regs(3 downto 2);
			reg2 <= regs(35 downto 4);
			report "regs " & to_string(dest) & " " & to_string(reg1) & " " & to_string(reg2);
			wait for 1 ns;
			clk <= '1';
			wait for 15 ns;
			clk <= '0';
			wait for 5 ns;
			report to_string(res);
		end loop;

		--report to_string(stmt);
		--report to_string(res);
		wait;
	end process;
end architecture;
	

