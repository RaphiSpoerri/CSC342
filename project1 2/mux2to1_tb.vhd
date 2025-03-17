library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_arith.ALL;
use IEEE.numeric_std .ALL;

library work;
use work.my_components.ALL;

entity mux2to1_tb is
end mux2to1_tb;

architecture mux2to1_tb_arch of mux2to1_tb is


component mux_2to1 is
    Port ( 
        sel : in  std_logic; 
        data : in  std_logic_2d_2_32; 
        result : out std_logic_vector(31 downto 0)
    );
end component;


signal Clk: std_logic;
signal mem_reg_data: std_logic_2d_2_32 := (others => (others=>'0'));
signal busW_signal: std_logic_vector(31 downto 0);
signal Cout, MemToReg: std_logic := '0';
signal temp_value: std_logic_vector(31 downto 0) := "00000000000000000000000000000010";

begin

	clock_process: process
	begin
		Clk <='0';
		wait for 5 ns;
		Clk <='1';
		wait for 5 ns;
	end process;
	
	mux2_1: mux_2to1
    port map( 
        sel =>  MemToReg,
        data =>  mem_reg_data,
        result => busW_signal
    );
	
	instructions_process: process
	begin
	
		MemToReg <='0';
--		RegWr <='1';
		wait for 10 ns;
		mem_reg_data(0) <= std_logic_vector(to_unsigned(16#00000203#,busW_signal'length));--std_logic_vector(to_unsigned(16#1#,busW_signal'length));
		wait for 10 ns;
		MemToReg <='1';
--		RegWr <='1';
		wait for 10 ns;
		mem_reg_data(1) <= std_logic_vector(to_unsigned(16#00000201#,busW_signal'length));-- std_logic_vector(to_unsigned(16#1#,busW_signal'length));
		wait for 10 ns;
		
	end process;
	
	
	

end mux2to1_tb_arch;