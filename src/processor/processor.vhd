

-- Author: Raphael Spoerri --

library ieee, work;
use ieee.std_logic_1164.all, work.spoerri_raphael.all;

entity processor is port (
	clk, sub, signed, imm: in std_logic;
	reg1, dest: in std_logic_vector(1 downto 0);
	reg2: in std_logic_vector(31 downto 0);
	res: out std_logic_vector(31 downto 0);
	overflow: out std_logic
); end entity;

architecture behav of processor is
	signal sel_o0: std_logic_vector(1 downto 0) := "00";
	signal r_in, r_out1, r_out0, lhs, rhs: std_logic_vector(31 downto 0) := zeros32;
	signal sum: std_logic_vector(31 downto 0);
	signal cout, w: std_logic := '0';


begin
	registers: register_file port map(w, dest, r_in, reg1, r_out1, reg2(1 downto 0), r_out0);
	alu: alu32 port map(lhs, rhs, sub, cout, r_in);

	process is begin
		wait until rising_edge(clk);
		lhs <= r_out1;
		for i in 0 to 31 loop
			rhs(i) <= (imm and reg2(i)) or ((not imm) and r_out0(i));
		end loop;
		wait for 5 ns;
		report to_string(rhs);
		res <= r_in;
		overflow <= cout and signed;
		w <= '1';
		wait for 5 ns;
		w <= '0';

		
	end process;
end architecture;
