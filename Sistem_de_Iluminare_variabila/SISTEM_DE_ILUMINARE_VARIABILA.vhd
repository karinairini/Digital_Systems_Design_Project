library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity SISTEM_DE_ILUMINARE_VARIABILA is
	port(
	INTRARE:in STD_LOGIC_VECTOR(7 downto 0);
	MOD1:in STD_LOGIC;
	MOD2:in STD_LOGIC;
	MOD3:in STD_LOGIC;
	STOP:in STD_LOGIC;
	CLK:in STD_LOGIC;
	LED:out STD_LOGIC_VECTOR(7 downto 0);
	ANOD:out STD_LOGIC_VECTOR(3 downto 0);
	CATOD:out STD_LOGIC_VECTOR(6 downto 0)
	);
end entity SISTEM_DE_ILUMINARE_VARIABILA;

architecture ARH_SISTEM of SISTEM_DE_ILUMINARE_VARIABILA is

component NUMARATOR_8_BITI 
	port(
	Reset8:in STD_LOGIC;
	Enable8:in STD_LOGIC;
	CLK_8:in STD_LOGIC;
	TCU:out STD_LOGIC;
	Output:out STD_LOGIC_VECTOR (7 downto 0)
	);
end component NUMARATOR_8_BITI;

component DIVIZOR_DE_FRECVENTA is
	port(
	Reset_Div:in STD_LOGIC;
	In_Value:in STD_LOGIC_VECTOR(7 downto 0);
	CLK_Div:in STD_LOGIC;
	Out_Value_Divizata:out STD_LOGIC
	);
end component DIVIZOR_DE_FRECVENTA;

component SEMNAL_MOD2 is
	port(
	Reset_SMN2:in STD_LOGIC;
	ONE:in STD_LOGIC;
	CLK1:in STD_LOGIC;
	CLK2:in STD_LOGIC;
	TCU:out STD_LOGIC
	);
end component SEMNAL_MOD2;

component COMPARATOR is
	port(
	A:in STD_LOGIC_VECTOR (7 downto 0);
	B:in STD_LOGIC_VECTOR (7 downto 0);
	F_MIC:out STD_LOGIC
	);
end component COMPARATOR;

component AFISOR_SISTEM is
	port(
	CLK_A:in STD_LOGIC;
	C0:in STD_LOGIC_VECTOR(3 downto 0);
	C1:in STD_LOGIC_VECTOR(3 downto 0);
	C2:in STD_LOGIC_VECTOR(3 downto 0);
	C3:in STD_LOGIC_VECTOR(3 downto 0);
	ANOD:out STD_LOGIC_VECTOR(3 downto 0);
	CATOD:out STD_LOGIC_VECTOR(6 downto 0)
	);
end component AFISOR_SISTEM;

component REGISTRU 
	port(
	In_Value_R:STD_LOGIC_VECTOR(7 downto 0);
	Load:in STD_LOGIC;
	Out_Value_R:out STD_LOGIC_VECTOR(7 downto 0)
	);
end component REGISTRU;


signal Reset:STD_LOGIC := '0';

signal nr10:STD_LOGIC_VECTOR (7 downto 0) := "00001010"; 
signal nr76:STD_LOGIC_VECTOR (7 downto 0) := "01001100";
signal nr153:STD_LOGIC_VECTOR (7 downto 0) := "10011001";

signal CLK10,CLK76,CLK153:STD_LOGIC := '0';


signal TCU1_1:STD_LOGIC := '0';
signal Enable1:STD_LOGIC := '0';
signal A1,B1:STD_LOGIC_VECTOR(7 downto 0) := "00000000"; 
signal Rez_comp1:STD_LOGIC := '0';
signal SMN1:STD_LOGIC := '0';



signal CLKL_0,CLKL_1,CLKL_2,CLKL_3,CLKL_4,CLKL_5,CLKL_6,CLKL_7:STD_LOGIC := '0'; 

signal var255:STD_LOGIC_VECTOR(7 downto 0) := "11111111";
signal var2:STD_LOGIC_VECTOR(7 downto 0) := "00000010";
signal var3:STD_LOGIC_VECTOR(7 downto 0) := "00000011";
signal var4:STD_LOGIC_VECTOR(7 downto 0) := "00000100";
signal var5:STD_LOGIC_VECTOR(7 downto 0) := "00000101";
signal var6:STD_LOGIC_VECTOR(7 downto 0) := "00000110";
signal var7:STD_LOGIC_VECTOR(7 downto 0) := "00000111";
signal var8:STD_LOGIC_VECTOR(7 downto 0) := "00001000";

signal Enable2:STD_LOGIC := '0';
signal S0,S1,S2,S3,S4,S5,S6,S7:STD_LOGIC := '0';


signal CLK1_3,CLK2_3:STD_LOGIC := '0';
signal Enable3:STD_LOGIC := '0';
signal A3,B3,C3:STD_LOGIC_VECTOR(7 downto 0) := "00000000";
signal TCU1_3,TCU2_3:STD_LOGIC := '0';
signal Rez_comp3:STD_LOGIC := '0';
signal SMN3:STD_LOGIC := '0';
signal aux1:STD_LOGIC := '0'; 
signal aux2:STD_LOGIC := '1';	

signal CARAC1,CARAC2,CARAC3,CARAC4:STD_LOGIC_VECTOR (3 downto 0) := "0000";


begin										 
	Reset <= STOP or (MOD1 and MOD2) or (MOD1 and MOD3) or (MOD2 and MOD3) or (MOD1 and MOD2 and MOD3) or
	(not(INTRARE(0) or INTRARE(1) or INTRARE(2) or INTRARE(3) or INTRARE(4) or INTRARE(5) or INTRARE(6) or INTRARE(7)) and (MOD1 or MOD3)) or (not MOD1 and not MOD2 and not MOD3);	
	
	divizor1: DIVIZOR_DE_FRECVENTA port map(Reset,nr10,CLK,CLK10); -- 100ns
	divizor2: DIVIZOR_DE_FRECVENTA port map(Reset,nr76,CLK10,CLK76); -- Impart cu 76  => 7600 ns
	divizor3: DIVIZOR_DE_FRECVENTA port map(Reset,nr153,CLK10,CLK153);	-- Impart cu 153 => 15300 ns
	
	
	--MOD1 
	Enable1 <= MOD1;
	
	Registru_Mod1: REGISTRU port map(INTRARE,Enable1,A1);
	
	Numarator_Mod1: NUMARATOR_8_BITI port map(Reset,Enable1,CLK153,TCU1_1,B1);
	
	Comparare_Mod1: COMPARATOR port map(B1,A1,Rez_comp1);
	
	SMN1 <= Rez_comp1;
	
	
	--MOD2 
	Enable2 <= MOD2;
	
	--CLK pentru fiecare led in functie de timpul din cerinta
	divizor1_2: DIVIZOR_DE_FRECVENTA port map(Reset,var255,CLK153,CLKL_0);--1s
	divizor2_2: DIVIZOR_DE_FRECVENTA port map(Reset,var2,CLKL_0,CLKL_1);--2s
	divizor3_2: DIVIZOR_DE_FRECVENTA port map(Reset,var3,CLKL_0,CLKL_2);--3s
	divizor4_2: DIVIZOR_DE_FRECVENTA port map(Reset,var4,CLKL_0,CLKL_3);--4s
	divizor5_2: DIVIZOR_DE_FRECVENTA port map(Reset,var5,CLKL_0,CLKL_4);--5s
	divizor6_2: DIVIZOR_DE_FRECVENTA port map(Reset,var6,CLKL_0,CLKL_5);--6s
	divizor7_2: DIVIZOR_DE_FRECVENTA port map(Reset,var7,CLKL_0,CLKL_6);--7s
	divizor8_2: DIVIZOR_DE_FRECVENTA port map(Reset,var8,CLKL_0,CLKL_7);--8s
	
	--Semnalul pentru fiecare led 
	LED0_2: SEMNAL_MOD2 port map(Reset,Enable2,CLKL_0,CLK10,S0);
	LED1_2: SEMNAL_MOD2 port map(Reset,Enable2,CLKL_1,CLK10,S1);
	LED2_2: SEMNAL_MOD2 port map(Reset,Enable2,CLKL_2,CLK10,S2);
	LED4_2: SEMNAL_MOD2 port map(Reset,Enable2,CLKL_3,CLK10,S3);
	LED5_2: SEMNAL_MOD2 port map(Reset,Enable2,CLKL_4,CLK10,S4);
	LED6_2: SEMNAL_MOD2 port map(Reset,Enable2,CLKL_5,CLK10,S5);
	LED7_2: SEMNAL_MOD2 port map(Reset,Enable2,CLKL_6,CLK10,S6);
	LED8_2: SEMNAL_MOD2 port map(Reset,Enable2,CLKL_7,CLK10,S7);
	
	--MOD3
	Enable3 <= MOD3;
	
	Registru_Mod3: REGISTRU port map(INTRARE,Enable3,C3);

	divizor1_mod3: DIVIZOR_DE_FRECVENTA port map(Reset,var255,CLK76,CLK1_3);
	divizor2_mod3: DIVIZOR_DE_FRECVENTA port map(Reset,C3,CLK1_3,CLK2_3);
	
	Numarator1_Mod3: NUMARATOR_8_BITI port map(Reset,Enable3,CLK2_3,TCU1_3,A3);
	Numarator2_Mod3: NUMARATOR_8_BITI port map(Reset,Enable3,CLK76,TCU2_3,B3);
	
	Comparare_Mod3: COMPARATOR port map(A3,B3,Rez_comp3);
	
	Asignare_MOD3_2: process(Reset,TCU1_3) --Bistabil T
	begin
		if Reset = '1' then
				aux1 <= '1';
		elsif TCU1_3'EVENT and TCU1_3 = '1' then
				aux1 <= not aux1;
		end if;
	end process Asignare_MOD3_2;

	SMN3 <= Rez_comp3 xor aux1;
	
	
	APRINDERE_LED: process(MOD1,MOD2,MOD3,Reset)
	begin
		
		if MOD1='1' and Reset = '0' then
			LED(0) <= SMN1;
			LED(1) <= SMN1;
			LED(2) <= SMN1;
			LED(3) <= SMN1;
			LED(4) <= SMN1;
			LED(5) <= SMN1;
			LED(6) <= SMN1;
			LED(7) <= SMN1;
			CARAC1 <= "1111";
			CARAC2 <= "1111";
			CARAC3 <= "1100";
			CARAC4 <= "0001";
			
		elsif  MOD2='1' and Reset = '0' then
			LED(0) <= S0;
			LED(1) <= S1;
			LED(2) <= S2;
			LED(3) <= S3;
			LED(4) <= S4;
			LED(5) <= S5;
			LED(6) <= S6;
			LED(7) <= S7;
			CARAC1 <= "1111";
			CARAC2 <= "1111";
			CARAC3 <= "1100";
			CARAC4 <= "0010";
			
		elsif  MOD3='1' and Reset = '0' then
			LED(0) <= SMN3;
			LED(1) <= SMN3;
			LED(2) <= SMN3;
			LED(3) <= SMN3;
			LED(4) <= SMN3;
			LED(5) <= SMN3;
			LED(6) <= SMN3;
			LED(7) <= SMN3;
			CARAC1 <= "1111";
			CARAC2 <= "1111";
			CARAC3 <= "1100";
			CARAC4 <= "0011";
			
		else
			LED(0) <= '0';
			LED(1) <= '0';
			LED(2) <= '0';
			LED(3) <= '0';
			LED(4) <= '0';
			LED(5) <= '0';
			LED(6) <= '0';
			LED(7) <= '0';
			CARAC1 <= "0000";
			CARAC2 <= "0000";
			CARAC3 <= "0000";
			CARAC4 <= "0000";
			
		end if;
		
	end process APRINDERE_LED;
	
	AFISOR1: AFISOR_SISTEM port map(CLK,CARAC1,CARAC2,CARAC3,CARAC4,ANOD,CATOD);
	
end architecture ARH_SISTEM;	   
