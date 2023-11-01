library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity DECODIFICATOR is
	port(
	INTRARE:in STD_LOGIC_VECTOR(3 downto 0);
	IESIRE:out STD_LOGIC_VECTOR(6 downto 0)
	);
end entity DECODIFICATOR;

architecture ARH_DECODIFICATOR of DECODIFICATOR is
begin
	process(INTRARE)
	begin
		case INTRARE is
			when "0000" => IESIRE <= "1000000"; -- "0"     
		    when "0001" => IESIRE <= "1111001"; -- "1" 
		    when "0010" => IESIRE <= "0100100"; -- "2" 
		    when "0011" => IESIRE <= "0110000"; -- "3"
			when "1100" => IESIRE <= "1000110"; -- "C"
		    --when "0100" => IESIRE <= "0001100"; -- "P"
			--when "0101" => IESIRE <= "0010010"; -- "S"
			--when "0110" => IESIRE <= "1001111"; -- "I"
			--when "0111" => IESIRE <= "1000001"; -- "U"
			when others => IESIRE <= "1111111";
		end case;
	end process;
end architecture ARH_DECODIFICATOR;