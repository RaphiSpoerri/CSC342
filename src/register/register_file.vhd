


library ieee, work;
use ieee.std_logic_1164.all;
use work.machine.register32;
use work.machine.mux_4x1;

entity register_file is port (
	clk, w: in std_logic;
	sel: in std_logic_vector(1 downto 0);
	sel_q: in std_logic_vector(3 downto 0);
	d: in std_logic_vector(31 downto 0);
	q1: out std_logic_vector(31 downto 0);
	q0: out std_logic_vector(31 downto 0)
); end entity;

architecture behav of register_file is
	signal bus0, bus1, bus2, bus3: std_logic_vector(31 downto 0);
	signal w3, w2, w1, w0: std_logic; 
begin
	mux1: mux_4x1 port map(sel_q(3 downto 2), bus0, bus1, bus2, bus3, q1);
	mux0: mux_4x1 port map(sel_q(1 downto 0), bus0, bus1, bus2, bus3, q0);

	r3: register32 port map(clk => w3, d => d, q => bus3);
	r2: register32 port map(clk => w2, d => d, q => bus2);
	r1: register32 port map(clk => w1, d => d, q => bus1);
	r0: register32 port map(clk => w0, d => d, q => bus0);

	process(clk, w, sel) is begin
		w3 <= clk and w and sel(1) and sel(0);
		w2 <= clk and w and sel(1) and not sel(0);
		w1 <= clk and w and not sel(1) and sel(0); 
		w0 <= clk and w and not sel(1) and not sel(0);
	end process;
end architecture;

