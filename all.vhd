
-- Author: Raphael Spoerri --

library ieee;
use ieee.std_logic_1164.all;

package spoerri_raphael is
	constant ADD: std_logic_vector(5 downto 0)  := "100000";
	constant ADDU: std_logic_vector(5 downto 0) := "100001";
	constant ADDI: std_logic_vector(5 downto 0) := "001000";
	constant ADDIU: std_logic_vector(5 downto 0):= "001001";
	constant SUB: std_logic_vector(5 downto 0)  := "100010";
	constant SUBU: std_logic_vector(5 downto 0) := "100011";
	constant r3: std_logic_vector(4 downto 0) := "00011";
	constant r2: std_logic_vector(4 downto 0) := "00010";
	constant r1: std_logic_vector(4 downto 0) := "00001";
	constant r0: std_logic_vector(4 downto 0) := "00000";
	constant unused: std_logic_vector(10 downto 0) := "00000000000";
	constant zeros32: std_logic_vector(31 downto 0) := 
		"00000000" & "00000000" & "00000000" & "00000000";
	component half_adder is port (
		lhs, rhs: in std_logic;
		cout, sum: out std_logic
	); end component;

	component full_adder is port (
		lhs, rhs: in std_logic;
		cin: in std_logic;
		cout: out std_logic;
		sum: out std_logic
	); end component;

	component adder8 is port (
		lhs, rhs: in std_logic_vector(7 downto 0);
		inv, cin: in std_logic;
		cout: out std_logic;
		sum: out std_logic_vector(7 downto 0)
	); end component;

	component alu32 is port (
		lhs, rhs: in std_logic_vector(31 downto 0);
		cin: in std_logic;
		cout: out std_logic;
		sum: inout std_logic_vector(31 downto 0)
	); end component;

	component latch1 is port(
		w, d: in std_logic;
		q: out std_logic;
		p: inout std_logic
	); end component;

	component latch8 is port (
		w: in std_logic;
		d: in std_logic_vector(7 downto 0);
		q: out std_logic_vector(7 downto 0)
	); end component;

	component register32 is port (
		w: in std_logic;
		d: in std_logic_vector(31 downto 0);
		q: out std_logic_vector(31 downto 0)
	); end component;

	component register_file is port (
		w: in std_logic;
		sel: in std_logic_vector(1 downto 0);
		d: in std_logic_vector(31 downto 0);
		sel_q1: in std_logic_vector(1 downto 0);
		q1: out std_logic_vector(31 downto 0);
		sel_q0: in std_logic_vector(1 downto 0);
		q0: out std_logic_vector(31 downto 0)
	); end component;

	component processor is port (
		clk, sub, signed, imm: in std_logic;
		reg1, dest: in std_logic_vector(1 downto 0);
		reg2: in std_logic_vector(31 downto 0);
		res: out std_logic_vector(31 downto 0);
		overflow: out std_logic
	); end component;

	component assembler is port (
		exec: in std_logic;
		stmt: in std_logic_vector(31 downto 0);
		flags: out std_logic_vector(2 downto 0);
		regs: out std_logic_vector(35 downto 0)
	); end component;


	component mux_4x1 is port (
		addr: in std_logic_vector(1 downto 0);
		bus0, bus1, bus2, bus3: in std_logic_vector(31 downto 0);
		q: out std_logic_vector(31 downto 0)
	); end component;

	component test_bench is
	end component;

	function to_string(n: std_logic_vector) return string;
end package;

package body spoerri_raphael is
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

-- Author: Raphael Spoerri --

library ieee, work;
use ieee.std_logic_1164.all;
use work.spoerri_raphael.full_adder;

entity adder8 is port (
	lhs, rhs: in std_logic_vector(7 downto 0);
	inv, cin: in std_logic;
	cout: out std_logic;
	sum: out std_logic_vector(7 downto 0)
); end entity;

architecture behav of adder8 is
	signal carry: std_logic_vector(6 downto 0);
	signal inverter: std_logic_vector(7 downto 0);
begin
	fa0: full_adder port map(lhs(0), inverter(0), cin,	  carry(0), sum(0));
	fa1: full_adder port map(lhs(1), inverter(1), carry(0), carry(1), sum(1));
	fa2: full_adder port map(lhs(2), inverter(2), carry(1), carry(2), sum(2));
	fa3: full_adder port map(lhs(3), inverter(3), carry(2), carry(3), sum(3));
	fa4: full_adder port map(lhs(4), inverter(4), carry(3), carry(4), sum(4));
	fa5: full_adder port map(lhs(5), inverter(5), carry(4), carry(5), sum(5));
	fa6: full_adder port map(lhs(6), inverter(6), carry(5), carry(6), sum(6));
	fa7: full_adder port map(lhs(7), inverter(7), carry(6), cout,	 sum(7));

	process(rhs, inv) is begin
		inverter(0) <= rhs(0) xor inv;
		inverter(1) <= rhs(1) xor inv;
		inverter(2) <= rhs(2) xor inv;
		inverter(3) <= rhs(3) xor inv;
		inverter(4) <= rhs(4) xor inv;
		inverter(5) <= rhs(5) xor inv;
		inverter(6) <= rhs(6) xor inv;
		inverter(7) <= rhs(7) xor inv;
	end process;
end architecture;



-- Author: Raphael Spoerri --

library ieee, work;

use ieee.std_logic_1164.all;
use work.spoerri_raphael.all;

entity alu32 is port (
	lhs, rhs: in std_logic_vector(31 downto 0);
	cin: in std_logic;
	cout: out std_logic;
	sum: inout std_logic_vector(31 downto 0) := zeros32
); end entity;

architecture behav of alu32 is
	signal carry: std_logic_vector(0 to 2);
begin
	a0: adder8 port map(lhs(31 downto 24), rhs(31 downto 24), cin, cin,	     carry(0), sum(31 downto 24));
	a1: adder8 port map(lhs(23 downto 16), rhs(23 downto 16), cin, carry(0), carry(1), sum(23 downto 16));
	a2: adder8 port map(lhs(15 downto 8),  rhs(15 downto 8),  cin, carry(1), carry(2), sum(15 downto 8));
	a3: adder8 port map(lhs(7 downto 0),   rhs(7 downto 0),   cin, carry(2), cout,	   sum(7 downto 0));
end architecture;



-- Author: Raphael Spoerri --

library ieee, work;
use ieee.std_logic_1164.all;
use work.spoerri_raphael.half_adder;

entity full_adder is port (
	lhs, rhs, cin: in std_logic;
	cout, sum: out std_logic
); end entity;

architecture struct of full_adder is
	signal adder_connect, carry1, carry2: std_logic;
begin
	half1: half_adder port map(lhs, rhs, carry1, adder_connect);
	half2: half_adder port map(adder_connect, cin, carry2, sum);

	process(carry1, carry2) is begin
		cout <= carry1 or carry2;
	end process;
end architecture;

-- Author: Raphael Spoerri --

library ieee;
use ieee.std_logic_1164.all;

entity half_adder is port (
	lhs, rhs: in std_logic;
	cout, sum: out std_logic
); end entity;

architecture struct of half_adder is begin
	process(lhs, rhs) is begin
		sum <= lhs xor rhs;
		cout <= lhs and rhs;
	end process;
end architecture;

-- Author: Raphael Spoerri

<<<<<<< HEAD
library ieee, work;
use ieee.std_logic_1164.all;
use work.spoerri_raphael.nor_gate;

entity latch1 is port (
	w, d: in std_logic;
	q: out std_logic := '0'
); end entity;

architecture behav of latch1 is
	signal w1: std_logic := '0';
	signal w2: std_logic := '1';
	signal conn, conn2: std_logic;
begin
	nor1: nor_gate port map(w1, conn2, conn);
	nor2: nor_gate port map(w2, conn, conn2);
	process(w, conn2) is begin
		w1 <= w and d;
		w2 <= w and not d;
		q <= conn2;
	end process;
end architecture;

=======
library ieee;
use ieee.std_logic_1164.ALL;

entity sr_latch is port(
	s, r, w: in std_logic;
	q, p: out std_logic
); end entity;

architecture struct of sr_latch is
	signal q_signal, p_signal: std_logic;
begin
	p_signal <= (s and w) nor q_signal;
	p <= p_signal;
	q_signal <= (r and w) nor p_signal;
	q <= q_signal;
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity latch1 is port(
	w, d: in std_logic;
	q, p: out std_logic
); end entity;

architecture struct of latch1 is
	component sr_latch is port(
		s, r, w: in std_logic;
		q, p: out std_logic
	); end component;

	signal not_d, p_signal, q_signal: std_logic;
begin

	not_d <= (not d);
	sr_latch_comp: sr_latch port map(d, not_d, w, q, p);
end architecture;
>>>>>>> 55b43d42fd467abd13d663fe2471b53cd97a6c27

-- Author: Raphael Spoerri --

library ieee, work;
use ieee.std_logic_1164.all;
use work.spoerri_raphael.latch1;

entity latch8 is port (
	w: in std_logic;
	d: in std_logic_vector(7 downto 0);
	q: out std_logic_vector(7 downto 0)
); end entity;

architecture behav of latch8 is begin
	ff7: latch1 port map(w, d(7), q(7));
	ff6: latch1 port map(w, d(6), q(6));
	ff5: latch1 port map(w, d(5), q(5));
	ff4: latch1 port map(w, d(4), q(4));
	ff3: latch1 port map(w, d(3), q(3));
	ff2: latch1 port map(w, d(2), q(2));
	ff1: latch1 port map(w, d(1), q(1));
	ff0: latch1 port map(w, d(0), q(0));
end architecture;

-- Author: Raphael Spoerri --

library ieee, work;
use ieee.std_logic_1164.all;
use work.spoerri_raphael.zeros32;

entity mux_4x1 is port (
	addr: in std_logic_vector(1 downto 0);
	bus0, bus1, bus2, bus3: in std_logic_vector(31 downto 0) := zeros32;
	q: out std_logic_vector(31 downto 0) := zeros32
); end entity;

architecture struct of mux_4x1 is begin
	process(addr, bus0, bus1, bus2, bus3) is begin
		foreach: for i in 0 to 31 loop
			q(i) <= (addr(0) and addr(1) and bus3(i))
				or (not addr(0) and addr(1) and bus2(i))
				or (addr(0) and not addr(1) and bus1(i))
				or (not addr(0) and not addr(1) and bus0(i));
		end loop;
	end process;
end architecture;

-- Author: Raphael Spoerri --

library ieee;
use ieee.std_logic_1164.all;

entity nor_gate is port (
	a, b: in std_logic;
	q: out std_logic
); end entity;

architecture struct of nor_gate is begin
	process(a, b) is begin
		q <= a nor b;
	end process;
end struct;

-- Author: Raphael Spoerri --

library ieee, work;
use ieee.std_logic_1164.all;

use work.spoerri_raphael.all;
entity register32 is port (
	w: in std_logic;
	d: in std_logic_vector(31 downto 0);
	q: out std_logic_vector(31 downto 0)
); end entity;

architecture behav of register32 is begin
	ff8_3: latch8 port map(w, d(31 downto 24), q(31 downto 24));
	ff8_2: latch8 port map(w, d(23 downto 16), q(23 downto 16));
	ff8_1: latch8 port map(w, d(15 downto 8), q(15 downto 8));
	ff8_0: latch8 port map(w, d(7 downto 0), q(7 downto 0));
end architecture;


-- Author: Raphael Spoerri --

library ieee, work;
use ieee.std_logic_1164.all;
use work.spoerri_raphael.all;

entity register_file is port (
	w: in std_logic;
	sel: in std_logic_vector(1 downto 0);
	d: in std_logic_vector(31 downto 0);
	sel_q1: in std_logic_vector(1 downto 0);
	q1: out std_logic_vector(31 downto 0);
	sel_q0: in std_logic_vector(1 downto 0);
	q0: out std_logic_vector(31 downto 0)
); end entity;

architecture behav of register_file is
	signal bus0, bus1, bus2, bus3: std_logic_vector(31 downto 0);
	signal w3, w2, w1, w0: std_logic; 
begin
	mux1: mux_4x1 port map(sel_q1, bus0, bus1, bus2, bus3, q1);
	mux0: mux_4x1 port map(sel_q0, bus0, bus1, bus2, bus3, q0);

	r3: register32 port map(w3, d => d, q => bus3);
	r2: register32 port map(w2, d => d, q => bus2);
	r1: register32 port map(w1, d => d, q => bus1);
	r0: register32 port map(w0, d => d, q => bus0);
	
	process(w) is begin
		w3 <= w and sel(1) and sel(0);
		w2 <= w and sel(1) and not sel(0);
		w1 <= w and not sel(1) and sel(0); 
		w0 <= w and not sel(1) and not sel(0);
	end process;
end architecture;


-- Author: Raphael Spoerri --

library ieee, work;
use ieee.std_logic_1164.all, work.spoerri_raphael.all;

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
