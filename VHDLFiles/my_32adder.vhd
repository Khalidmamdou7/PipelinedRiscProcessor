LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY my_32adder IS
PORT (a, b : IN std_logic_vector(31 DOWNTO 0) ;
cin : IN std_logic;
addORsub : IN std_logic;
s : OUT std_logic_vector(31 DOWNTO 0);
cout : OUT std_logic);
END my_32adder;

ARCHITECTURE a_my_32adder OF my_32adder IS
COMPONENT my_adder IS
PORT( a,b,cin : IN std_logic; s,cout : OUT std_logic);
END COMPONENT;
SIGNAL temp : std_logic_vector(32 DOWNTO 0);
SIGNAL dummy : std_logic_vector(31 DOWNTO 0);
BEGIN
Temp(0) <= addORsub;
loop1: for i in 0 to 31 generate
dummy(i) <= b(i) XOR addORsub;
fx: my_adder port map (a(i), dummy(i), temp(i), s(i), temp(i+1));
end generate;
Cout <= temp(32) XOR temp(31);
END Architecture;