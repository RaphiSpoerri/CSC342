library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_arith.ALL;
use IEEE.numeric_std .ALL;

library work;
use work.my_components.ALL;

entity registers_add_sub_tb is
end registers_add_sub_tb;

architecture registers_add_sub_tb_arch of registers_add_sub_tb is

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


component mux_2to1 is
    Port ( 
        sel : in  std_logic; 
        data : in  std_logic_2d_2_32; 
        result : out std_logic_vector(31 downto 0)
    );
end component;

component control_unit is
	port(
		instruction: in std_logic_vector( 31 downto 0);
		Rw: out std_logic_vector( 4 downto 0);
		Ra: out std_logic_vector( 4 downto 0);
		Rb: out std_logic_vector( 4 downto 0);
		ALUCtr: out std_logic;
		RegW: out std_logic
	);
end component;


signal Clk: std_logic;
signal MemToReg: std_logic := '0';
signal mem_reg_data: std_logic_2d_2_32 := (others => (others=>'0'));
signal busA_signal, busB_signal, busW_signal: std_logic_vector(31 downto 0) := (others=>'0');
signal RegWr, RegWrCtrl, add_sub, Cout, Overflow, ALUCtr: std_logic := '0';
signal Rw, Ra, Rb: std_logic_vector( 4 downto 0) := (others=>'0');
signal Rd, Rs, Rt: std_logic_vector( 4 downto 0) := (others=>'0');
signal result, instruction: std_logic_vector( 31 downto 0) := (others=>'0');

begin

	clock_process: process
	begin
		Clk <='1';
		wait for 5 ns;
		Clk <='0';
		wait for 5 ns;
	end process;
	
	mux2_1: mux_2to1
    port map( 
        sel =>  MemToReg,
        data =>  mem_reg_data,
        result => busW_signal
    );
	 
	 
	 cu: control_unit
		port map(
			instruction,
			Rd,
			Rs,
			Rt,
			ALUCtr,
			RegWrCtrl
		);
	

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
		mem_reg_data(0),
		Cout,
		Overflow
		
	);

	Rw <= Rd;
	Ra <= Rs;
	Rb <= Rt;
	RegWr <= RegWrCtrl;
	add_sub <= ALUCtr;
	
	
	result <= mem_reg_data(0);
	
	
	instructions_process: process
	begin
		-- initialize some registers with values
		RegWr <='1';
		MemToReg <= '1'; -- this flag is not given in the project, but we will use it to control when we want to directly write to a register, or write the value from the add_sub result
		-- numbers are hexadecimal ( 16 below is the base)
		Rw <= std_logic_vector(to_unsigned(16#0#,Rw'length));
		
		mem_reg_data(1) <= std_logic_vector(to_unsigned(16#00000203#,busW_signal'length));
--		busW_signal <= to_stdlogicvector(x"00000203")(31 downto 0);
		wait for 10 ns;
		
		Rw <= std_logic_vector(to_unsigned(16#1#,Rw'length));
		
		mem_reg_data(1) <= std_logic_vector(to_unsigned(16#00500511#,busW_signal'length));
		
		wait for 10 ns;
		
		
		

		
		-- read register 0 and 1, perform addition and store result at register 2
--		Rw <= std_logic_vector(to_unsigned(16#2#,Rw'length));
--		Ra <= std_logic_vector(to_unsigned(16#0#,Ra'length));
--		Rb <= std_logic_vector(to_unsigned(16#1#,Rb'length));
		
		instruction <= "00000000000000010001000000100000";
		
--		instruction <= std_logic_vector(to_unsigned(16#00011020#,instruction'length));
		
		wait for 10 ns;
		
	end process;
	
	
	

end registers_add_sub_tb_arch;