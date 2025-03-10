library IEEE;
use IEEE.std_logic_1164.ALL;

entity D_FlipFlop_rising_edge_tb is
end D_FlipFlop_rising_edge_tb;

architecture D_FlipFlop_rising_edge_tb_arch of D_FlipFlop_rising_edge_tb is

component D_FlipFlop_RE is
	port(
		D, En, Clk: in std_logic;
		Q, notQ: out std_logic
	);
end component;

signal D, En, Clk, Q, notQ: std_logic;

begin
	UUT: D_FlipFlop_RE port map(D, En, Clk, Q, notQ);
	process
	  begin
		 clk <= '0';
		 wait for 4 ns;
		 clk <= '1';
		 wait for 4 ns;
	  end process;
	process
	begin
		En <='1';
		D <= '0';
		wait for 10 ns;
		
		D <= '1';
		wait for 10 ns;
				
		D <= '0';
		wait for 10 ns;
		
		wait;
				
	end process;
end D_FlipFlop_rising_edge_tb_arch;