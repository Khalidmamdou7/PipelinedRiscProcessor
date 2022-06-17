LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

use work.MEMWBp.all;

ENTITY MemWbBuffer IS 
	PORT ( CLK: IN std_logic;
            memwbs_in: in memwbs;
            memwbs_out: out memwbs

            );
END MemWbBuffer;


ARCHITECTURE arch_MemWbBuffer OF MemWbBuffer is
	BEGIN
    process(clk) IS
    begin
        IF (falling_edge(clk)) THEN
            memwbs_out <= memwbs_in;
            
         END IF;
        



        end process;
		
		
  
END arch_MemWbBuffer;