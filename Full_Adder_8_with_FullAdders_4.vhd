--Jairo Esteban Acevedo Fajardo
---------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
---------------------------------------------------
ENTITY Full_Adder_8_with_FullAdders_4 IS 
	PORT (	C_in0	     :	IN			STD_LOGIC;
				a			  :	IN			STD_LOGIC_VECTOR(7 DOWNTO 0);--Each bit represents a corresponding bit for the number
				b			  :	IN			STD_LOGIC_VECTOR(7 DOWNTO 0);--Each bit represents a corresponding bit for the number
				C_out      :	OUT		STD_LOGIC;
				S			  :	OUT		STD_LOGIC_VECTOR(7 DOWNTO 0));
	END ENTITY Full_Adder_8_with_FullAdders_4;
---------------------------------------------------
ARCHITECTURE behaviour OF Full_Adder_8_with_FullAdders_4 IS
	SIGNAL	input_0, input_1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	input_2, input_3 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	C_out_s			  : STD_LOGIC;
---------------------------------------------------
BEGIN
	input_0 <= a(3 DOWNTO 0);
	input_1 <= b(3 DOWNTO 0);
   Full_4_Adder_1: ENTITY work.Full_Adder_4_with_FullAdders
	PORT MAP (C_in0   =>  C_in0,
				 a		   =>	 input_0,
				 b		   =>  input_1,
	          C_out   =>  C_out_s,
				 S 		=>  S(3 DOWNTO 0));
				 input_2 <= a(7 DOWNTO 4);
				 input_3 <= b(7 DOWNTO 4);
   Full_4_Adder_2: ENTITY work.Full_Adder_4_with_FullAdders
	PORT MAP (C_in0   =>  C_out_s,
				 a			=>	 input_2,
				 b		   =>  input_3,
	          C_out   =>  C_out,
				 S 		=>  S(7 DOWNTO 4));
END ARCHITECTURE behaviour;