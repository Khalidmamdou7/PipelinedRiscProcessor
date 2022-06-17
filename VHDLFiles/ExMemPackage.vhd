library ieee;
use ieee.std_logic_1164.all;
 
package EXMEMp is
 
  type EXMEMs is record
    nextInstAdd: std_logic_vector (19 downto 0);
    ALUresult , rSrc1Val :  std_logic_vector (31 DOWNTO 0);
    rSrc1 , rDst , flags :  std_logic_vector (2 downto 0);
    MemIndex :  std_logic_vector (1 downto 0);
    MovToReg , RegW , Push , pop ,
        MEMW , MEMR , RTI , RET , PCsrc2 ,
        useMEMindex , selectorForCall , selectorForINT :  std_logic;
  end record EXMEMs;  
 
   
end package EXMEMp;