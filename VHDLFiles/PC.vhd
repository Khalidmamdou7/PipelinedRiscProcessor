
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY PC IS
	PORT(
        clk : IN std_logic;
        input: IN std_logic_vector (19 DOWNTO 0);
        output: OUT std_logic_vector (19 downto 0)
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
