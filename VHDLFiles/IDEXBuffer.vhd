LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

use work.IDEXp.all;

ENTITY IDEXBuffer IS 
	PORT ( CLK: IN std_logic;
            IDEXs_in: IN IDEXs;
            IDEXs_out: OUT IDEXs
            );
END IDEXBuffer;


ARCHITECTURE arch_IDEXBuffer OF IDEXBuffer is
	BEGIN
    process(clk) IS
    begin
        IF (falling_edge(clk)) THEN
            IDEXs_out <= IDEXs_in;
         END IF;
        



        end process;
		
		
  
END arch_IDEXBuffer;