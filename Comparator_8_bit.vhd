--------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
--------------------------------------------
ENTITY Comparator_8_bit IS 
	PORT(		A_bin			      :	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
				B_bin					:  IN    STD_LOGIC_VECTOR(7 DOWNTO 0);
				binc_3				:	OUT	STD_LOGIC);		
END ENTITY Comparator_8_bit;
ARCHITECTURE functional	OF Comparator_8_bit IS
BEGIN
	binc_3			 <= '0' WHEN A_bin > B_bin ELSE '1';
END functional;