library IEEE;
use IEEE.std_logic_1164.ALL;

entity SR_Latch_tb is
end SR_Latch_tb;

architecture SR_Latch_tb_arch of SR_Latch_tb is

component SR_Latch is
	port(
		S, R, En, Clk: in std_logic;
		Q, notQ: out std_logic
	);
end component;

signal S, R, En, Clk, Q, notQ: std_logic;

begin
	UUT: SR_Latch port map(S, R, En, Clk, Q, notQ);
	process
	begin
		En <='1';
		Clk <='1';
		S <= '0';
		R <= '0';
		wait for 10 ns;
		
		S <= '1';
		R <= '0';
		wait for 10 ns;
		
		S <= '0';
		R <= '0';
		wait for 10 ns;
		
		S <= '0';
		R <= '1';
		wait for 10 ns;
		
		S <= '0';
		R <= '0';
		wait for 10 ns;
		
		S <= '1';
		R <= '1';
		wait for 10 ns;
		
		S <= '0';
		R <= '0';
		wait for 10 ns;
	end process;
end SR_Latch_tb_arch;