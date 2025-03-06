
-- Author: Raphael Spoerri --

library ieee, work;
use ieee.std_logic_1164.all, work.machine.all;

entity processor is port (
	clk: in std_logic;
	stmt: in std_logic_vector(31 downto 0);
	res: out std_logic_vector(31 downto 0);
	overflow: out std_logic
); end entity;

architecture behav of processor is
	signal sel: std_logic_vector(5 downto 0);
	signal r_in, r_out1, r_out0, rhs: std_logic_vector(31 downto 0);
	signal inv, uint, imm, cout: std_logic;

	
	signal opcode: std_logic_vector(5 downto 0);
	signal rs, rt, rd: std_logic_vector(4 downto 0);
	signal num: std_logic_vector(15 downto 0);
	signal w: std_logic;

begin
	registers: register_file port map(clk, w, sel(1 downto 0), sel(5 downto 2), d => r_in, q1 => r_out1, q0 => r_out0);
	alu: alu32 port map(r_out1, rhs, inv, cout, r_in);

	process(clk) is begin
		w <= '0';
		opcode <= stmt(31 downto 26);
		rs <= stmt(25 downto 21);
		rt <= stmt(20 downto 16);
		rd <= stmt(15 downto 11);
		num <= stmt(15 downto 0);
		if opcode(4) /= '0' or opcode(3) /= '0' then
			report "Unsupported instruction " & to_string(opcode) severity error;
		end if;

		imm <= opcode(2);
		inv <= opcode(1);
		uint <= opcode(0);
		sel(1) <= (rd(1) and not imm) or (rt(1) and imm);
		sel(0) <= (rd(0) and not imm) or (rt(0) and imm);
		sel(3 downto 2) <= rs(1 downto 0);
		sel(5 downto 4) <= rt(1 downto 0);
		for i in 0 to 31 loop
			rhs(i) <= (r_out0(i) and not imm) or (num(i) and imm);
		end loop;
		w <= '1';


	end process;
end architecture;
