library IEEE;
use IEEE.STD_LOGIC_1164.all	;
use IEEE.STD_LOGIC_UNSIGNED.all; 

entity DIVIZOR_DE_FRECVENTA is
	 port(
	 	Reset_Div:in STD_LOGIC;
		In_Value:in STD_LOGIC_VECTOR(7 downto 0);
		CLK_Div:in STD_LOGIC;  
		Out_Value_Divizata:out STD_LOGIC
	     );
end DIVIZOR_DE_FRECVENTA;


architecture ARH_DIV of DIVIZOR_DE_FRECVENTA is	   

signal count:STD_LOGIC_VECTOR (7 downto 0) := "00000000";

begin
	
	process(Reset_Div,CLK_Div)
	begin
		if Reset_Div = '1' OR count = In_Value then
			count <= "00000000"; 
			Out_Value_Divizata <= '1';
		elsif CLK_Div'EVENT and CLK_Div = '1' then
			count <= count + 1;
			Out_Value_Divizata <= '0';
		end if;
	end process;

end ARH_DIV;
