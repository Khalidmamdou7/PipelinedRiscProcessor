LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY SP_reg IS
    PORT(
        d : IN std_logic_vector (19 DOWNTO 0);
        clk : IN std_logic;
        rst : IN std_logic;
        en : IN std_logic;
        q : OUT std_logic_vector (19 DOWNTO 0)
    );
END SP_reg;


ARCHITECTURE a_SP_reg OF SP_reg IS
COMPONENT SP_DFF IS
PORT( d,clk,rst,en : IN std_logic; q : OUT std_logic);
END COMPONENT;
BEGIN
loop1: FOR i IN 0 TO 19 GENERATE
 fx: SP_DFF PORT MAP(d(i),Clk,Rst,en,q(i));
END GENERATE;
END a_SP_reg;