library IEEE;	
use IEEE.STD_LOGIC_1164.all	;
use IEEE.STD_LOGIC_UNSIGNED.all; 

entity SEMNAL_MOD2 is
	port(
	Reset_SMN2:in STD_LOGIC;
	ONE:in STD_LOGIC;
	CLK1:in STD_LOGIC;
	CLK2:in STD_LOGIC;
	TCU:out STD_LOGIC
	);
end SEMNAL_MOD2;

architecture ARH_SEMNAL_MOD2 of SEMNAL_MOD2 is 

component NUMARATOR_8_BITI	
	port(
	Reset8:in STD_LOGIC;
	Enable8:in STD_LOGIC;
	CLK_8:in STD_LOGIC;
	TCU:out STD_LOGIC;
	Output:out STD_LOGIC_VECTOR(7 downto 0)
	);
end component NUMARATOR_8_BITI;

component COMPARATOR 
	port(
	A:in STD_LOGIC_VECTOR(7 downto 0);
	B:in STD_LOGIC_VECTOR(7 downto 0);
	F_MIC:out STD_LOGIC
	);
end component COMPARATOR;

signal TCU1,TCU2: STD_LOGIC := '0';

signal A,B: STD_LOGIC_VECTOR (7 downto 0) := "00000000";

signal Rez_Comp: STD_LOGIC := '0';

begin
	
	Numarator1: NUMARATOR_8_BITI port map (Reset_SMN2,ONE,CLK1,TCU1,A);
	Numarator2: NUMARATOR_8_BITI port map(Reset_SMN2,ONE,CLK2,TCU2,B);
	
	Comparare: COMPARATOR port map (A,B,Rez_Comp);
	
	SEMNAL2: process (Rez_Comp,Reset_SMN2) 
	begin
		if Rez_Comp = '1' or Reset_SMN2 = '1' then
			TCU <= '0';
		elsif Rez_Comp = '0' then
			TCU <= '1';
		end if;	
	end process SEMNAL2;	   
	
end ARH_SEMNAL_MOD2;