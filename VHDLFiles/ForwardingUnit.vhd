LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ForwardingUnit is 

port(
  
  Rsc1 : in std_logic_vector(2 downto 0);
  Rsc2 : in std_logic_vector(2 downto 0);
  EMRdist : in std_logic_vector(2 downto 0);
  MWBRdist : in std_logic_vector(2 downto 0);


  EMRegwrite : in std_logic;
  MWBRegwrite : in std_logic;


  ForwardA: out std_logic_vector (1 downto 0);
  ForwardB: out std_logic_vector (1 downto 0)
);
end entity;

architecture MyForwardingUnit of ForwardingUnit is 
Begin

ForwardA <= "11" when (Rsc1=MWBRdist and MWBRegwrite='1') else
            "10" when (Rsc1=EMRdist and EMRegwrite='1') else
            "01" ;

ForwardB <= "11" when (Rsc2=MWBRdist and MWBRegwrite='1') else
            "10" when (Rsc2=EMRdist and EMRegwrite='1') else
            "01" ;

end MyForwardingUnit;