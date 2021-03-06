LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity regfile is 
generic (n : integer := 32);
port(
  Clk,Rst : in std_logic;
  readreg1 : in std_logic_vector(2 downto 0);
  readreg2 : in std_logic_vector(2 downto 0);

  wrtreg : in std_logic_vector(2 downto 0);
  wrtdata : in std_logic_vector(31 downto 0);

  regwrite : in std_logic;
  IORead : in std_logic;

  ReadData1: out std_logic_vector (31 downto 0);
  ReadData2: out std_logic_vector (31 downto 0)
);
end entity;

architecture myregfile of regfile is

  component my_nDFF is
    GENERIC ( n : integer := 32);
    PORT( Clk,Rst,en : in std_logic;
            d : in std_logic_vector(n-1 DOWNTO 0);
            q : out std_logic_vector(n-1 DOWNTO 0)
        );
  END component;

  SIGNAL Reg0Out, Reg1Out, Reg2Out, Reg3Out, Reg4Out, Reg5Out, Reg6Out, Reg7Out : std_logic_vector (31 DOWNTO 0);
  SIGNAL w1_en_signal : std_logic_vector(7 DOWNTO 0);

  begin
    
    w1_en_signal<=  "00000001" when (wrtreg = "000" and (regwrite='1' or IORead = '1'))  else
                    "00000010" when (wrtreg = "001" and (regwrite='1' or IORead = '1'))  else
                    "00000100" when (wrtreg = "010" and (regwrite='1' or IORead = '1'))  else
                    "00001000" when (wrtreg = "011" and (regwrite='1' or IORead = '1'))  else
                    "00010000" when (wrtreg = "100" and (regwrite='1' or IORead = '1'))  else
                    "00100000" when (wrtreg = "101" and (regwrite='1' or IORead = '1'))  else
                    "01000000" when (wrtreg = "110" and (regwrite='1' or IORead = '1'))  else
                    "10000000" when (wrtreg = "111" and (regwrite='1' or IORead = '1')) else
                    "00000000";
                  

    Reg0: my_nDFF Generic Map(n)port Map (clk,Rst,w1_en_signal(0),wrtdata,Reg0Out);
    Reg1: my_nDFF Generic Map(n)port Map (clk,Rst,w1_en_signal(1),wrtdata,Reg1Out);
    Reg2: my_nDFF Generic Map(n)port Map (clk,Rst,w1_en_signal(2),wrtdata,Reg2Out);
    Reg3: my_nDFF Generic Map(n)port Map (clk,Rst,w1_en_signal(3),wrtdata,Reg3Out);
    Reg4: my_nDFF Generic Map(n)port Map (clk,Rst,w1_en_signal(4),wrtdata,Reg4Out);
    Reg5: my_nDFF Generic Map(n)port Map (clk,Rst,w1_en_signal(5),wrtdata,Reg5Out);
    Reg6: my_nDFF Generic Map(n)port Map (clk,Rst,w1_en_signal(6),wrtdata,Reg6Out);
    Reg7: my_nDFF Generic Map(n)port Map (clk,Rst,w1_en_signal(7),wrtdata,Reg7Out);


  Readdata1<= Reg0Out when (readreg1 = "000" )  else
              Reg1Out when (readreg1 = "001" )  else
              Reg2Out when (readreg1 = "010" ) else
              Reg3Out when (readreg1 = "011" ) else
              Reg4Out when (readreg1 = "100" ) else
              Reg5Out when (readreg1 = "101" ) else
              Reg6Out when (readreg1 = "110" ) else
              Reg7Out when (readreg1 = "111" );

  Readdata2<= Reg0Out when (readreg2 = "000" )  else
              Reg1Out when (readreg2 = "001" )  else
              Reg2Out when (readreg2 = "010" ) else
              Reg3Out when (readreg2 = "011" ) else
              Reg4Out when (readreg2 = "100"   ) else
              Reg5Out when (readreg2 = "101"   ) else
              Reg6Out when (readreg2 = "110"   ) else
              Reg7Out when (readreg2 = "111"   );

              
              

end myregfile ;



