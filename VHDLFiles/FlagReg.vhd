LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity FlagReg is 
generic (n: integer :=3);
port(
clk : in std_logic;
D : in std_logic_vector (n-1 downto 0);
Q : out std_logic_vector (n-1 downto 0)
);

end entity;
architecture myFlag of FlagReg is
component DFF is 
port(
en : in std_logic;
rst : in std_logic;
clk : in std_logic;
D : in std_logic;
Q : out std_logic);
end component;
begin
loop1: for i in 0 to n-1 generate
fx: DFF port map ('1', '0', clk, D(i), Q(i));
end generate;
end architecture;