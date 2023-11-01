library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity REGISTRU is
	port(
	In_Value_R:in STD_LOGIC_VECTOR(7 downto 0);
	Load:in STD_LOGIC;
	Out_Value_R:out STD_LOGIC_VECTOR(7 downto 0)
	);
end entity REGISTRU;

architecture ARH_REGISTRU of REGISTRU is

begin
	process(In_Value_R,Load)
	begin
		if Load = '1' then
			Out_Value_R <= In_Value_R;
		else
			Out_Value_R <= (others => '0');
		end if;
	end process;
	
end architecture ARH_REGISTRU;