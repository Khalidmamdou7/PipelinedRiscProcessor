LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY pipelineBuffer IS 
	Generic ( n : Integer:=64);
	PORT ( CLK: IN std_logic;
            input: IN std_logic_vector (n-1 DOWNTO 0);
            output: OUT std_logic_vector (n-1 DOWNTO 0)
            );
END pipelineBuffer;


ARCHITECTURE arch_pipelineBuffer OF pipelineBuffer is
	BEGIN
    process(clk) IS
    begin
        IF (rising_edge(clk)) THEN
            output <= input;
        END IF;



        end process;
		
		
  
END arch_pipelineBuffer;

