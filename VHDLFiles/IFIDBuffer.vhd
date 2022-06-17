LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

use work.IFIDp.all;

ENTITY IFIDBuffer IS 
	PORT ( CLK: IN std_logic;
            IF_flush, IF_write: IN std_logic;
            IFIDs_in: IN IFIDs;
            IFIDs_out: OUT IFIDs
            );
END IFIDBuffer;


ARCHITECTURE arch_IFIDBuffer OF IFIDBuffer is
	BEGIN
    process(clk, IF_flush, IF_Write) IS
    begin
        IF (falling_edge(clk) and IF_write = '0') THEN
            IFIDs_out <= IFIDs_in;
        END IF;
        IF (IF_FLUSH = '1') THEN
            IFIDs_out.inst <= X"00000000";
            IFIDs_out.nextInstAdd <= X"00000";
        END IF;



        end process;
		
		
  
END arch_IFIDBuffer;