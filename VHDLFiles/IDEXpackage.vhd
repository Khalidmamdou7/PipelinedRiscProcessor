library ieee;
use ieee.std_logic_1164.all;
 
package IDEXp is
 
  type IDEXs is record
    nextInstAdd: std_logic_vector (19 downto 0);
    rd1 , rd2 , offset : std_logic_vector (31 DOWNTO 0);
    rSrc1 , rSrc2 , rDst , ALUop : std_logic_vector (2 downto 0);
    BranchSrc , MemIndex : std_logic_vector (1 downto 0);
    isBranch , ALUsrc , MovToReg , RegW , Push , pop ,
        MEMW , MEMR , RTI , RET , PCsrc2 , useMEMindex ,
        selectorForCall , selectorForINT :  std_logic;
  end record IDEXs;  
 
   
end package IDEXp;