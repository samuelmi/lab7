`timescale 1ns / 1ps
`default_nettype none

module datapath #(
    parameter Nloc = 32,                      // Number of memory locations
    parameter Dbits = 32  
)(
    input wire clock,
    input wire [$clog2(Nloc)-1 : 0] ReadAddr1, ReadAddr2, WriteAddr,
    input wire [Dbits-1 : 0] WriteData, 
    input wire RegWrite, 
    input wire [4:0] ALUFN,
    output wire [Dbits-1 : 0] ALUResult, ReadData1, ReadData2,
    output wire FlagZ
    );
    
    ALU #(Dbits) myAlu(
        .A(ReadData1), 
        .B(ReadData2), 
        .R(ALUResult),
        .ALUfn(ALUFN),
        .FlagZ);
        
    register_file #(Nloc, Dbits) myRegister(
        .clock(clock),
        .wr(RegWrite),
        .ReadAddr1,
        .ReadAddr2,
        .WriteAddr,
        .WriteData,
        .ReadData1,
        .ReadData2);

    
endmodule
