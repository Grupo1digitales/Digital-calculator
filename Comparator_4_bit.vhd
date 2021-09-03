LIBRARY IEEE;
USE ieee.std_logic_1164.all;
--------------------------------------------
ENTITY Comparator_4_bit IS 
	PORT(		A_bin				:	IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
				B_bin				:  IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				bin_c				:	OUT	STD_LOGIC);	
END ENTITY Comparator_4_bit;
ARCHITECTURE functional	OF Comparator_4_bit IS
BEGIN
	bin_c		<= '0' WHEN A_bin > B_bin ELSE '1';
END functional;