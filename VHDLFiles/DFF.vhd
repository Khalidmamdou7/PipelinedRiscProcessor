LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity DFF is 

port(
en : in std_logic;
rst : in std_logic;
clk : in std_logic;
D : in std_logic;
Q : out std_logic);
end entity;
architecture myDFF of DFF is
begin
process(clk, rst)
begin
if rst = '1' then
	Q <= '0';
elsif en = '1' and clk'event and clk = '1' then
	Q <= D;
end if;
end process;
end architecture;