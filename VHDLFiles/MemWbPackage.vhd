library ieee;
use ieee.std_logic_1164.all;
 
package MEMWBp is
 
  type MEMWBs is record
    ALUresult , MemRD :   std_logic_vector (31 DOWNTO 0);
    rSrc1 , rDst :   std_logic_vector (2 downto 0);
    MovToReg , RegW :   std_logic;
  end record MEMWBs;  
 
   
end package MEMWBp;