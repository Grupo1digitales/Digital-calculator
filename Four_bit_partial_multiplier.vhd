--Full Adder, based upon a multiplexer perspective
--by using a whith select writing
--Jairo Esteban Acevedo Fajardo
---------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
---------------------------------------------------
ENTITY Four_bit_partial_multiplier IS 
	PORT (	in_a   				:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
				in_b					:	IN		STD_LOGIC;
				partial_product	:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0));
	END ENTITY Four_bit_partial_multiplier;
---------------------------------------------------
ARCHITECTURE gatelevel OF Four_bit_partial_multiplier IS
---------------------------------------------------
BEGIN 
		partial_product(0) <=	in_a(0) AND in_b;
		partial_product(1) <=	in_a(1) AND in_b;
		partial_product(2) <=	in_a(2) AND in_b;
		partial_product(3) <=	in_a(3) AND in_b;
END ARCHITECTURE gatelevel;