library ieee;
use ieee.std_logic_1164.all;
 
package IFIDp is
 
  type IFIDs is record
    inst  : std_logic_vector (31 DOWNTO 0); 
    nextInstAdd: std_logic_vector (19 downto 0);
  end record IFIDs;  
 
   
end package IFIDp;