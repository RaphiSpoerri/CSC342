
-- Author: Raphael Spoerri --

library ieee, work;
use ieee.std_logic_1164.all, work.machine.all;

entity assembler is port (
	clk: in std_logic;
	stmt: in std_logic_vector(31 downto 0);
	res: out std_logic_vector(31 downto 0);
	overflow: out std_logic
); end entity;

architecture behav of assembler is
	signal sel_w: std_logic_vector(1 downto 0) := "00";
	signal sel_r: std_logic_vector(3 downto 0) := "0000";
	signal r_in, r_out1, r_out0, rhs: std_logic_vector(31 downto 0) := zeros32;
	signal sum, num: std_logic_vector(31 downto 0);
	signal inv, uint, imm, cout: std_logic := '0';

	
	signal opcode: std_logic_vector(5 downto 0);
	signal rs, rt, rd: std_logic_vector(4 downto 0);
	signal w: std_logic := '0';

begin
	registers: register_file port map(w, sel_w, sel_r, sum, r_out1, r_out0);
	alu: alu32 port map(r_out1, rhs, inv, cout, r_in);

	process is begin
		wait until rising_edge(clk);
		
		sum <= zeros32;
		r_in <= sum;
		sel_w <= "00";
		sel_r <= "0000";
		w <= '1';
		wait for 5 ns;
		report to_string((w) & sel_w & sel_r & sum) & ":" & to_string(r_out0);
		w <= '0';

		opcode <= stmt(31 downto 26);
		wait for 5 ns;
		imm <= opcode(2);
		inv <= opcode(1);
		uint <= opcode(0);
		num(15 downto 0) <= stmt(15 downto 0);
		rs <= stmt(25 downto 21);
		rt <= stmt(20 downto 16);
		rd <= stmt(15 downto 11);
		wait for 5 ns;
		
		report to_string(sel_w & rd & rt & (imm)) & ":" & to_string(sel_r & (clk, w)) & ":" 
			& to_string(r_out0) & ":" & to_string(r_out1);
		sel_w(1) <= '0';--(rd(1) and not imm) or (rt(1) and imm);
		sel_w(0) <= '0';--(rd(0) and not imm) or (rt(0) and imm);
		sel_r <= rt(1 downto 0) & rs(1 downto 0);
		wait for 5 ns;
		for i in 0 to 31 loop
			rhs(i) <= (r_out0(i) and not imm) or (num(i) and imm);
			wait for 1 ns;
		end loop;
		
		report to_string(sel_w & rd & rt & (imm)) & ":" & to_string(sel_r & (clk, w)) & ":" 
			& to_string(r_out0) & ":" & to_string(r_out1);
		
		if clk = '1' and (opcode(4) /= '0' or opcode(3) /= '0') then
			report "Unsupported instruction " & to_string(opcode) severity error;
		end if;
		
		report  to_string(sel_w & sel_r & (clk, w)) & ":" & to_string(rhs) & ":" & to_string(r_out1);
		
		report to_string(rhs) & ":" & to_string(num) & ":" & to_string(r_in);
		report to_string(sel_r);
		report to_string(r_out1) & ":" & to_string(r_out0);
	
		res <= r_in;
		r_in <= sum;
		wait;
	end process;
end architecture;
