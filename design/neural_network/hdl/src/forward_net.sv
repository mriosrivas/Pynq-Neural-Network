`include "forward_net_header.vh"
`include "typedef.vh"


module forward_net(
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
    output data_type z1[0:L2-1][0:0],
    output data_type z2[0:L3-1][0:0],
    output data_type z3[0:L4-1][0:0]); 
          
    data_type a2_delayed[0:L2-1][0:0];
    data_type a3_delayed[0:L3-1][0:0];
    data_type a4_delayed[0:L4-1][0:0];
    data_type dAL_delayed[0:L4-1][0:0];
    data_type y_ff[0:L4-1][0:0];
    
    data_type z1_delayed[0:L2-1][0:0];
    data_type z2_delayed[0:L3-1][0:0];
    data_type z3_delayed[0:L4-1][0:0];
    
    logic sample_data;
    //assign y_ff = y;
    

    // Forward Neuron Network Pipelined
    forward_neurons #(L2, L1, "relu") layer_1(clk, W1, a1, b1, reset, a2_delayed, z1_delayed);
    flip_flop  #(L2, 1) layer_1_delayed_a2(clk, reset, sample_data, a2_delayed, a2);
    flip_flop  #(L2, 1) layer_1_delayed_z1(clk, reset, sample_data, z1_delayed, z1);
    //delayed_ff #(L2, COUNT_DELAY) layer_1_delayed_a2(.clk(clk), .reset(reset), .enable(enable), .in(a2_delayed), .out(a2)); // 24 is for 0 to 24 cycles -> 25 in total
    //delayed_ff #(L2, COUNT_DELAY) layer_1_delayed_z1(.clk(clk), .reset(reset), .enable(enable), .in(z1_delayed), .out(z1));
    
    forward_neurons #(L3, L2, "relu") layer_2(clk, W2, a2, b2, reset, a3_delayed, z2_delayed);
    flip_flop  #(L3, 1) layer_2_delayed_a3(clk, reset, sample_data, a3_delayed, a3);
    flip_flop  #(L3, 1) layer_2_delayed_z2(clk, reset, sample_data, z2_delayed, z2);
    //delayed_ff #(L3, COUNT_DELAY) layer_2_delayed_a3(.clk(clk), .reset(reset), .enable(enable), .in(a3_delayed), .out(a3)); // For later use in pipeline mode
    //delayed_ff #(L3, COUNT_DELAY) layer_2_delayed_z2(.clk(clk), .reset(reset), .enable(enable), .in(z2_delayed), .out(z2));
    
    forward_neurons #(L4, L3, "sigmoid") layer_3(clk, W3, a3, b3, reset, a4_delayed, z3_delayed);
    flip_flop  #(L4, 1) layer_3_delayed_a4(clk, reset, sample_data, a4_delayed, a4);
    flip_flop  #(L4, 1) layer_3_delayed_z3(clk, reset, sample_data, z3_delayed, z3);
    //delayed_ff #(L4, COUNT_DELAY) layer_3_delayed_a4(.clk(clk), .reset(reset), .enable(enable), .in(a4_delayed), .out(a4));
    //delayed_ff #(L4, COUNT_DELAY) layer_3_delayed_z3(.clk(clk), .reset(reset), .enable(enable), .in(z3_delayed), .out(z3));
    
    // Loss
    //loss_square_of_errors #(L4) loss(.y_hat(a4), .y(y), .se(error));
    
    // Gradient Cross-Entropy
    flip_flop  #(L4, 1) gradient_cross_entropy_delayed_in(clk, reset, sample_data, y, y_ff);
    gradient_cross_entropy #(L4) gradient_cross_entropy(.y_hat(y_ff), .y(a4), .dAL(dAL_delayed));
    
    //gradient_cross_entropy #(L4) gradient_cross_entropy(.y_hat(y_ff), .y(a4), .dAL(dAL_delayed)); //This is new
    
    flip_flop  #(L4, 1) gradient_cross_entropy_delayed_out(clk, reset, sample_data, dAL_delayed, dAL);
    //delayed_ff #(L4, COUNT_DELAY) gradient_cross_entropy_delayed_out(.clk(clk), .reset(reset), .enable(enable), .in(dAL_delayed), .out(dAL));
    
    // Accumulator for Cost
    // accumulator #(L4) accumulator(.in(error), .out(acc_error), .clk(clk), .reset(reset), .enable(en_acc));
    
    // Control unit
    // forward_net_control #(16) control(.clk(clk), .reset(reset), .y(en_acc));
    
    
//    // Forward Neuron Network No Pipelined
//    forward_neurons #(L2, L1, "relu") layer_1(clk, W1, a1, b1, reset, a2, z1);   
//    forward_neurons #(L3, L2, "relu") layer_2(clk, W2, a2, b2, reset, a3, z2);
//    forward_neurons #(L4, L3, "sigmoid") layer_3(clk, W3, a3, b3, reset, a4, z3);
//    // Gradient Cross-Entropy
//    gradient_cross_entropy #(L4) gradient_cross_entropy(.y_hat(y), .y(a4), .dAL(dAL));


forward_net_control #(COUNT_DELAY) local_control_forward(.clk(clk), .reset(reset), .enable(enable), .sample(sample_data));
    endmodule
 
/*
module forward_net_control #(parameter COUNT = 10)
    (input logic clk,
    input logic reset,
    output logic reset_acc, load);

    typedef enum logic [1:0] {S0, S1, S2} statetype;
    statetype [1:0] state, nextstate;
   
   logic [COUNT:0] counter;
   
   always_ff @(posedge clk)
         if (!reset) counter <= 2**(COUNT-1);
         else counter <= {counter[COUNT-1:0],counter[COUNT]};


    // state register
    always_ff @(posedge clk)
        if (!reset)  state <= S0;
        else state <= nextstate;

  
    // next state logic
    always_comb
        case (state)
            S0: begin 
                nextstate <= S1; 
                reset_acc <= 0;
            end
            S1: begin 
                if (load) nextstate <= S2;
                else nextstate <= S1;
                reset_acc <= 1;
            end
            S2: begin
                nextstate <= S1;
                reset_acc <= 0;
            end
            default: nextstate <= S0;
    endcase


    // output logic
    assign load = (counter == 2**COUNT);
    
    

endmodule

*/

module forward_net_control #(parameter COUNT = 10)
    (input logic clk,
    input logic reset,
    input logic enable,
    output logic sample);
    
    int counter;
    
    always_ff @(posedge clk) begin
        if (~reset)
            begin
                sample <=0;
                counter <= COUNT;
            end
       else if(enable && reset) begin
                if(counter < COUNT) begin
                    counter <= counter + 1'b1;
                    sample <= 0;
                end
                if(counter == COUNT) begin
                    counter <= 0;
                    sample <= 1;
                end
       end
    end


endmodule
