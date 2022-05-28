LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY pipelineBuffer IS 
	Generic ( n : Integer:=32);
	PORT ( input: IN std_logic_vector (n-1 DOWNTO 0);
            CLK: IN std_logic;
            output: OUT std_logic_vector (n-1 DOWNTO 0)
            );
END pipelineBuffer;


ARCHITECTURE arch_pipelineBuffer OF pipelineBuffer is
	BEGIN
    process(clk) IS
    begin
        IF (falling_edge(clk)) THEN
            output <= input;
        END IF;



        end process;
		
		
  
END arch_pipelineBuffer;

