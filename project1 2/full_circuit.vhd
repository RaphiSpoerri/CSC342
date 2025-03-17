library IEEE;
use IEEE.std_logic_1164.ALL;


entity full_circuit is
	generic(N: integer := 32);
	port(
		RegWr: in std_logic;
		Rw: in std_logic_vector( 4 downto 0);
		Ra: in std_logic_vector( 4 downto 0);
		Rb: in std_logic_vector( 4 downto 0);
		Clk: in std_logic;
		add_sub: in std_logic;
		result: out std_logic_vector( N-1 downto 0);
		Cout: out std_logic;
		Overflow: out std_logic
	);
end full_circuit;

architecture full_circuit_arch of full_circuit is

component register_file is
	generic(N: integer := 32);
	port(
		RegWr: in std_logic;
		Rw: in std_logic_vector( 4 downto 0);
		Ra: in std_logic_vector( 4 downto 0);
		Rb: in std_logic_vector( 4 downto 0);
		Clk: in std_logic;
		busW: in std_logic_vector( N-1 downto 0);
		busA: out std_logic_vector( N-1 downto 0);
		busB: out std_logic_vector( N-1 downto 0)
	);
end component;

component nbit_add_sub is
	 Generic(
		N: integer := 32
	 );
    Port ( A : in  std_logic_vector(N-1 downto 0);
           B : in  std_logic_vector(N-1 downto 0);
			  CarryIn: in std_logic;
			  Add_Sub: in std_logic;
           Sum : out  std_logic_vector(N-1 downto 0);
           CarryOut : out  std_logic;
			  overflow : out  std_logic
			  );
end component;

signal busA_signal, busB_signal, busW_signal: std_logic_vector(31 downto 0);

begin

	registerF: register_file port map(
		RegWr,
		Rw,
		Ra,
		Rb,
		Clk,
		busW_signal,
		busA_signal,
		busB_signal
		
	);
	
	adder: nbit_add_sub port map(
		busA_signal,
		busB_signal,
		'0',
		add_sub,
		busW_signal,
		Cout,
		Overflow
		
	);
	
	result <= busW_signal;

end full_circuit_arch;
