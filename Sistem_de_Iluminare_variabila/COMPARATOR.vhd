library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity COMPARATOR is
	port(
	A:in STD_LOGIC_VECTOR (7 downto 0);
	B:in STD_LOGIC_VECTOR (7 downto 0);
	F_MIC:out STD_LOGIC
	);
end entity COMPARATOR;

architecture ARH_COMPARATOR of COMPARATOR is

begin
	process(A,B)
	begin 
		if A < B then
			F_MIC <= '1';
		elsif A >= B then
			F_MIC <= '0';
	  	end if;	 
	end process;
	
end architecture ARH_COMPARATOR;