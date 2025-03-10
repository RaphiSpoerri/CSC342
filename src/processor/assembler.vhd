
-- Author: Raphael Spoerri --

library ieee, work;
use ieee.std_logic_1164.all, work.machine.all;

entity assembler is port (
	exec: in std_logic;
	stmt: in std_logic_vector(31 downto 0);
	flags: out std_logic_vector(2 downto 0);
	regs: out std_logic_vector(35 downto 0)
); end entity;

architecture behav of assembler is
	signal opcode: std_logic_vector(5 downto 0);
	signal rs, rt, rd: std_logic_vector(4 downto 0);
	signal imm: std_logic;
begin
	process is begin
		wait until rising_edge(exec);

		opcode <= stmt(31 downto 26);
		wait for 10 ns;
		--report to_string(opcode);
		imm <= stmt(26 + 3);
		flags(0) <= opcode(1);
		flags(1) <= not opcode(0);
		flags(2) <= opcode(3);
		rs <= stmt(25 downto 21);
		rt <= stmt(20 downto 16);
		rd <= stmt(15 downto 11);
		for i in 0 to 15 loop
			regs(i + 4) <= imm and stmt(i);
			regs(i + 20) <= '0';
		end loop;
		wait for 1 ns;
		regs(3 downto 2) <= rs(1 downto 0);
		regs(5) <= (stmt(1) and imm) or (rt(1) and not imm);
		regs(4) <= (stmt(0) and imm) or (rt(0) and not imm);
		regs(1) <= (rd(1) and not imm) or (rt(1) and imm);
		regs(0) <= (rd(0) and not imm) or (rt(0) and imm);
	end process;
end architecture;
