Library ieee;
Use ieee.std_logic_1164.all;

USE work.IFIDp.all;
use work.IDEXp.all;
use work.EXMEMp.all;
use work.MEMWBp.all;

Entity Processor IS
    PORT (
        clk, RST: IN std_logic
    );
END Processor;

ARCHITECTURE arch_Processor OF Processor IS
    
    COMPONENT FetchStage IS
        PORT (
            clk: IN std_logic;
        PCsrc1, PCsrc2: IN std_logic;
        Mem_ReadData: IN std_logic_vector(31 downto 0);
        BranchAddressResult: IN std_logic_vector(19 downto 0);
        NextInstAdd: OUT std_logic_vector (19 DOWNTO 0);
        InstAdd: OUT std_logic_vector (19 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT DecodeStage IS
        PORT (
            clk: IN std_logic;
            rst: IN std_logic;
            Inst: IN std_logic_vector (31 DOWNTO 0);
            MEMWB_rDst, MEMWB_rSrc1: IN std_logic_vector (2 DOWNTO 0);
            MEMWB_writeData: IN std_logic_vector (31 DOWNTO 0);
            MEMWB_regW: IN std_logic;
            ReadD1, ReadD2, offset: OUT std_logic_vector (31 DOWNTO 0);
            IFID_rSrc1, IFID_rSrc2, IFID_rDst: OUT std_logic_vector (2 DOWNTO 0);
            ALUop: OUT std_logic_vector (2 DOWNTO 0);
            BranchSrc: OUT std_logic_vector (1 DOWNTO 0);
            isBranch, ALUsrc, MemToReg, RegWrite, Push, Pop, MemR, MemW,
             RTI, RET,  PCsrc2, UseMemIndex, selectorforCALL, selectorforINT: OUT std_logic;
            MemIndex: OUT std_logic_vector (1 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT EXEstage IS
        PORT(
            clk : IN std_logic;
            isBranch: IN std_logic;
            BranchSrc: IN std_logic_vector(1 downto 0);

            ALUsrc : IN std_logic;
            ALUOperation : IN std_logic_vector (2 DOWNTO 0);

            NextInstAddress : IN std_logic_vector (19 DOWNTO 0);
            ReadData1 : IN std_logic_vector (31 DOWNTO 0);
            ReadData2 : IN std_logic_vector (31 DOWNTO 0);
            SignExtend : IN std_logic_vector (31 DOWNTO 0);

            ALUresult : OUT std_logic_vector (31 DOWNTO 0);
            Flags : OUT std_logic_vector (2 DOWNTO 0);
            Rsrc1Val : OUT std_logic_vector (31 DOWNTO 0);
            BranchAddressResult : OUT std_logic_vector (19 DOWNTO 0);
            PCsrc1: OUT std_logic

        );
    END COMPONENT;
    
    COMPONENT MEMstage IS
        PORT(
            clk : IN std_logic;
            rst : IN std_logic;

            
            Rsrc1Val : in std_logic_vector(31 DOWNTO 0);
            ALUresult_in : in std_logic_vector(31 DOWNTO 0);
            ALUflags : in std_logic_vector(2 DOWNTO 0);
            NextInstAddress : in std_logic_vector(19 DOWNTO 0);

            
            ALUresult_out : OUT std_logic_vector(31 DOWNTO 0);

            Push : IN std_logic;
            Pop : IN std_logic;
            UseMemIndex : IN std_logic;
            MemIndex: IN STD_logic_vector(1 downto 0);
            selectorforCALL : IN std_logic;
            selectorforINT : IN std_logic;

            sp_address : OUT std_logic_vector(19 DOWNTO 0);
            address : OUT std_logic_vector(19 DOWNTO 0);
            WriteData : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT WBstage IS
        PORT(
            MemToReg: IN std_logic;
            ReadDfromMem, aluResult: IN std_logic_vector (31 downto 0);
            WBresult: OUT std_logic_vector (31 downto 0)
        );
    END COMPONENT;

    COMPONENT Memory IS
        PORT(
            clk : IN std_logic;
            MemWrite  : IN std_logic;
            MemRead  : IN std_logic;
            Push  : IN std_logic;
            Pop  : IN std_logic;
            address : IN  std_logic_vector(19 DOWNTO 0);
            PCAddress : IN std_logic_vector(19 DOWNTO 0);
            SPAddress : IN std_logic_vector(19 DOWNTO 0);
            WriteData  : IN  std_logic_vector(31 DOWNTO 0);
            ReadData : OUT std_logic_vector(31 DOWNTO 0);
            ReadPCData : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT IFIDBuffer IS 
        PORT ( CLK: IN std_logic;
                IF_flush, IF_write: IN std_logic;
                IFIDs_in: IN IFIDs;
                IFIDs_out: OUT IFIDs
        );
    END COMPONENT;
    COMPONENT IDEXBuffer IS 
        PORT ( CLK: IN std_logic;
                IDEXs_in: IN IDEXs;
                IDEXs_out: OUT IDEXs
                );
    END COMPONENT;
    COMPONENT ExMemBuffer IS 
        PORT ( CLK: IN std_logic;
                EXMEMs_in : IN EXMEMs;
                EXMEMs_out : OUT EXMEMs
                );
    END COMPONENT;
    COMPONENT MemWbBuffer IS 
        PORT ( CLK: IN std_logic;
                memwbs_in: in memwbs;
                memwbs_out: out memwbs

                );
    END COMPONENT;
    
    
    SIGNAL IFIDs_in, IFIDs_out: IFIDs;
    SIGNAL IDEXs_in, IDEXs_out: IDEXs;
    SIGNAL EXMEMs_in, EXMEMs_out: EXMEMs;
    SIGNAL MEMWBs_in, MEMWbs_out: MEMWBs;

    SIGNAL IF_flush, IF_write, pcSrc1: std_logic;
    SIGNAL s_InstAdd, s_BranchAddressResult, s_spAddress, s_address: std_logic_vector(19 downto 0);
    SIGNAL s_writeData, s_WBresult: std_logic_vector(31 downto 0);


    BEGIN

        myIFIDbuffer: IFIDbuffer PORT MAP (clk, IF_flush, IF_write, IFIDs_in, IFIDs_out);
        myIDEXbuffer: IDEXbuffer PORT MAP (clk, IDEXs_in, IDEXs_out);
        myExMemBuffer: ExMemBuffer PORT MAP (clk, EXMEMs_in, EXMEMs_out);
        myMemWbBuffer: MEMWBbuffer PORT MAP (CLK, memwbs_in, memwbs_out);

        myFetchStage: FetchStage PORT MAP (clk,
                pcSrc1, ExMEMs_out.pcSrc2,
                MEMWBs_in.MemRD, s_BranchAddressResult,
                IFIDs_in.nextInstAdd, s_InstAdd);
        
        myDecodeStage: DecodeStage PORT MAP (clk, rst, 
                IFIDs_out.inst, MEMWBs_out.rDst, MEMWBs_out.rSrc1,
                s_WBresult,
                MEMWBs_out.RegW, IDEXs_in.rd1, IDEXs_in.rd2, IDEXs_in.offset,
                IDEXs_in.rSrc1, IDEXs_in.rSrc2, IDEXs_in.rDst,
                IDEXs_in.ALUop, IDEXs_in.BranchSrc, IDEXs_in.isBranch, 
                IDEXs_in.ALUsrc, IDEXs_in.MovToReg, IDEXs_in.RegW, 
                IDEXs_in.push, IDEXs_in.pop, IDEXs_in.memR, IDEXs_in.memW, 
                IDEXs_in.rti, IDEXs_in.ret, IDEXs_in.pcSrc2, IDEXs_in.UseMemIndex,
                IDEXs_in.selectorforCALL, IDEXs_in.selectorforINT,
                IDEXs_in.MemIndex);

        IDEXs_in.nextInstAdd <= IFIDs_out.nextInstAdd;

        ExMems_in.nextInstAdd <= IDEXs_out.nextInstAdd;
        ExMEMs_in.rSrc1 <= IDEXs_out.rSrc1;
        ExMEMs_in.rDst <= IDEXs_out.rDst;
        ExMEMs_in.MemIndex <= IDEXs_out.MemIndex;
        ExMEMs_in.MovToReg <= IDEXs_out.MovToReg;
        ExMEMs_in.RegW <= IDEXs_out.RegW;
        ExMEMs_in.push <= IDEXs_out.push;
        ExMEMs_in.pop  <= IDEXs_out.pop;
        ExMEMs_in.MemW <= IDEXs_out.MemW;
        ExMEMs_in.MemR <= IDEXs_out.MemR;
        ExMEMs_in.RTI <= IDEXs_out.RTI;
        ExMEMs_in.RET <= IDEXs_out.RET;
        ExMEMs_in.pcSrc2 <= IDEXs_out.pcSrc2;
        ExMEMs_in.useMemIndex <= IDEXs_out.useMemIndex;
        ExMEMs_in.selectorForCall <= IDEXs_out.selectorForCall;
        ExMEMs_in.selectorForINT <= IDEXs_out.selectorForINT;

        MemWBs_in.rSrc1 <= ExMEMs_out.rSrc1;
        MemWBs_in.rDst <= ExMEMs_out.rDst;
        MemWBs_in.MovToReg <= ExMEMs_out.MovToReg;
        MemWBs_in.RegW <= ExMEMs_out.RegW;




        myExStage: EXEstage PORT MAP (clk, IDEXs_out.isBranch, IDEXs_out.BranchSrc,
                IDEXs_out.ALUsrc, IDEXs_out.ALUop, 
                IDEXs_out.nextInstAdd, IDEXs_out.rd1,
                IDEXs_out.rd2, IDEXs_out.offset, 
                ExMEMs_in.ALUresult, ExMEMs_in.flags, 
                ExMEMs_in.rSrc1Val, s_BranchAddressResult,
                pcSrc1);
        myMemStage: MEMstage PORT MAP (clk, rst,
                ExMEMs_out.rSrc1Val, ExMEMs_out.ALUresult, 
                ExMEMs_out.flags, ExMEMs_out.nextInstAdd, 
                MEMWBs_in.ALUresult, 
                ExMEMs_out.push, ExMEMs_out.pop, 
                ExMEMs_out.useMemIndex, ExMEMs_out.MemIndex, 
                ExMEMs_out.selectorForCall, ExMEMs_out.selectorForINT, 
                s_spAddress, s_address, s_writeData);
        myWbStage: WBstage PORT MAP (MEMWBs_out.MovToReg, 
                MEMWBs_out.MemRD, MEMWBs_out.ALUresult, 
                s_writeData);

        myMemory: Memory PORT MAP (clk, ExMEMs_out.MemW, 
                ExMEMs_out.MemR, ExMEMs_out.push, 
                ExMEMs_out.pop, s_address, s_InstAdd, s_spAddress,
                s_writeData, MEMWBs_in.MemRD, ReadPCData => IFIDs_in.inst);

        
        
        

END arch_Processor;
