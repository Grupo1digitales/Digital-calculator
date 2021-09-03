
---------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
---------------------------------------------------
ENTITY Four_bit_multiplier IS 
	PORT (	in_a   	:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
				in_b		:	IN 	STD_LOGIC_VECTOR(3 DOWNTO 0);
				product	:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
				C_out		: 	OUT 	STD_LOGIC);
	END ENTITY Four_bit_multiplier;
---------------------------------------------------
ARCHITECTURE functional OF Four_bit_multiplier IS
	SIGNAL	partial_product_1, partial_product_2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	partial_product_3, partial_product_4 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL   add_1, add_2, add_3, add_4, result_1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL   result_2 									 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL	C_out_s 										 :	STD_LOGIC_VECTOR(1 DOWNTO 0);
---------------------------------------------------
BEGIN
--Partial products creation
	product_1: ENTITY work.Four_bit_partial_multiplier
		PORT MAP (in_a   			  =>  in_a,
					 in_b   			  =>  in_b(0),
					 partial_product =>  partial_product_1);
	product_2: ENTITY work.Four_bit_partial_multiplier
		PORT MAP (in_a   			  =>  in_a,
					 in_b   			  =>  in_b(1),
					 partial_product =>  partial_product_2);
	product_3: ENTITY work.Four_bit_partial_multiplier
		PORT MAP (in_a   			  =>  in_a,
					 in_b   			  =>  in_b(2),
					 partial_product =>  partial_product_3);
	product_4: ENTITY work.Four_bit_partial_multiplier
		PORT MAP (in_a   			  =>  in_a,
					 in_b   			  =>  in_b(3),
					 partial_product =>  partial_product_4);
--Partial products addition
	add_1 <= "0000" & partial_product_1;
	add_2 <= "000"  & partial_product_2 & '0';
	add_3 <= "00"  & partial_product_3  & "00";
	add_4 <= '0'  & partial_product_4  & "000";
	Full_8_Adder_1: ENTITY work.Full_Adder_8_with_FullAdders_4
		PORT MAP (	C_in0    =>  '0',
						a		   =>	 add_1,
						b		   =>  add_2,
						C_out    =>  C_out_s(0),
						S 		   =>  result_1);
	Full_8_Adder_2: ENTITY work.Full_Adder_8_with_FullAdders_4
		PORT MAP (	C_in0    =>  C_out_s(0),
						a		   =>	 result_1,
						b		   =>  add_3,
						C_out    =>  C_out_s(1),
						S 		   =>  result_2);
	Full_8_Adder_3: ENTITY work.Full_Adder_8_with_FullAdders_4
		PORT MAP (	C_in0    =>  C_out_s(1),
						a		   =>	 result_2,
						b		   =>  add_4,
						C_out    =>  C_out,
						S 		   =>  product);
END ARCHITECTURE functional;