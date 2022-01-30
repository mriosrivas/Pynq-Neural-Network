`include "forward_net_header.vh"
`include "typedef.vh"

//module mux_input_neural_network(
//    input data_type W1[0:L2-1][0:L1-1],
//    input data_type W2[0:L3-1][0:L2-1],
//    input data_type W3[0:L4-1][0:L3-1],
    
//    input data_type b1[0:L2-1][0:0],
//    input data_type b2[0:L3-1][0:0],
//    input data_type b3[0:L4-1][0:0],
    
//    input data_type W1_update[0:L2-1][0:L1-1],
//    input data_type W2_update[0:L3-1][0:L2-1],
//    input data_type W3_update[0:L4-1][0:L3-1],
    
//    input data_type b1_update[0:L2-1][0:0],
//    input data_type b2_update[0:L3-1][0:0],
//    input data_type b3_update[0:L4-1][0:0],
    
//    output data_type W1_ff[0:L2-1][0:L1-1],
//    output data_type W2_ff[0:L3-1][0:L2-1],
//    output data_type W3_ff[0:L4-1][0:L3-1],    
//    output data_type b1_ff[0:L2-1][0:0],
//    output data_type b2_ff[0:L3-1][0:0],
//    output data_type b3_ff[0:L4-1][0:0],
      
//    input logic clk, reset, enable, select);
    
//    data_type W1_out[0:L2-1][0:L1-1];
//    data_type W2_out[0:L3-1][0:L2-1];
//    data_type W3_out[0:L4-1][0:L3-1];
//    data_type b1_out[0:L2-1][0:0];
//    data_type b2_out[0:L3-1][0:0];
//    data_type b3_out[0:L4-1][0:0];
    
    
    
//    mux_input mux_input(.W1(W1), .W2(W2), .W3(W3), .b1(b1), .b2(b2), .b3(b3), 
//    .W1_update(W1_update), .W2_update(W2_update), .W3_update(W3_update), .b1_update(b1_update), .b2_update(b2_update), .b3_update(b3_update), 
//    .W1_out(W1_out), .W2_out(W2_out), .W3_out(W3_out), .b1_out(b1_out), .b2_out(b2_out), .b3_out(b3_out), .select(select)); 
    
//    parameters_flip_flop parameters_flip_flop_output_mux(.W1(W1_out), .W2(W2_out), .W3(W3_out), .b1(b1_out), .b2(b2_out), .b3(b3_out), 
//    .W1_ff(W1_ff), .W2_ff(W2_ff), .W3_ff(W3_ff), .b1_ff(b1_ff), .b2_ff(b2_ff), .b3_ff(b3_ff),
//    .clk(clk), .reset(reset), .enable_layer_1(enable), .enable_layer_2(enable), .enable_layer_3(enable));
    
//    endmodule


//module mux_input(
//    input data_type W1[0:L2-1][0:L1-1],
//    input data_type W2[0:L3-1][0:L2-1],
//    input data_type W3[0:L4-1][0:L3-1],
    
//    input data_type b1[0:L2-1][0:0],
//    input data_type b2[0:L3-1][0:0],
//    input data_type b3[0:L4-1][0:0],
    
//    input data_type W1_update[0:L2-1][0:L1-1],
//    input data_type W2_update[0:L3-1][0:L2-1],
//    input data_type W3_update[0:L4-1][0:L3-1],
    
//    input data_type b1_update[0:L2-1][0:0],
//    input data_type b2_update[0:L3-1][0:0],
//    input data_type b3_update[0:L4-1][0:0],
    
//    output data_type W1_out[0:L2-1][0:L1-1],
//    output data_type W2_out[0:L3-1][0:L2-1],
//    output data_type W3_out[0:L4-1][0:L3-1],
    
//    output data_type b1_out[0:L2-1][0:0],
//    output data_type b2_out[0:L3-1][0:0],
//    output data_type b3_out[0:L4-1][0:0],
    
//    input logic select);
    
    
//    mux_matrix #(L2, L1) mux_matrix_W1(.in_0(W1), .in_1(W1_update), .out(W1_out), .select(select));
//    mux_matrix #(L3, L2) mux_matrix_W2(.in_0(W2), .in_1(W2_update), .out(W2_out), .select(select));
//    mux_matrix #(L4, L3) mux_matrix_W3(.in_0(W3), .in_1(W3_update), .out(W3_out), .select(select));
    
//    mux_matrix #(L2, 1) mux_matrix_b1(.in_0(b1), .in_1(b1_update), .out(b1_out), .select(select));
//    mux_matrix #(L3, 1) mux_matrix_b2(.in_0(b2), .in_1(b2_update), .out(b2_out), .select(select));
//    mux_matrix #(L4, 1) mux_matrix_b3(.in_0(b3), .in_1(b3_update), .out(b3_out), .select(select));
    
//endmodule


//module parameters_flip_flop(
//    input logic clk, reset, enable_layer_1, enable_layer_2, enable_layer_3,
//    input data_type W1[0:L2-1][0:L1-1],
//    input data_type W2[0:L3-1][0:L2-1],
//    input data_type W3[0:L4-1][0:L3-1],    
//    input data_type b1[0:L2-1][0:0],
//    input data_type b2[0:L3-1][0:0],
//    input data_type b3[0:L4-1][0:0],  
//    output data_type W1_ff[0:L2-1][0:L1-1],
//    output data_type W2_ff[0:L3-1][0:L2-1],
//    output data_type W3_ff[0:L4-1][0:L3-1],    
//    output data_type b1_ff[0:L2-1][0:0],
//    output data_type b2_ff[0:L3-1][0:0],
//    output data_type b3_ff[0:L4-1][0:0]);
    
//    // Block of input flip flops
//    flip_flop  #(L2, L1) flip_flop_W1(clk, reset, enable_layer_1, W1, W1_ff);
//    flip_flop  #(L3, L2) flip_flop_W2(clk, reset, enable_layer_2, W2, W2_ff);
//    flip_flop  #(L4, L3) flip_flop_W3(clk, reset, enable_layer_3, W3, W3_ff);
//    flip_flop  #(L2, 1) flip_flop_b1(clk, reset, enable_layer_1, b1, b1_ff);
//    flip_flop  #(L3, 1) flip_flop_b2(clk, reset, enable_layer_2, b2, b2_ff);
//    flip_flop  #(L4, 1) flip_flop_b3(clk, reset, enable_layer_3, b3, b3_ff);
        
//endmodule


module mux_input_neural_network(
    input data_type W1[0:L2-1][0:L1-1],
    input data_type W2[0:L3-1][0:L2-1],
    input data_type W3[0:L4-1][0:L3-1],
    
    input data_type b1[0:L2-1][0:0],
    input data_type b2[0:L3-1][0:0],
    input data_type b3[0:L4-1][0:0],
    
    input data_type W1_update[0:L2-1][0:L1-1],
    input data_type W2_update[0:L3-1][0:L2-1],
    input data_type W3_update[0:L4-1][0:L3-1],
    
    input data_type b1_update[0:L2-1][0:0],
    input data_type b2_update[0:L3-1][0:0],
    input data_type b3_update[0:L4-1][0:0],
    
    output data_type W1_out[0:L2-1][0:L1-1],
    output data_type W2_out[0:L3-1][0:L2-1],
    output data_type W3_out[0:L4-1][0:L3-1],    
    output data_type b1_out[0:L2-1][0:0],
    output data_type b2_out[0:L3-1][0:0],
    output data_type b3_out[0:L4-1][0:0],
      
    input logic clk, reset, block_reset, enable_initial, 
    input logic enable_update_layer_1, enable_update_layer_2, enable_update_layer_3, select);
    
    data_type W1_ff_initial[0:L2-1][0:L1-1];
    data_type W2_ff_initial[0:L3-1][0:L2-1];
    data_type W3_ff_initial[0:L4-1][0:L3-1];
    data_type b1_ff_initial[0:L2-1][0:0];
    data_type b2_ff_initial[0:L3-1][0:0];
    data_type b3_ff_initial[0:L4-1][0:0];
    
    data_type W1_ff_update[0:L2-1][0:L1-1];
    data_type W2_ff_update[0:L3-1][0:L2-1];
    data_type W3_ff_update[0:L4-1][0:L3-1];
    data_type b1_ff_update[0:L2-1][0:0];
    data_type b2_ff_update[0:L3-1][0:0];
    data_type b3_ff_update[0:L4-1][0:0];
    
    
    
    parameters_flip_flop flip_flop_initial(.W1(W1), .W2(W2), .W3(W3), .b1(b1), .b2(b2), .b3(b3), 
    .W1_ff(W1_ff_initial), .W2_ff(W2_ff_initial), .W3_ff(W3_ff_initial), .b1_ff(b1_ff_initial), .b2_ff(b2_ff_initial), .b3_ff(b3_ff_initial),
    .clk(clk), .reset(reset), .enable_layer_1(enable_initial), .enable_layer_2(enable_initial), .enable_layer_3(enable_initial));
    
    parameters_flip_flop flip_flop_update(.W1(W1_update), .W2(W2_update), .W3(W3_update), .b1(b1_update), .b2(b2_update), .b3(b3_update), 
    .W1_ff(W1_ff_update), .W2_ff(W2_ff_update), .W3_ff(W3_ff_update), .b1_ff(b1_ff_update), .b2_ff(b2_ff_update), .b3_ff(b3_ff_update),
    .clk(clk), .reset(reset || block_reset), .enable_layer_1(enable_update_layer_1), .enable_layer_2(enable_update_layer_2), .enable_layer_3(enable_update_layer_3));
    
    mux_input mux_input(.W1(W1_ff_initial), .W2(W2_ff_initial), .W3(W3_ff_initial), .b1(b1_ff_initial), .b2(b2_ff_initial), .b3(b3_ff_initial), 
    .W1_update(W1_ff_update), .W2_update(W2_ff_update), .W3_update(W3_ff_update), .b1_update(b1_ff_update), .b2_update(b2_ff_update), .b3_update(b3_ff_update), 
    .W1_out(W1_out), .W2_out(W2_out), .W3_out(W3_out), .b1_out(b1_out), .b2_out(b2_out), .b3_out(b3_out), .select(select)); 
    
    
    endmodule


module mux_input(
    input data_type W1[0:L2-1][0:L1-1],
    input data_type W2[0:L3-1][0:L2-1],
    input data_type W3[0:L4-1][0:L3-1],
    
    input data_type b1[0:L2-1][0:0],
    input data_type b2[0:L3-1][0:0],
    input data_type b3[0:L4-1][0:0],
    
    input data_type W1_update[0:L2-1][0:L1-1],
    input data_type W2_update[0:L3-1][0:L2-1],
    input data_type W3_update[0:L4-1][0:L3-1],
    
    input data_type b1_update[0:L2-1][0:0],
    input data_type b2_update[0:L3-1][0:0],
    input data_type b3_update[0:L4-1][0:0],
    
    output data_type W1_out[0:L2-1][0:L1-1],
    output data_type W2_out[0:L3-1][0:L2-1],
    output data_type W3_out[0:L4-1][0:L3-1],
    
    output data_type b1_out[0:L2-1][0:0],
    output data_type b2_out[0:L3-1][0:0],
    output data_type b3_out[0:L4-1][0:0],
    
    input logic select);
    
    
    mux_matrix #(L2, L1) mux_matrix_W1(.in_0(W1), .in_1(W1_update), .out(W1_out), .select(select));
    mux_matrix #(L3, L2) mux_matrix_W2(.in_0(W2), .in_1(W2_update), .out(W2_out), .select(select));
    mux_matrix #(L4, L3) mux_matrix_W3(.in_0(W3), .in_1(W3_update), .out(W3_out), .select(select));
    
    mux_matrix #(L2, 1) mux_matrix_b1(.in_0(b1), .in_1(b1_update), .out(b1_out), .select(select));
    mux_matrix #(L3, 1) mux_matrix_b2(.in_0(b2), .in_1(b2_update), .out(b2_out), .select(select));
    mux_matrix #(L4, 1) mux_matrix_b3(.in_0(b3), .in_1(b3_update), .out(b3_out), .select(select));
    
endmodule


module parameters_flip_flop(
    input logic clk, reset, enable_layer_1, enable_layer_2, enable_layer_3,
    input data_type W1[0:L2-1][0:L1-1],
    input data_type W2[0:L3-1][0:L2-1],
    input data_type W3[0:L4-1][0:L3-1],    
    input data_type b1[0:L2-1][0:0],
    input data_type b2[0:L3-1][0:0],
    input data_type b3[0:L4-1][0:0],  
    output data_type W1_ff[0:L2-1][0:L1-1],
    output data_type W2_ff[0:L3-1][0:L2-1],
    output data_type W3_ff[0:L4-1][0:L3-1],    
    output data_type b1_ff[0:L2-1][0:0],
    output data_type b2_ff[0:L3-1][0:0],
    output data_type b3_ff[0:L4-1][0:0]);
    
    // Block of input flip flops
    flip_flop  #(L2, L1) flip_flop_W1(clk, reset, enable_layer_1, W1, W1_ff);
    flip_flop  #(L3, L2) flip_flop_W2(clk, reset, enable_layer_2, W2, W2_ff);
    flip_flop  #(L4, L3) flip_flop_W3(clk, reset, enable_layer_3, W3, W3_ff);
    flip_flop  #(L2, 1) flip_flop_b1(clk, reset, enable_layer_1, b1, b1_ff);
    flip_flop  #(L3, 1) flip_flop_b2(clk, reset, enable_layer_2, b2, b2_ff);
    flip_flop  #(L4, 1) flip_flop_b3(clk, reset, enable_layer_3, b3, b3_ff);
        
endmodule


//module mux_control #(parameter LOW_COUNT=5, parameter HIGH_COUNT=10, parameter DELAY=3)
//    (input logic clk, reset, enable,
//    output logic out);
    
//    parameter COUNT = (LOW_COUNT+1)*HIGH_COUNT;
//    parameter DELAY_COUNT = DELAY*(LOW_COUNT+1);
//    logic [31:0] counter;
//    logic delay_count;
//    logic [1:0] valid;
    
//    always @(posedge clk) begin 
//        if(!reset) begin 
//            counter<=0;
//            delay_count <= 0; 
//            valid <= 0;
//            end
//        else if(reset && enable && delay_count==0) begin 
//            counter <= counter + 1;
//            if(counter == DELAY_COUNT) begin 
//                delay_count <= 1;
//                counter <= 0;
//            end
//        end
//        else if(reset && enable && delay_count==1 && counter<COUNT && valid==0) counter <= counter + 1;
//        else if(reset && enable && delay_count==1 && counter >= COUNT && valid==0) 
//            begin 
//                counter <= 0;
//                valid <=1;  
//            end  
//        else if(reset && enable && delay_count==1 && valid==1) valid<= 2;  
//    end
    
//    //assign out = (counter==COUNT && delay_count==1);
//    assign out = (counter==0 && delay_count==1 && valid==1);

//endmodule


module mux_control #(parameter LOW_COUNT=5, parameter HIGH_COUNT=10, parameter DELAY=3)
    (input logic clk, reset, enable,
    output logic out, hold);
    
    parameter COUNT = (LOW_COUNT+1)*HIGH_COUNT;
    parameter DELAY_COUNT = DELAY*(LOW_COUNT+1);
    logic [31:0] counter;
    logic delay_count;
    logic [1:0] valid;
    
    always @(posedge clk) begin 
        if(!reset) begin 
            counter<=0;
            delay_count <= 0; 
            valid <= 0;
            end
        else if(reset && enable && delay_count==0) begin 
            counter <= counter + 1;
            if(counter == DELAY_COUNT) begin 
                delay_count <= 1;
                counter <= 0;
            end
        end
        else if(reset && enable && delay_count==1 && counter<COUNT && valid==0) counter <= counter + 1;
        else if(reset && enable && delay_count==1 && counter >= COUNT && valid==0) 
            begin 
                counter <= 0;
                valid <=1;  
            end  
        else if(reset && enable && delay_count==1 && valid==1) valid<= 2;  
    end
    
    //assign out = (counter==COUNT && delay_count==1);
    assign out = (counter==0 && delay_count==1 && valid==1);
    assign hold = valid[1];

endmodule