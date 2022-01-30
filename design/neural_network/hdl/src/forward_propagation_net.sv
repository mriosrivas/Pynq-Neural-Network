`include "forward_net_header.vh"
`include "typedef.vh"


module forward_propagation_net(
    input logic clk, reset, enable,
    input data_type W1[0:L2-1][0:L1-1],
    input data_type W2[0:L3-1][0:L2-1],
    input data_type W3[0:L4-1][0:L3-1],
    
    input data_type a1[0:L1-1][0:0], //input
    
    input data_type b1[0:L2-1][0:0],
    input data_type b2[0:L3-1][0:0],
    input data_type b3[0:L4-1][0:0],
    
    input data_type y[0:L4-1][0:0],
    
    output data_type a2[0:L2-1][0:0],
    output data_type a3[0:L3-1][0:0],
    output data_type a4[0:L4-1][0:0], //output
    output data_type dAL[0:L4-1][0:0],
    output double_data_type cost[0:L4-1][0:0],
    output data_type z1[0:L2-1][0:0],
    output data_type z2[0:L3-1][0:0],
    output data_type z3[0:L4-1][0:0]); 
    
    data_type W1_ff[0:L2-1][0:L1-1];
    data_type W2_ff[0:L3-1][0:L2-1];
    data_type W3_ff[0:L4-1][0:L3-1];
    
    data_type a1_ff[0:L1-1][0:0]; //input
    
    data_type b1_ff[0:L2-1][0:0];
    data_type b2_ff[0:L3-1][0:0];
    data_type b3_ff[0:L4-1][0:0];
    
    data_type y_ff[0:L4-1][0:0];
    
    data_type a4_ff[0:L4-1][0:0]; //output
    data_type loss_ff[0:L4-1][0:0]; 
    
    logic sample_data, en;
    
    

    // Block of input flip flops
    flip_flop  #(L2, L1) flip_flop_W1(clk, reset, en, W1, W1_ff);
    flip_flop  #(L3, L2) flip_flop_W2(clk, reset, en, W2, W2_ff);
    flip_flop  #(L4, L3) flip_flop_W3(clk, reset, en, W3, W3_ff);
    flip_flop  #(L1, 1) flip_flop_a1(clk, reset, en, a1, a1_ff);
    flip_flop  #(L2, 1) flip_flop_b1(clk, reset, en, b1, b1_ff);
    flip_flop  #(L3, 1) flip_flop_b2(clk, reset, en, b2, b2_ff);
    flip_flop  #(L4, 1) flip_flop_b3(clk, reset, en, b3, b3_ff);
    flip_flop  #(L4, 1) flip_flop_y(clk, reset, en, y, y_ff);
    
    // Forward Network
    forward_net forward_net(.clk(clk), .reset(reset), .enable(enable), .W1(W1_ff), .W2(W2_ff), .W3(W3_ff), 
                .a1(a1_ff), .b1(b1_ff), .b2(b2_ff), .b3(b3_ff), .y(y_ff), .a2(a2), .a3(a3), .a4(a4_ff), .dAL(dAL), .z1(z1), .z2(z2), .z3(z3));
    
    // Block of output flip flops
    flip_flop  #(L4, 1) flip_flop_a4(clk, reset, en, a4_ff, a4);
    //flip_flop  #(L4, 1) flip_flop_error(clk, reset, en, loss_ff, loss); Removed
    
    // Loss accumulator
    //accumulator #(L4) loss_accumulator(.in(dAL), .out(cost), .clk(clk), .reset(reset_acc), .enable(en_acc));
    
    // Control unit
    forward_net_control #(COUNT_DELAY) control(.clk(clk), .reset(reset), .enable(enable), .sample(sample_data));
    
    assign en = enable&sample_data; 

 endmodule