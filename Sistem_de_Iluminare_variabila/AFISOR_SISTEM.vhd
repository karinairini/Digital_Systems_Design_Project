library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity AFISOR_SISTEM is
	port(
	CLK_A:in STD_LOGIC;
	C0:in STD_LOGIC_VECTOR(3 downto 0);
	C1:in STD_LOGIC_VECTOR(3 downto 0);
	C2:in STD_LOGIC_VECTOR(3 downto 0);
	C3:in STD_LOGIC_VECTOR(3 downto 0);
	ANOD:out STD_LOGIC_VECTOR(3 downto 0);
	CATOD:out STD_LOGIC_VECTOR(6 downto 0)
	);
end entity AFISOR_SISTEM;


architecture ARH_AFISOR_SISTEM of AFISOR_SISTEM is

component DECODIFICATOR
	port(
	INTRARE:in STD_LOGIC_VECTOR(3 downto 0);
	IESIRE:out STD_LOGIC_VECTOR(6 downto 0)
	);
end component DECODIFICATOR;

signal count:STD_LOGIC_VECTOR(19 downto 0) := (others => '0');
signal anod_aux:STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal SEL:STD_LOGIC_VECTOR(1 downto 0) := "00";

begin
	process(CLK_A)
	begin
		if CLK_A'EVENT and CLK_A = '1' then
			count <= count + 1;
		end if;
	end process;
	
	SEL <= count(19 downto 18);
	
	process(SEL)
	begin
		case SEL is
			when "00" => anod_aux <= C0; ANOD <= "0111";
			when "01" => anod_aux <= C1; ANOD <= "1011";
			when "10" => anod_aux <= C2; ANOD <= "1101";
			when "11" => anod_aux <= C3; ANOD <= "1110";
			when others => anod_aux <= "1111"; ANOD <= "0000";
		end case;
	end process;
	
	afisare: DECODIFICATOR port map(anod_aux,CATOD);
	
end architecture ARH_AFISOR_SISTEM;