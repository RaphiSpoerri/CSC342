library IEEE;
use IEEE.std_logic_1164.ALL;

entity control_unit is
	port(
		instruction: in std_logic_vector( 31 downto 0);
		Rw: out std_logic_vector( 4 downto 0);
		Ra: out std_logic_vector( 4 downto 0);
		Rb: out std_logic_vector( 4 downto 0);
		ALUCtr: out std_logic;
		RegW: out std_logic
	);
end control_unit;


architecture control_unit_arch of control_unit is

begin
	
		ALUCtr <= instruction(1);
	
		RegW <= instruction(5);
		 
		Rw <= instruction(15 downto 11);
		
		Rb <= instruction(20 downto 16);
		
		Ra <= instruction(25 downto 21);
	


end control_unit_arch;