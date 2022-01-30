`include "forward_net_header.vh"
`include "typedef.vh"


//module backward_propagation_net(        
//    input logic clk, reset, enable,
        
//    input data_type W1[0:L2-1][0:L1-1],
//    input data_type W2[0:L3-1][0:L2-1],
//    input data_type W3[0:L4-1][0:L3-1],
    
//    input data_type z1[0:L2-1][0:0],
//    input data_type z2[0:L3-1][0:0],
//    input data_type z3[0:L4-1][0:0],
    
//    input data_type a1[0:L1-1][0:0],
//    input data_type a2[0:L2-1][0:0],
//    input data_type a3[0:L3-1][0:0],
    
//    input data_type da4[0:L4-1][0:0],
    
//    output data_type db1[0:L2-1][0:0],
//    output data_type db2[0:L3-1][0:0],
//    output data_type db3[0:L4-1][0:0],
    
//    output data_type dW1[0:L2-1][0:L1-1],
//    output data_type dW2[0:L3-1][0:L2-1],
//    output data_type dW3[0:L4-1][0:L3-1]);
    
//    parameter COUNT_DELAY = 9;
//    logic en_acc, reset_acc;
    
//    // Input Flip Flops
//    data_type W1_ff_1[0:L2-1][0:L1-1];
//    data_type W1_ff_2[0:L2-1][0:L1-1];
//    data_type W1_ff_3[0:L2-1][0:L1-1];
    
//    data_type W2_ff_1[0:L3-1][0:L2-1];
//    data_type W2_ff_2[0:L3-1][0:L2-1];
    
//    data_type W3_ff[0:L4-1][0:L3-1];
    
//    data_type z1_ff_1[0:L2-1][0:0];
//    data_type z1_ff_2[0:L2-1][0:0];
//    data_type z1_ff_3[0:L2-1][0:0];
    
//    data_type z2_ff_1[0:L3-1][0:0];
//    data_type z2_ff_2[0:L3-1][0:0];
    
//    data_type z3_ff[0:L4-1][0:0];
    
//    data_type a1_ff_1[0:L1-1][0:0];
//    data_type a1_ff_2[0:L1-1][0:0];
//    data_type a1_ff_3[0:L1-1][0:0];
    
//    data_type a2_ff_1[0:L2-1][0:0];
//    data_type a2_ff_2[0:L2-1][0:0];
    
//    data_type a3_ff[0:L3-1][0:0];
//    data_type da4_ff[0:L4-1][0:0];
    
//    // Output Flip Flops
//    data_type dW1_ff[0:L2-1][0:L1-1];
//    data_type dW2_ff[0:L3-1][0:L2-1];
//    data_type dW3_ff[0:L4-1][0:L3-1];
//    data_type db1_ff[0:L2-1][0:0];
//    data_type db2_ff[0:L3-1][0:0];
//    data_type db3_ff[0:L4-1][0:0];
    
//    // Accumulators
//    double_data_type acc_dW1[0:L2-1][0:L1-1];
    
          
//     // Block of input flip flops
//     // Three delay
//    flip_flop  #(L2, L1) flip_flop_W1_1(clk, reset, en, W1, W1_ff_1);
//    flip_flop  #(L2, L1) flip_flop_W1_2(clk, reset, en, W1_ff_1, W1_ff_2);
//    flip_flop  #(L2, L1) flip_flop_W1_3(clk, reset, en, W1_ff_2, W1_ff_3);
    
//    // Two delay
//    flip_flop  #(L3, L2) flip_flop_W2_1(clk, reset, en, W2, W2_ff_1); //x2
//    flip_flop  #(L3, L2) flip_flop_W2_2(clk, reset, en, W2_ff_1, W2_ff_2);
    
//    flip_flop  #(L4, L3) flip_flop_W3(clk, reset, en, W3, W3_ff);
    
//    // Three delay
//    flip_flop  #(L2, 1) flip_flop_z1_1(clk, reset, en, z1, z1_ff_1); //x3
//    flip_flop  #(L2, 1) flip_flop_z1_2(clk, reset, en, z1_ff_1, z1_ff_2);
//    flip_flop  #(L2, 1) flip_flop_z1_3(clk, reset, en, z1_ff_2, z1_ff_3);
    
//    // Two delay
//    flip_flop  #(L3, 1) flip_flop_z2_1(clk, reset, en, z2, z2_ff_1); //x2
//    flip_flop  #(L3, 1) flip_flop_z2_2(clk, reset, en, z2_ff_1, z2_ff_2);
    
//    flip_flop  #(L4, 1) flip_flop_z3(clk, reset, en, z3, z3_ff);
    
//    flip_flop  #(L1, 1) flip_flop_a1_1(clk, reset, en, a1, a1_ff_1); //x3
//    flip_flop  #(L1, 1) flip_flop_a1_2(clk, reset, en, a1_ff_1, a1_ff_2);
//    flip_flop  #(L1, 1) flip_flop_a1_3(clk, reset, en, a1_ff_2, a1_ff_3);
    
//    flip_flop  #(L2, 1) flip_flop_a2_1(clk, reset, en, a2, a2_ff_1); //x2
//    flip_flop  #(L2, 1) flip_flop_a2_2(clk, reset, en, a2_ff_1, a2_ff_2);
    
//    flip_flop  #(L3, 1) flip_flop_a3(clk, reset, en, a3, a3_ff);
//    flip_flop  #(L4, 1) flip_flop_da4(clk, reset, en, da4, da4_ff);
        
    
//    // Block of output flip flops
//    flip_flop  #(L2, L1) flip_flop_dW1(clk, reset, en, dW1_ff, dW1);
//    flip_flop  #(L3, L2) flip_flop_dW2(clk, reset, en, dW2_ff, dW2);
//    flip_flop  #(L4, L3) flip_flop_dW3(clk, reset, en, dW3_ff, dW3);
//    flip_flop  #(L2, 1) flip_flop_db1(clk, reset, en, db1_ff, db1);
//    flip_flop  #(L3, 1) flip_flop_db2(clk, reset, en, db2_ff, db2);
//    flip_flop  #(L4, 1) flip_flop_db3(clk, reset, en, db3_ff, db3); 
      
//     // instantiate device under test   
//    backward_net backward_net(.clk(clk), .reset(reset), .enable(enable), .W1(W1_ff_3), .W2(W2_ff_2), .W3(W3_ff), .z1(z1_ff_3), .z2(z2_ff_2), .z3(z3_ff), 
//                   .a1(a1_ff_3), .a2(a2_ff_2), .a3(a3_ff), .da4(da4_ff), .db1(db1_ff), .db2(db2_ff), .db3(db3_ff), .dW1(dW1_ff), .dW2(dW2_ff), .dW3(dW3_ff));
                   
//    // Control unit
//    //forward_net_control #(COUNT_DELAY) control(.clk(clk), .reset(reset), .reset_acc(), .load(en_acc)); 
//    //The parameter N equals a (N+1)*Tc delay between samples. For example if N=11 and Tc=10ns, delay between samples is 120ns
//    //control_counter #(COUNT_DELAY, 2048, 4) control_counter(.clk(clk), .reset(reset), .enable(enable), .out(reset_acc));

    
//    // Gradient Accumulators
//    //accumulator #(L2, L1) accumulator_dW1(.in(dW1), .out(acc_dW1), .clk(clk), .reset(reset && ~reset_acc), .enable(en));
    
    
//    assign en = enable&en_acc; 
                   
                   
//endmodule
module backward_propagation_net(        
    input logic clk, reset, enable,
        
    input data_type W1[0:L2-1][0:L1-1],
    input data_type W2[0:L3-1][0:L2-1],
    input data_type W3[0:L4-1][0:L3-1],
    
    input data_type z1[0:L2-1][0:0],
    input data_type z2[0:L3-1][0:0],
    input data_type z3[0:L4-1][0:0],
    
    input data_type a1[0:L1-1][0:0],
    input data_type a2[0:L2-1][0:0],
    input data_type a3[0:L3-1][0:0],
    
    input data_type da4[0:L4-1][0:0],
    
    output data_type db1[0:L2-1][0:0],
    output data_type db2[0:L3-1][0:0],
    output data_type db3[0:L4-1][0:0],
    
    output data_type dW1[0:L2-1][0:L1-1],
    output data_type dW2[0:L3-1][0:L2-1],
    output data_type dW3[0:L4-1][0:L3-1]);
    
    // Output Flip Flops
    data_type dW1_ff[0:L2-1][0:L1-1];
    data_type dW2_ff[0:L3-1][0:L2-1];
    data_type dW3_ff[0:L4-1][0:L3-1];
    data_type db1_ff[0:L2-1][0:0];
    data_type db2_ff[0:L3-1][0:0];
    data_type db3_ff[0:L4-1][0:0];
    
    // Block of output flip flops
    flip_flop  #(L2, L1) flip_flop_dW1(clk, reset, sample_data, dW1_ff, dW1);
    flip_flop  #(L3, L2) flip_flop_dW2(clk, reset, sample_data, dW2_ff, dW2);
    flip_flop  #(L4, L3) flip_flop_dW3(clk, reset, sample_data, dW3_ff, dW3);
    flip_flop  #(L2, 1) flip_flop_db1(clk, reset, sample_data, db1_ff, db1);
    flip_flop  #(L3, 1) flip_flop_db2(clk, reset, sample_data, db2_ff, db2);
    flip_flop  #(L4, 1) flip_flop_db3(clk, reset, sample_data, db3_ff, db3); 
       
          
     // instantiate device under test   
    backward_net backward_net(.clk(clk), .reset(reset), .enable(enable), .W1(W1), .W2(W2), .W3(W3), .z1(z1), .z2(z2), .z3(z3), 
                   .a1(a1), .a2(a2), .a3(a3), .da4(da4), .db1(db1_ff), .db2(db2_ff), .db3(db3_ff), .dW1(dW1_ff), .dW2(dW2_ff), .dW3(dW3_ff));
                   
    // Control unit
    forward_net_control #(COUNT_DELAY) control(.clk(clk), .reset(reset), .enable(enable), .sample(sample_data));
                   
    // Control unit
    //forward_net_control #(COUNT_DELAY) control(.clk(clk), .reset(reset), .reset_acc(), .load(en_acc)); 
    //The parameter N equals a (N+1)*Tc delay between samples. For example if N=11 and Tc=10ns, delay between samples is 120ns
    //control_counter #(COUNT_DELAY, 2048, 4) control_counter(.clk(clk), .reset(reset), .enable(enable), .out(reset_acc));

    
    // Gradient Accumulators
    //accumulator #(L2, L1) accumulator_dW1(.in(dW1), .out(acc_dW1), .clk(clk), .reset(reset && ~reset_acc), .enable(en));
    
                      
                   
endmodule

