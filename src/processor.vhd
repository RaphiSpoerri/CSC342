library ieee;
use ieee.std_logic_1164.all;

package processor is
	
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
		sum: out std_logic_vector(31 downto 0)
	); end component;

	component nor_gate is port (
		a, b: in std_logic;
		q: out std_logic
	); end component;

	component flipflop1 is port (
		clk, d: in std_logic;
		q: out std_logic := '0'
	); end component;

	component flipflop8 is port (
		clk: in std_logic;
		d: in std_logic_vector(7 downto 0);
		q: out std_logic_vector(7 downto 0)
	); end component;

	component register32 is port (
		clk: in std_logic;
		d: in std_logic_vector(31 downto 0);
		q: out std_logic_vector(31 downto 0)
	); end component;

	component register_file is port (
		w: in std_logic;
		sel_d, sel_q1, sel_q0: in std_logic_vector(1 downto 0);
		d: in std_logic_vector(31 downto 0);
		q1, q0: out std_logic_vector(31 downto 0)
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

package body processor is
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
