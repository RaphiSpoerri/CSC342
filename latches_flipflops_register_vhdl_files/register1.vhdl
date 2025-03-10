library IEEE;
use IEEE.std_logic_1164.ALL;

entity register1 is
	port(
		D: in std_logic_vector( 3 downto 0);
		Clk: in std_logic;
		En: in std_logic;
		Q: out std_logic_vector( 3 downto 0)
	);
end register1;
	
architecture register1_arch of register1 is
	component D_FlipFlop_RE is
		port(
			D, En, Clk: in std_logic;
			Q, notQ: out std_logic
		);
	end component;
	
	begin
		D0_FF: D_FlipFlop_RE port map(
			D => D(0),
			En => En,
			Clk => Clk,
			Q => Q(0)
		);
		D1_FF: D_FlipFlop_RE port map(
			D => D(1),
			En => En,
			Clk => Clk,
			Q => Q(1)
		);
		D2_FF: D_FlipFlop_RE port map(
			D => D(2),
			En => En,
			Clk => Clk,
			Q => Q(2)
		);
		D3_FF: D_FlipFlop_RE port map(
			D => D(3),
			En => En,
			Clk => Clk,
			Q => Q(3)
		);
	end register1_arch;