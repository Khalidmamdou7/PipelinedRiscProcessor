LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity HazardDetection is 

port(
  
  MemR : in std_logic;
  PCwr,IDwr,stall : out std_logic;

  Rsc1 : in std_logic_vector(2 downto 0);
  Rsc2 : in std_logic_vector(2 downto 0);
  IDExdist : in std_logic_vector(2 downto 0)
  
 
);
end entity;

architecture MyHazardDetection of HazardDetection is 
Begin

stall <= '1' when ((Rsc1=IDExdist or Rsc2=IDExdist) and MemR='1' ) else
            '0' ;

PCwr <= '1' when ((Rsc1=IDExdist or Rsc2=IDExdist) and MemR='1' ) else
            '0' ;
IDwr <= '1' when ((Rsc1=IDExdist or Rsc2=IDExdist) and MemR='1' ) else
            '0' ;


end MyHazardDetection;
