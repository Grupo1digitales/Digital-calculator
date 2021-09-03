--------------------------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
--------------------------------------------------------------------
ENTITY Error_Analyzer IS 
	PORT (	A_bin  				:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
				B_bin  				:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
				tenths  				:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
				magnitude  			:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
				c_bin					:	IN		STD_LOGIC_VECTOR(2 DOWNTO 0);
				Hex0					:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
				Hex1					:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
				Hex2					:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
				Hex3					:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0));
	END ENTITY Error_Analyzer;
---------------------------------------------------------------------
ARCHITECTURE functional OF Error_Analyzer IS
---------------------------------------------------------------------
BEGIN 
	WITH c_bin	SELECT 
		Hex0 <= "1110"	 	 WHEN	 "010",
				  "1110"	 	 WHEN	 "011",
				  "1110"	 	 WHEN	 "001",
				  "1110"	 	 WHEN	 "000",
				  A_bin	 	 WHEN  OTHERS;
	WITH c_bin	SELECT 
		Hex1 <= "1110"	 	 WHEN	 "100",
				  "1110"	    WHEN	 "101",
				  "1110"	 	 WHEN	 "001",
				  "1110"	    WHEN	 "000",
				  B_bin	 	 WHEN  OTHERS;
	WITH c_bin	SELECT 
		Hex2 <= tenths	 	 WHEN	 "111",
				  "1110"	 	 WHEN  OTHERS;	
	WITH c_bin	SELECT 
		Hex3 <= magnitude	 WHEN	 "111",
				  "1110"	 	 WHEN  OTHERS;				  
END ARCHITECTURE functional;