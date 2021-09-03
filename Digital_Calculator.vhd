--Jairo Esteban Acevedo Fajardo
---------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
---------------------------------------------------
ENTITY Digital_Calculator IS 
	PORT (	A_in	     :	IN			STD_LOGIC_VECTOR(3 DOWNTO 0);
				B_in		  :	IN			STD_LOGIC_VECTOR(3 DOWNTO 0);--Each bit represents a corresponding bit for the number
				Sel		  :	IN			STD_LOGIC_VECTOR(1 DOWNTO 0);--Each bit represents a corresponding bit for the number
				Hex0 		  :	OUT		STD_LOGIC_VECTOR(6 DOWNTO 0);
				Hex1 		  :	OUT		STD_LOGIC_VECTOR(6 DOWNTO 0);
				Hex2 		  :	OUT		STD_LOGIC_VECTOR(6 DOWNTO 0);
				Hex3		  :	OUT		STD_LOGIC_VECTOR(6 DOWNTO 0));
	END ENTITY Digital_Calculator;
---------------------------------------------------
ARCHITECTURE behaviour OF Digital_Calculator IS
	SIGNAL binc_1, binc_2, binc_3,C_trash   		  : STD_LOGIC;
	SIGNAL c_bin 											  : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL sum_result, sub_result, x_result,result : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL A_in_s, B_in_s, magnitude					  : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL unidades, tenths, Hex0_s, Hex1_s		  : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL Hex2_s, Hex3_s			       			  : STD_LOGIC_VECTOR(3 DOWNTO 0);	
	CONSTANT number_81									  : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01010001";
	CONSTANT number_9										  : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1001";
BEGIN
	A_in_s <= "0000" & A_in;
	B_in_s <= "0000" & B_in;
	Sum_8bit: ENTITY work.Full_Adder_8_with_FullAdders_4
	PORT MAP (	   C_in0    =>  '0',
						a		   =>	 A_in_s,
						b		   =>  B_in_s,
						C_out    =>  C_trash,
						S 		   =>  sum_result);
	Substract_8bit: ENTITY work.Resta
	PORT MAP (     A_bin		   =>	 A_in_s,
						B_bin		   =>  B_in_s,
						C_out       =>  C_trash,
						result 		=>  sub_result);
	Multiplier_4bit: ENTITY work.Four_bit_multiplier
	PORT MAP (     in_a		   =>	 A_in,
						in_b		   =>  B_in,
						product     =>  x_result,
						C_out 		=>  C_trash);
	WITH Sel SELECT
		result <= x_result    WHEN "00",
					 sub_result  WHEN "01",
					 x_result    WHEN "10",
					 sum_result  WHEN OTHERS;
	Separator: ENTITY work.Separator
	PORT MAP (     result	      =>	 result,
						tenths		   =>  tenths,
						unidades       =>  unidades,
						magnitude 		=>  magnitude);
	LesstA_4bit: ENTITY work.Comparator_4_bit
	PORT MAP (		A_bin          => A_in,
						B_bin          => number_9,
						bin_c          => binc_1);
	LesstB_4bit: ENTITY work.Comparator_4_bit
	PORT MAP (		A_bin          => B_in,
						B_bin          => number_9,
						bin_c          => binc_2);
	LesstC_4bit: ENTITY work.Comparator_8_bit
	PORT MAP (		A_bin          => magnitude,
						B_bin          => number_81,
						binc_3          => binc_3);
	c_bin <= binc_1 &  binc_2  &  binc_3;
	Error_Analyzer : ENTITY work.Error_Analyzer
	PORT MAP(		A_bin				=> A_in,
						B_bin				=>	B_in,
						tenths			=> tenths,
						magnitude		=> unidades,
						c_bin				=> c_bin,
						Hex0				=> Hex3_s,
						Hex1				=> Hex2_s,
						Hex2				=> Hex1_s,
						Hex3				=> Hex0_s);
	bin_to_sseg_0: ENTITY work.bin_to_sseg
	PORT MAP(		bin				=> Hex0_s,
						sseg				=> Hex0);
	bin_to_sseg_1: ENTITY work.bin_to_sseg
	PORT MAP(		bin   			=> Hex1_s,
						sseg				=> Hex1);
	bin_to_sseg_2: ENTITY work.bin_to_sseg
	PORT MAP(		bin				=> Hex2_s,
						sseg				=> Hex2);
	bin_to_sseg_3: ENTITY work.bin_to_sseg
	PORT MAP(		bin				=> Hex3_s,
						sseg				=> Hex3);
END behaviour;
