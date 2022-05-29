LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity InOutPort is 
generic (n : integer := 32);
port(

  IOWrite : in std_logic;

  Outport : in std_logic_vector(31 downto 0);


  Inport: inout std_logic_vector (31 downto 0)
);
end entity;

architecture MyPort of InOutPort is
Begin
Inport <= Outport when IOWrite='1';

end MyPort;
