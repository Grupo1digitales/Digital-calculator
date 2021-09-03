--Jairo Esteban Acevedo Fajardo
---------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
---------------------------------------------------
ENTITY Full_Adder_4_with_FullAdders IS 
	PORT (	C_in0	     :	IN			STD_LOGIC;
				a			  :	IN			STD_LOGIC_VECTOR(3 DOWNTO 0);--Each bit represents a corrsponding bit for the number
				b			  :	IN			STD_LOGIC_VECTOR(3 DOWNTO 0);--Each bit represents a corrsponding bit for the number
				C_out      :	OUT		STD_LOGIC;
				S			  :	OUT		STD_LOGIC_VECTOR(3 DOWNTO 0));
	END ENTITY Full_Adder_4_with_FullAdders;
---------------------------------------------------
ARCHITECTURE behaviour OF Full_Adder_4_with_FullAdders IS
	SIGNAL	input_0, input_1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL	input_2, input_3 : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL	C_out_s			  : STD_LOGIC_VECTOR(2 DOWNTO 0);
---------------------------------------------------
BEGIN
	input_0 <= a(0) & b(0) & C_in0;
   Full_Adder_1: ENTITY work.full_adder_with_select
	PORT MAP (input   =>  input_0,--concatenate the C_in with a(0) and b(0)
	          C_out   =>  C_out_s(0),
				 S 		=>  S(0));
	input_1 <= a(1) & b(1) & C_out_s(0);
   Full_Adder_2: ENTITY work.full_adder_with_select
	PORT MAP (input   =>  input_1,--concatenate the C_out(0) with a(1) and b(1)
	          C_out   =>  C_out_s(1),
				 S 		=>  S(1));
	input_2 <= a(2) & b(2) & C_out_s(1);
   Full_Adder_3: ENTITY work.full_adder_with_select
	PORT MAP (input   =>  input_2,--concatenate the C_out(1) with a(2) and b(2)
	          C_out   =>  C_out_s(2),
				 S 		=>  S(2));
	input_3 <= a(3) & b(3) & C_out_s(2);
   Full_Adder_4: ENTITY work.full_adder_with_select
	PORT MAP (input   =>  input_3,--concatenate the C_out(2) with a(3) and b(3)
	          C_out   =>  C_out,
				 S 		=>  S(3));
END ARCHITECTURE behaviour;