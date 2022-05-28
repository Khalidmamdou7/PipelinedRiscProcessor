
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY PC IS
	PORT(
        input: IN std_logic_vector (31 DOWNTO 0);
        clk : IN std_logic;
        output: OUT std_logic_vector (31 downto 0)
		);
END ENTITY PC;

ARCHITECTURE arch_PC OF PC IS
	BEGIN

    process(clk) IS
    begin
        IF (falling_edge(clk)) THEN
            output <= input;
        END IF;



        end process;
		
		
END arch_PC;
