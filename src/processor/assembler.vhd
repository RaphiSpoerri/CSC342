
-- Author: Raphael Spoerri --

library ieee, work;
use ieee.std_logic_1164.all, work.machine.all;

entity assembler is port (
	init: in std_logic;
	exec: in std_logic;
	stmt: in std_logic_vector(31 downto 0);
	done: out std_logic
); end entity;

architecture behav of assembler is
	signal clk, sub, signed, overflow: std_logic := '0';
	signal imm: std_logic := '1';
	signal res, reg2: std_logic_vector(31 downto 0) := zeros32;
	signal reg1, dest: std_logic_vector(1 downto 0) := "00";
	signal opcode: std_logic_vector(5 downto 0);
	signal rs, rt, rd: std_logic_vector(4 downto 0);
begin
	cpu: processor port map(clk, sub, signed, imm, reg1, dest, reg2, res, overflow);

	process is begin
		wait until rising_edge(init);
		clk <= '1';
		wait for 20 ns;	
		clk <= '0';
	end process;

	process is begin
		wait until rising_edge(exec);
		done <= '0';

		opcode <= stmt(31 downto 26);
		imm <= stmt(26 + 2);
		sub <= stmt(26 + 1);
		signed <= not stmt(26);
		
		rs <= stmt(25 downto 21);
		rt <= stmt(20 downto 16);
		rd <= stmt(15 downto 11);
		for i in 0 to 15 loop
			reg2(i) <= imm and stmt(i);
			reg2(16 + i) <= '0';
		end loop;
		wait for 1 ns;
		reg1 <= rs(1 downto 0);
		reg2(1) <= (stmt(1) and imm) or (rt(1) and not imm);
		reg2(0) <= (stmt(0) and imm) or (rt(0) and not imm);
		dest(1) <= (rd(1) and not imm) or (rt(1) and imm);
		dest(0) <= (rd(0) and not imm) or (rt(0) and imm);
		wait for 1 ns;
		report to_string(reg1 & reg2 & dest);
		clk <= '1';
		wait for 15 ns;
		clk <= '0';
		done <= '1';
		
	end process;
end architecture;
