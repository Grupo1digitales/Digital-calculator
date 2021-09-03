--------------------------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
--------------------------------------------------------------------
ENTITY Separator IS 
	PORT (	result 				:	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
				tenths				:  OUT 	STD_LOGIC_VECTOR(3 DOWNTO 0);
				unidades				:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
				magnitude			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0));
	END ENTITY Separator;
--------------------------------------------------------------------
ARCHITECTURE functional OF Separator IS
	SIGNAL MSB, C_trash				:	STD_LOGIC;
	SIGNAL twoscompliment_result	:	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL tenths_S 					: 	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL compare_bin				:  STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL ones, substract			:  STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL magnitude_s				:  STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	MSB <= result(7);
	Twos_compliment: ENTITY work.TwosCompliment_8bit
		PORT MAP (	A_bin   =>  result,
						C_out	  =>	C_trash,
						result  =>  twoscompliment_result); 
	WITH MSB SELECT
		magnitude_s 	 <= twoscompliment_result	WHEN '1',
							    result 						WHEN OTHERS;
	compare_bin(0) <= '1' WHEN magnitude_s < "00001010" OR magnitude_s > "00110001" ELSE '0';-- 10 comparation and 49 comparation
	compare_bin(1) <= '1' WHEN magnitude_s < "00010100" OR magnitude_s > "00111011" ELSE '0';-- 20 comparation and 59 comparation
	compare_bin(2) <= '1' WHEN magnitude_s < "00011110" OR magnitude_s > "01000101" ELSE '0';-- 30 comparation and 69 comparation
	compare_bin(3) <= '1' WHEN magnitude_s < "00101000" OR magnitude_s > "01001111" ELSE '0';-- 40 comparation AND 79 comparation
	compare_bin(4) <= '1' WHEN magnitude_s < "00110010" ELSE '0';-- 50 comparation
	WITH compare_bin SELECT
		tenths_S <= "0000" WHEN "11111",
						"0001" WHEN "11110",
						"0010" WHEN "11100",
						"0011" WHEN "11000",
						"0100" WHEN "10000",
						"0101" WHEN "00001",
						"0110" WHEN "00011",
						"0111" WHEN "00111",
						"1000" WHEN "01111",
						"1111" WHEN OTHERS;
	subs_multiplication: ENTITY work.Four_bit_multiplier
	PORT MAP (     in_a		   =>	 tenths_S,
						in_b		   =>  "1010",
						product     =>  substract,
						C_out 		=>  C_trash);
	ones_substraction: ENTITY work.Resta
	PORT MAP (     A_bin		   =>	 magnitude_s,
						B_bin		   =>  substract,
						C_out       =>  C_trash,
						result 		=>  ones);	
	WITH MSB SELECT
		tenths 	<= "1111"	WHEN '1',
						tenths_S WHEN OTHERS;
	WITH MSB SELECT
	   unidades 	<= magnitude_s(3 DOWNTO 0) WHEN '1',
							ones(3 DOWNTO 0) 			WHEN OTHERS;
	   magnitude   <= magnitude_s;
END functional;