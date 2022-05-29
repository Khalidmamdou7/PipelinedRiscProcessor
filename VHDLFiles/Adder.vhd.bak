
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY adder IS
	PORT(
        Op1: IN std_logic_vector (31 DOWNTO 0);
        Op2: IN std_logic_vector (31 downto 0);
        result: OUT std_logic_vector (31 downto 0)
		);
END ENTITY adder;

ARCHITECTURE arch_adder OF adder IS
	BEGIN
    result <= std_logic_vector(unsigned(Op1) + unsigned(Op2));
		
		
END arch_adder;
