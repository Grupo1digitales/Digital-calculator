---------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
---------------------------------------------------
ENTITY Resta IS
PORT (	A_bin    :	IN			STD_LOGIC_VECTOR(7 DOWNTO 0);
			B_bin		:	IN			STD_LOGIC_VECTOR(7 DOWNTO 0);
			C_out    :  OUT      STD_LOGIC;
			result   :	OUT		STD_LOGIC_VECTOR(7 DOWNTO 0));
END ENTITY Resta;
ARCHITECTURE behaviour OF Resta IS
	SIGNAL	p0 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL   P1 : STD_lOGIC;
---------------------------------------------------
BEGIN
twos_complement: ENTITY work.TwosCompliment_8bit
PORT MAP ( A_bin  => B_bin,
           C_out  => p1,
			  result => p0);

Full_Adder_8: ENTITY work.Full_Adder_8_with_FullAdders_4
PORT MAP (C_in0	     => '0'	,
				a			  => A_bin,
				b			  => p0,
				C_out      => C_out,
				S			  =>result);
END ARCHITECTURE behaviour;
