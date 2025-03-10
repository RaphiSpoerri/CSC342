library IEEE;
use IEEE.std_logic_1164.ALL;

entity D_Latch_tb is
end D_Latch_tb;

architecture D_Latch_tb_arch of D_Latch_tb is

component D_Latch is
	port(
		D, En, Clk: in std_logic;
		Q, notQ: out std_logic
	);
end component;

signal D, En, Clk, Q, notQ: std_logic;

begin
	UUT: D_Latch port map(D, En, Clk, Q, notQ);
	process
	begin
		En <='1';
		Clk <='1';
		D <= '0';
		wait for 10 ns;
		
		D <= '1';
		wait for 10 ns;
		
		D <= '0';
		Clk <='0';
		wait for 10 ns;
		
		D <= '1';
		wait for 10 ns;
		
		En <= '0';
		wait for 10 ns;
		
		D <='0';
		wait for 10 ns;
		
		En <= '0';
		wait for 10 ns;
	end process;
end D_Latch_tb_arch;