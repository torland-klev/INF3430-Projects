// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.2 (win64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
// Date        : Wed Nov 08 10:12:48 2017
// Host        : IFI-DEARNE running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub M:/pc/Desktop/INF3430/INF3430-Lab-4/Vivado/ram_lab4/ram_lab4_stub.v
// Design      : ram_lab4
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_2,Vivado 2015.2" *)
module ram_lab4(clka, rsta, ena, wea, addra, dina, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,rsta,ena,wea[3:0],addra[9:0],dina[31:0],douta[31:0]" */;
  input clka;
  input rsta;
  input ena;
  input [3:0]wea;
  input [9:0]addra;
  input [31:0]dina;
  output [31:0]douta;
endmodule
