`include "forward_net_header.vh"
`include "typedef.vh"


module backward_net(
    input logic clk, reset, enable,
    input data_type W1[0:L2-1][0:L1-1],
    input data_type W2[0:L3-1][0:L2-1],
    input data_type W3[0:L4-1][0:L3-1],
    
    input data_type z1[0:L2-1][0:0],
    input data_type z2[0:L3-1][0:0],
    input data_type z3[0:L4-1][0:0],
    
    input data_type a1[0:L1-1][0:0], //input
    input data_type a2[0:L2-1][0:0],
    input data_type a3[0:L3-1][0:0],
    
    input data_type da4[0:L4-1][0:0],
    
    output data_type db1[0:L2-1][0:0],
    output data_type db2[0:L3-1][0:0],
    output data_type db3[0:L4-1][0:0],
    
    output data_type dW1[0:L2-1][0:L1-1],
    output data_type dW2[0:L3-1][0:L2-1],
    output data_type dW3[0:L4-1][0:L3-1]); 
    
    logic sample_data;
    
    //parameter COUNT_DELAY = 9;
    
    data_type da3[0:L3-1][0:0];
    data_type da2[0:L2-1][0:0];
    data_type da1[0:L1-1][0:0];
    
//    data_type a2[0:L2-1][0:0];
    data_type da3_delayed[0:L3-1][0:0];
    data_type da2_delayed[0:L2-1][0:0];
    data_type da1_delayed[0:L1-1][0:0];
    
//    data_type a2_delayed[0:L2-1][0:0];
//    data_type a3_delayed[0:L3-1][0:0];
//    data_type a4_delayed[0:L4-1][0:0];
//    data_type dAL_delayed[0:L4-1][0:0];
//    data_type y_ff[0:L4-1][0:0];
        

    // Backward Neuron Network
    backward_neurons #(L4, L3, "sigmoid") backward_layer_3(.clk(clk), .W(W3), .z(z3), .da_prev(da4), .a(a3), .reset(reset),.da(da3_delayed), .db(db3), .dw(dW3));
    backward_neurons #(L3, L2, "relu") backward_layer_2(.clk(clk), .W(W2), .z(z2), .da_prev(da3), .a(a2), .reset(reset),.da(da2_delayed), .db(db2), .dw(dW2));
    backward_neurons #(L2, L1, "relu") backward_layer_1(.clk(clk), .W(W1), .z(z1), .da_prev(da2), .a(a1), .reset(reset),.da(da1_delayed), .db(db1), .dw(dW1));
    
    // delayed_ff #(L3, COUNT_DELAY) backward_layer_3_delayed(.clk(clk), .reset(reset), .enable(enable), .in(da3_delayed), .out(da3));
    // delayed_ff #(L2, COUNT_DELAY) backward_layer_2_delayed(.clk(clk), .reset(reset), .enable(enable), .in(da2_delayed), .out(da2));
    // delayed_ff #(L1, COUNT_DELAY) backward_layer_1_delayed(.clk(clk), .reset(reset), .enable(enable), .in(da1_delayed), .out(da1)); // 24 is for 0 to 24 cycles -> 25 in total
    
    flip_flop  #(L3, 1) backward_layer_3_delayed(clk, reset, sample_data, da3_delayed, da3);
    flip_flop  #(L2, 1) backward_layer_2_delayed(clk, reset, sample_data, da2_delayed, da2);
    flip_flop  #(L1, 1) backward_layer_1_delayed(clk, reset, sample_data, da1_delayed, da1);
    
    forward_net_control #(COUNT_DELAY) local_control_backward(.clk(clk), .reset(reset), .enable(enable), .sample(sample_data));
    
        
    // Loss
    // loss_square_of_errors #(L4) loss(.y_hat(a4), .y(y), .se(error));
    
    // Accumulator for Cost
    // accumulator #(L4) accumulator(.in(error), .out(acc_error), .clk(clk), .reset(reset), .enable(en_acc));
    
    // Control unit
    // forward_net_control #(16) control(.clk(clk), .reset(reset), .y(en_acc));

 endmodule
 
 
 
 module backward_net_cl(
    input logic clk, reset, enable,
    input data_type W1[0:L2-1][0:L1-1],
    input data_type W2[0:L3-1][0:L2-1],
    input data_type W3[0:L4-1][0:L3-1],
    
    input data_type z1[0:L2-1][0:0],
    input data_type z2[0:L3-1][0:0],
    input data_type z3[0:L4-1][0:0],
    
    input data_type a1[0:L1-1][0:0], //input
    input data_type a2[0:L2-1][0:0],
    input data_type a3[0:L3-1][0:0],
    
    input data_type da4[0:L4-1][0:0],
    
    output data_type db1[0:L2-1][0:0],
    output data_type db2[0:L3-1][0:0],
    output data_type db3[0:L4-1][0:0],
    
    output data_type dW1[0:L2-1][0:L1-1],
    output data_type dW2[0:L3-1][0:L2-1],
    output data_type dW3[0:L4-1][0:L3-1]); 
    
    //parameter COUNT_DELAY = 9;
    
    data_type da3[0:L3-1][0:0];
    data_type da2[0:L2-1][0:0];
    data_type da1[0:L1-1][0:0];
        

    // Backward Neuron Network
    backward_neurons #(L4, L3, "sigmoid") backward_layer_3(.clk(clk), .W(W3), .z(z3), .da_prev(da4), .a(a3), .reset(reset),.da(da3), .db(db3), .dw(dW3));
    backward_neurons #(L3, L2, "relu") backward_layer_2(.clk(clk), .W(W2), .z(z2), .da_prev(da3), .a(a2), .reset(reset),.da(da2), .db(db2), .dw(dW2));
    backward_neurons #(L2, L1, "relu") backward_layer_1(.clk(clk), .W(W1), .z(z1), .da_prev(da2), .a(a1), .reset(reset),.da(da1), .db(db1), .dw(dW1));
    
 endmodule