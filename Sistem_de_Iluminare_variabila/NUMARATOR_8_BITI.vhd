library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

entity NUMARATOR_8_BITI is
	port(
	Reset8:in STD_LOGIC;
	Enable8:in STD_LOGIC;
	CLK_8:in STD_LOGIC;
	TCU:out STD_LOGIC;
	Output:out STD_LOGIC_VECTOR (7 downto 0)
	);
end NUMARATOR_8_BITI;

architecture ARH_NUMARATOR_8_BITI of NUMARATOR_8_BITI is   

signal count: STD_LOGIC_VECTOR (7 downto 0) := "00000000"; 

begin
	process(Reset8,Enable8,CLK_8)
	begin
		if Enable8 = '1' then
			if Reset8 = '1' or count = "11111111" then
				count <= "00000000";
				TCU <= '0';
			elsif count = "11111111" then
				count <= "00000000";
				TCU <= '1';
			elsif CLK_8'EVENT and CLK_8 = '1' then
				count <= count + 1;	
				TCU <= '0';
			end if;
		end if;	
	end process;
	
	Output <= count;	
	
end ARH_NUMARATOR_8_BITI;
	
