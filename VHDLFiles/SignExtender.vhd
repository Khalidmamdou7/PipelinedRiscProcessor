LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SignExt is 
port(

  bit16 : in std_logic_vector(15 downto 0);


  bitext: out std_logic_vector (31 downto 0)
);
end entity;

architecture MySignExt of SignExt is
Begin
bitext <= "1111111111111111" & bit16 when bit16(15)='1' else
        "0000000000000000" & bit16;

end MySignExt;
