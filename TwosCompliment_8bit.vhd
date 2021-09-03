--------------------------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
--------------------------------------------------------------------
ENTITY TwosCompliment_8bit IS 
	PORT (	A_bin  				:	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
				C_out				   :  OUT 	STD_LOGIC;
				result				:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0));
	END ENTITY TwosCompliment_8bit;
ARCHITECTURE functional OF TwosCompliment_8bit IS
	SIGNAL   onecompliment : STD_LOGIC_VECTOR(7 DOWNTO 0);
	CONSTANT one_bin		  : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000001";
--------------------------------------------------------------------
BEGIN
	onecompliment <= NOT A_bin;
	Full_8_Adder_1: ENTITY work.Full_Adder_8_with_FullAdders_4
		PORT MAP (	C_in0    =>  '0',
						a		   =>	 onecompliment,
						b		   =>  one_bin,
						C_out    =>  C_out,
						S 		   =>  result);
END ARCHITECTURE functional;