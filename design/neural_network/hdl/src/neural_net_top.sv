`include "forward_net_header.vh"
`include "typedef.vh"


module neural_net_top(
    input logic clk,
    input logic reset,
    input logic enable,
    
    input data_type W1_00,
    input data_type W1_01,
    input data_type W1_10,
    input data_type W1_11,
    input data_type W1_20,
    input data_type W1_21,
    input data_type W1_30,
    input data_type W1_31,
    input data_type W1_40,
    input data_type W1_41,
    input data_type W2_00,
    input data_type W2_01,
    input data_type W2_02,
    input data_type W2_03,
    input data_type W2_04,
    input data_type W2_10,
    input data_type W2_11,
    input data_type W2_12,
    input data_type W2_13,
    input data_type W2_14,
    input data_type W2_20,
    input data_type W2_21,
    input data_type W2_22,
    input data_type W2_23,
    input data_type W2_24,
    input data_type W2_30,
    input data_type W2_31,
    input data_type W2_32,
    input data_type W2_33,
    input data_type W2_34,
    input data_type W2_40,
    input data_type W2_41,
    input data_type W2_42,
    input data_type W2_43,
    input data_type W2_44,
    input data_type W3_00,
    input data_type W3_01,
    input data_type W3_02,
    input data_type W3_03,
    input data_type W3_04,
    input data_type b1_00,
    input data_type b1_10,
    input data_type b1_20,
    input data_type b1_30,
    input data_type b1_40,
    input data_type b2_00,
    input data_type b2_10,
    input data_type b2_20,
    input data_type b2_30,
    input data_type b2_40,
    input data_type b3_00,
    
    output data_type W1_00_out,
    output data_type W1_01_out,
    output data_type W1_10_out,
    output data_type W1_11_out,
    output data_type W1_20_out,
    output data_type W1_21_out,
    output data_type W1_30_out,
    output data_type W1_31_out,
    output data_type W1_40_out,
    output data_type W1_41_out,
    output data_type W2_00_out,
    output data_type W2_01_out,
    output data_type W2_02_out,
    output data_type W2_03_out,
    output data_type W2_04_out,
    output data_type W2_10_out,
    output data_type W2_11_out,
    output data_type W2_12_out,
    output data_type W2_13_out,
    output data_type W2_14_out,
    output data_type W2_20_out,
    output data_type W2_21_out,
    output data_type W2_22_out,
    output data_type W2_23_out,
    output data_type W2_24_out,
    output data_type W2_30_out,
    output data_type W2_31_out,
    output data_type W2_32_out,
    output data_type W2_33_out,
    output data_type W2_34_out,
    output data_type W2_40_out,
    output data_type W2_41_out,
    output data_type W2_42_out,
    output data_type W2_43_out,
    output data_type W2_44_out,
    output data_type W3_00_out,
    output data_type W3_01_out,
    output data_type W3_02_out,
    output data_type W3_03_out,
    output data_type W3_04_out,
    output data_type b1_00_out,
    output data_type b1_10_out,
    output data_type b1_20_out,
    output data_type b1_30_out,
    output data_type b1_40_out,
    output data_type b2_00_out,
    output data_type b2_10_out,
    output data_type b2_20_out,
    output data_type b2_30_out,
    output data_type b2_40_out,
    output data_type b3_00_out);

    data_type W1[0:L2-1][0:L1-1];
    data_type W2[0:L3-1][0:L2-1];
    data_type W3[0:L4-1][0:L3-1];
    
    data_type b1[0:L2-1][0:0];
    data_type b2[0:L3-1][0:0];
    data_type b3[0:L4-1][0:0];
    
    data_type a1[0:L1-1][0:0];
    data_type y_hat[0:L4-1][0:0];
    
    data_type W1_out[0:L2-1][0:L1-1];
    data_type W2_out[0:L3-1][0:L2-1];
    data_type W3_out[0:L4-1][0:L3-1];
    data_type b1_out[0:L2-1][0:0];
    data_type b2_out[0:L3-1][0:0];
    data_type b3_out[0:L4-1][0:0];
    
    assign W1[0][0] = W1_00;
    assign W1[0][1] = W1_01;
    assign W1[1][0] = W1_10;
    assign W1[1][1] = W1_11;
    assign W1[2][0] = W1_20;
    assign W1[2][1] = W1_21;
    assign W1[3][0] = W1_30;
    assign W1[3][1] = W1_31;
    assign W1[4][0] = W1_40;
    assign W1[4][1] = W1_41;
    assign W2[0][0] = W2_00;
    assign W2[0][1] = W2_01;
    assign W2[0][2] = W2_02;
    assign W2[0][3] = W2_03;
    assign W2[0][4] = W2_04;
    assign W2[1][0] = W2_10;
    assign W2[1][1] = W2_11;
    assign W2[1][2] = W2_12;
    assign W2[1][3] = W2_13;
    assign W2[1][4] = W2_14;
    assign W2[2][0] = W2_20;
    assign W2[2][1] = W2_21;
    assign W2[2][2] = W2_22;
    assign W2[2][3] = W2_23;
    assign W2[2][4] = W2_24;
    assign W2[3][0] = W2_30;
    assign W2[3][1] = W2_31;
    assign W2[3][2] = W2_32;
    assign W2[3][3] = W2_33;
    assign W2[3][4] = W2_34;
    assign W2[4][0] = W2_40;
    assign W2[4][1] = W2_41;
    assign W2[4][2] = W2_42;
    assign W2[4][3] = W2_43;
    assign W2[4][4] = W2_44;
    assign W3[0][0] = W3_00;
    assign W3[0][1] = W3_01;
    assign W3[0][2] = W3_02;
    assign W3[0][3] = W3_03;
    assign W3[0][4] = W3_04;
    assign b1[0][0] = b1_00;
    assign b1[1][0] = b1_10;
    assign b1[2][0] = b1_20;
    assign b1[3][0] = b1_30;
    assign b1[4][0] = b1_40;
    assign b2[0][0] = b2_00;
    assign b2[1][0] = b2_10;
    assign b2[2][0] = b2_20;
    assign b2[3][0] = b2_30;
    assign b2[4][0] = b2_40;
    assign b3[0][0] = b3_00;
    
    assign W1_00_out = W1_out[0][0];
    assign W1_01_out = W1_out[0][1];
    assign W1_10_out = W1_out[1][0];
    assign W1_11_out = W1_out[1][1];
    assign W1_20_out = W1_out[2][0];
    assign W1_21_out = W1_out[2][1];
    assign W1_30_out = W1_out[3][0];
    assign W1_31_out = W1_out[3][1];
    assign W1_40_out = W1_out[4][0];
    assign W1_41_out = W1_out[4][1];
    assign W2_00_out = W2_out[0][0];
    assign W2_01_out = W2_out[0][1];
    assign W2_02_out = W2_out[0][2];
    assign W2_03_out = W2_out[0][3];
    assign W2_04_out = W2_out[0][4];
    assign W2_10_out = W2_out[1][0];
    assign W2_11_out = W2_out[1][1];
    assign W2_12_out = W2_out[1][2];
    assign W2_13_out = W2_out[1][3];
    assign W2_14_out = W2_out[1][4];
    assign W2_20_out = W2_out[2][0];
    assign W2_21_out = W2_out[2][1];
    assign W2_22_out = W2_out[2][2];
    assign W2_23_out = W2_out[2][3];
    assign W2_24_out = W2_out[2][4];
    assign W2_30_out = W2_out[3][0];
    assign W2_31_out = W2_out[3][1];
    assign W2_32_out = W2_out[3][2];
    assign W2_33_out = W2_out[3][3];
    assign W2_34_out = W2_out[3][4];
    assign W2_40_out = W2_out[4][0];
    assign W2_41_out = W2_out[4][1];
    assign W2_42_out = W2_out[4][2];
    assign W2_43_out = W2_out[4][3];
    assign W2_44_out = W2_out[4][4];
    assign W3_00_out = W3_out[0][0];
    assign W3_01_out = W3_out[0][1];
    assign W3_02_out = W3_out[0][2];
    assign W3_03_out = W3_out[0][3];
    assign W3_04_out = W3_out[0][4];
    assign b1_00_out = b1_out[0][0];
    assign b1_10_out = b1_out[1][0];
    assign b1_20_out = b1_out[2][0];
    assign b1_30_out = b1_out[3][0];
    assign b1_40_out = b1_out[4][0];
    assign b2_00_out = b2_out[0][0];
    assign b2_10_out = b2_out[1][0];
    assign b2_20_out = b2_out[2][0];
    assign b2_30_out = b2_out[3][0];
    assign b2_40_out = b2_out[4][0];
    assign b3_00_out = b3_out[0][0];
    
    data_type X0, X1, Y_in;
    logic [10:0] address;
    
    assign a1[0][0] = X0;
    assign a1[1][0] = X1;
    assign y_hat[0][0] = Y_in;
    
    top_neural_network top_neural_network(
        .clk(clk), 
        .reset(reset), 
        .enable(enable), 
        .W1(W1), 
        .W2(W2), 
        .W3(W3), 
        .b1(b1), 
        .b2(b2), 
        .b3(b3), 
        .a1(a1), 
        .y(y_hat),
        .W1_out(W1_out),
        .W2_out(W2_out),
        .W3_out(W3_out),
        .b1_out(b1_out),
        .b2_out(b2_out),
        .b3_out(b3_out),
        .address(address)
        );
    
    data_wrapper data_wrapper (
        .X0(X0), 
        .X1(X1),   
        .Y(Y_in),
        .address(address),
        .clk(clk)
        );
        
endmodule


`include "forward_net_header.vh"
`include "typedef.vh"


module neural_net_double_data_top(
    input logic clk,
    input logic reset,
    input logic enable,
    input logic [31:0] EPOCH,
    
//    input [10:0]BRAM_PORT_X0_addr,
//    input BRAM_PORT_X0_clk,
//    input [31:0]BRAM_PORT_X0_din,
//    output [31:0]BRAM_PORT_X0_dout,
//    input BRAM_PORT_X0_en,
//    input [0:0]BRAM_PORT_X0_we,
//    input [10:0]BRAM_PORT_X1_addr,
//    input BRAM_PORT_X1_clk,
//    input [31:0]BRAM_PORT_X1_din,
//    output [31:0]BRAM_PORT_X1_dout,
//    input BRAM_PORT_X1_en,
//    input [0:0]BRAM_PORT_X1_we,
//    input [10:0]BRAM_PORT_Y_addr,
//    input BRAM_PORT_Y_clk,
//    input [31:0]BRAM_PORT_Y_din,
//    output [31:0]BRAM_PORT_Y_dout,
//    input BRAM_PORT_Y_en,
//    input [0:0]BRAM_PORT_Y_we,
    
    input [31:0]BRAM_PORT_X0_addr,
    input BRAM_PORT_X0_clk,
    input [31:0]BRAM_PORT_X0_din,
    output [31:0]BRAM_PORT_X0_dout,
    input BRAM_PORT_X0_en,
    input BRAM_PORT_X0_rst,
    input [3:0]BRAM_PORT_X0_we,
    input [31:0]BRAM_PORT_X1_addr,
    input BRAM_PORT_X1_clk,
    input [31:0]BRAM_PORT_X1_din,
    output [31:0]BRAM_PORT_X1_dout,
    input BRAM_PORT_X1_en,
    input BRAM_PORT_X1_rst,
    input [3:0]BRAM_PORT_X1_we,
    input [31:0]BRAM_PORT_Y_addr,
    input BRAM_PORT_Y_clk,
    input [31:0]BRAM_PORT_Y_din,
    output [31:0]BRAM_PORT_Y_dout,
    input BRAM_PORT_Y_en,
    input BRAM_PORT_Y_rst,
    input [3:0]BRAM_PORT_Y_we,

    input data_type W1_00,
    input data_type W1_01,
    input data_type W1_10,
    input data_type W1_11,
    input data_type W1_20,
    input data_type W1_21,
    input data_type W1_30,
    input data_type W1_31,
    input data_type W1_40,
    input data_type W1_41,
    input data_type W2_00,
    input data_type W2_01,
    input data_type W2_02,
    input data_type W2_03,
    input data_type W2_04,
    input data_type W2_10,
    input data_type W2_11,
    input data_type W2_12,
    input data_type W2_13,
    input data_type W2_14,
    input data_type W2_20,
    input data_type W2_21,
    input data_type W2_22,
    input data_type W2_23,
    input data_type W2_24,
    input data_type W2_30,
    input data_type W2_31,
    input data_type W2_32,
    input data_type W2_33,
    input data_type W2_34,
    input data_type W2_40,
    input data_type W2_41,
    input data_type W2_42,
    input data_type W2_43,
    input data_type W2_44,
    input data_type W3_00,
    input data_type W3_01,
    input data_type W3_02,
    input data_type W3_03,
    input data_type W3_04,
    input data_type b1_00,
    input data_type b1_10,
    input data_type b1_20,
    input data_type b1_30,
    input data_type b1_40,
    input data_type b2_00,
    input data_type b2_10,
    input data_type b2_20,
    input data_type b2_30,
    input data_type b2_40,
    input data_type b3_00,
    
    output data_type W1_00_out,
    output data_type W1_01_out,
    output data_type W1_10_out,
    output data_type W1_11_out,
    output data_type W1_20_out,
    output data_type W1_21_out,
    output data_type W1_30_out,
    output data_type W1_31_out,
    output data_type W1_40_out,
    output data_type W1_41_out,
    output data_type W2_00_out,
    output data_type W2_01_out,
    output data_type W2_02_out,
    output data_type W2_03_out,
    output data_type W2_04_out,
    output data_type W2_10_out,
    output data_type W2_11_out,
    output data_type W2_12_out,
    output data_type W2_13_out,
    output data_type W2_14_out,
    output data_type W2_20_out,
    output data_type W2_21_out,
    output data_type W2_22_out,
    output data_type W2_23_out,
    output data_type W2_24_out,
    output data_type W2_30_out,
    output data_type W2_31_out,
    output data_type W2_32_out,
    output data_type W2_33_out,
    output data_type W2_34_out,
    output data_type W2_40_out,
    output data_type W2_41_out,
    output data_type W2_42_out,
    output data_type W2_43_out,
    output data_type W2_44_out,
    output data_type W3_00_out,
    output data_type W3_01_out,
    output data_type W3_02_out,
    output data_type W3_03_out,
    output data_type W3_04_out,
    output data_type b1_00_out,
    output data_type b1_10_out,
    output data_type b1_20_out,
    output data_type b1_30_out,
    output data_type b1_40_out,
    output data_type b2_00_out,
    output data_type b2_10_out,
    output data_type b2_20_out,
    output data_type b2_30_out,
    output data_type b2_40_out,
    output data_type b3_00_out,
    output logic [31:0] timer_lo,
    output logic [31:0] timer_hi);

    data_type W1[0:L2-1][0:L1-1];
    data_type W2[0:L3-1][0:L2-1];
    data_type W3[0:L4-1][0:L3-1];
    
    data_type b1[0:L2-1][0:0];
    data_type b2[0:L3-1][0:0];
    data_type b3[0:L4-1][0:0];
    
    data_type a1[0:L1-1][0:0];
    data_type y_hat[0:L4-1][0:0];
    
    data_type W1_out[0:L2-1][0:L1-1];
    data_type W2_out[0:L3-1][0:L2-1];
    data_type W3_out[0:L4-1][0:L3-1];
    data_type b1_out[0:L2-1][0:0];
    data_type b2_out[0:L3-1][0:0];
    data_type b3_out[0:L4-1][0:0];
    
    assign W1[0][0] = W1_00;
    assign W1[0][1] = W1_01;
    assign W1[1][0] = W1_10;
    assign W1[1][1] = W1_11;
    assign W1[2][0] = W1_20;
    assign W1[2][1] = W1_21;
    assign W1[3][0] = W1_30;
    assign W1[3][1] = W1_31;
    assign W1[4][0] = W1_40;
    assign W1[4][1] = W1_41;
    assign W2[0][0] = W2_00;
    assign W2[0][1] = W2_01;
    assign W2[0][2] = W2_02;
    assign W2[0][3] = W2_03;
    assign W2[0][4] = W2_04;
    assign W2[1][0] = W2_10;
    assign W2[1][1] = W2_11;
    assign W2[1][2] = W2_12;
    assign W2[1][3] = W2_13;
    assign W2[1][4] = W2_14;
    assign W2[2][0] = W2_20;
    assign W2[2][1] = W2_21;
    assign W2[2][2] = W2_22;
    assign W2[2][3] = W2_23;
    assign W2[2][4] = W2_24;
    assign W2[3][0] = W2_30;
    assign W2[3][1] = W2_31;
    assign W2[3][2] = W2_32;
    assign W2[3][3] = W2_33;
    assign W2[3][4] = W2_34;
    assign W2[4][0] = W2_40;
    assign W2[4][1] = W2_41;
    assign W2[4][2] = W2_42;
    assign W2[4][3] = W2_43;
    assign W2[4][4] = W2_44;
    assign W3[0][0] = W3_00;
    assign W3[0][1] = W3_01;
    assign W3[0][2] = W3_02;
    assign W3[0][3] = W3_03;
    assign W3[0][4] = W3_04;
    assign b1[0][0] = b1_00;
    assign b1[1][0] = b1_10;
    assign b1[2][0] = b1_20;
    assign b1[3][0] = b1_30;
    assign b1[4][0] = b1_40;
    assign b2[0][0] = b2_00;
    assign b2[1][0] = b2_10;
    assign b2[2][0] = b2_20;
    assign b2[3][0] = b2_30;
    assign b2[4][0] = b2_40;
    assign b3[0][0] = b3_00;
    
    assign W1_00_out = W1_out[0][0];
    assign W1_01_out = W1_out[0][1];
    assign W1_10_out = W1_out[1][0];
    assign W1_11_out = W1_out[1][1];
    assign W1_20_out = W1_out[2][0];
    assign W1_21_out = W1_out[2][1];
    assign W1_30_out = W1_out[3][0];
    assign W1_31_out = W1_out[3][1];
    assign W1_40_out = W1_out[4][0];
    assign W1_41_out = W1_out[4][1];
    assign W2_00_out = W2_out[0][0];
    assign W2_01_out = W2_out[0][1];
    assign W2_02_out = W2_out[0][2];
    assign W2_03_out = W2_out[0][3];
    assign W2_04_out = W2_out[0][4];
    assign W2_10_out = W2_out[1][0];
    assign W2_11_out = W2_out[1][1];
    assign W2_12_out = W2_out[1][2];
    assign W2_13_out = W2_out[1][3];
    assign W2_14_out = W2_out[1][4];
    assign W2_20_out = W2_out[2][0];
    assign W2_21_out = W2_out[2][1];
    assign W2_22_out = W2_out[2][2];
    assign W2_23_out = W2_out[2][3];
    assign W2_24_out = W2_out[2][4];
    assign W2_30_out = W2_out[3][0];
    assign W2_31_out = W2_out[3][1];
    assign W2_32_out = W2_out[3][2];
    assign W2_33_out = W2_out[3][3];
    assign W2_34_out = W2_out[3][4];
    assign W2_40_out = W2_out[4][0];
    assign W2_41_out = W2_out[4][1];
    assign W2_42_out = W2_out[4][2];
    assign W2_43_out = W2_out[4][3];
    assign W2_44_out = W2_out[4][4];
    assign W3_00_out = W3_out[0][0];
    assign W3_01_out = W3_out[0][1];
    assign W3_02_out = W3_out[0][2];
    assign W3_03_out = W3_out[0][3];
    assign W3_04_out = W3_out[0][4];
    assign b1_00_out = b1_out[0][0];
    assign b1_10_out = b1_out[1][0];
    assign b1_20_out = b1_out[2][0];
    assign b1_30_out = b1_out[3][0];
    assign b1_40_out = b1_out[4][0];
    assign b2_00_out = b2_out[0][0];
    assign b2_10_out = b2_out[1][0];
    assign b2_20_out = b2_out[2][0];
    assign b2_30_out = b2_out[3][0];
    assign b2_40_out = b2_out[4][0];
    assign b3_00_out = b3_out[0][0];
    
    data_type X0, X1, Y_in;
    logic [10:0] address;
    
    assign a1[0][0] = X0;
    assign a1[1][0] = X1;
    assign y_hat[0][0] = Y_in;
    
    logic [63:0] timer;
    
    assign timer_lo = timer[31:0];
    assign timer_hi = timer[63:32];
    
    top_neural_network top_neural_network(
        .clk(clk), 
        .reset(reset), 
        .enable(enable), 
        .W1(W1), 
        .W2(W2), 
        .W3(W3), 
        .b1(b1), 
        .b2(b2), 
        .b3(b3), 
        .a1(a1), 
        .y(y_hat),
        .W1_out(W1_out),
        .W2_out(W2_out),
        .W3_out(W3_out),
        .b1_out(b1_out),
        .b2_out(b2_out),
        .b3_out(b3_out),
        .address(address),
        .EPOCH(EPOCH),
        .timer(timer)
        );
    
        
   data_double_wrapper data_double_wrapper(
        .BRAM_PORT_X0_addr(BRAM_PORT_X0_addr),
        .BRAM_PORT_X0_clk(BRAM_PORT_X0_clk),
        .BRAM_PORT_X0_din(BRAM_PORT_X0_din),
        .BRAM_PORT_X0_dout(BRAM_PORT_X0_dout),
        .BRAM_PORT_X0_en(BRAM_PORT_X0_en),
        .BRAM_PORT_X0_we(BRAM_PORT_X0_we),
        .BRAM_PORT_X1_addr(BRAM_PORT_X1_addr),
        .BRAM_PORT_X1_clk(BRAM_PORT_X1_clk),
        .BRAM_PORT_X1_din(BRAM_PORT_X1_din),
        .BRAM_PORT_X1_dout(BRAM_PORT_X1_dout),
        .BRAM_PORT_X1_en(BRAM_PORT_X1_en),
        .BRAM_PORT_X1_we(BRAM_PORT_X1_we),
        .BRAM_PORT_Y_addr(BRAM_PORT_Y_addr),
        .BRAM_PORT_Y_clk(BRAM_PORT_Y_clk),
        .BRAM_PORT_Y_din(BRAM_PORT_Y_din),
        .BRAM_PORT_Y_dout(BRAM_PORT_Y_dout),
        .BRAM_PORT_Y_en(BRAM_PORT_Y_en),
        .BRAM_PORT_Y_we(BRAM_PORT_Y_we),
        .X0(X0), 
        .X1(X1),   
        .Y(Y_in),
        .address({{21{1'b0}}, address}),
        .clk(clk),
        .din(),
        .we(1'b0));

endmodule
    
