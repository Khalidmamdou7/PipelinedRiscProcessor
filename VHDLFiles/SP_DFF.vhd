LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY SP_DFF IS
    PORT( d,clk,rst,en : IN std_logic; q : OUT std_logic);
END SP_DFF;


ARCHITECTURE a_SP_DFF OF SP_DFF IS
BEGIN
    PROCESS(clk,rst)
    BEGIN
        IF(rst = '1') THEN
            q <= '1';
        ELSIF ((falling_edge(clk) OR rising_edge(clk)) and en='1') THEN 
            q <= d;
        END IF;
        
    END PROCESS;
END a_SP_DFF;
