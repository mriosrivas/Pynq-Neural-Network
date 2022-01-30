`include "forward_net_header.vh"
`include "typedef.vh"

module neural_network(
    input logic clk, reset, block_reset_on_mux, en_forward, en_backward, load_inital_parameters, input_select,
    input data_type W1[0:L2-1][0:L1-1],
    input data_type W2[0:L3-1][0:L2-1],
    input data_type W3[0:L4-1][0:L3-1],
    
    input data_type b1[0:L2-1][0:0],
    input data_type b2[0:L3-1][0:0],
    input data_type b3[0:L4-1][0:0],
    
    input data_type a1[0:L1-1][0:0],
    input data_type y[0:L4-1][0:0],
    
    output data_type W1_out[0:L2-1][0:L1-1],
    output data_type W2_out[0:L3-1][0:L2-1],
    output data_type W3_out[0:L4-1][0:L3-1],
    output data_type b1_out[0:L2-1][0:0],
    output data_type b2_out[0:L3-1][0:0],
    output data_type b3_out[0:L4-1][0:0]
    );
    
    logic sample_data, reset_acc_accumulator_layer_1, reset_acc_accumulator_layer_2, reset_acc_accumulator_layer_3;
    
    parameter LEARNING_RATE = 6;
    parameter AVERAGE_FACTOR = 11;
    
    parameter TOTAL_LAYERS = 3;
    parameter LAYER_0 = 0;
    parameter LAYER_1 = 1;
    parameter LAYER_2 = 2;
    parameter LAYER_3 = 3;

    parameter SAMPLES = 2048;

    
    
    data_type a2[0:L2-1][0:0];
    data_type a3[0:L3-1][0:0];
    data_type a4[0:L4-1][0:0];
    
    data_type dAL[0:L4-1][0:0];
    
    data_type z1[0:L2-1][0:0];
    data_type z2[0:L3-1][0:0];
    data_type z3[0:L4-1][0:0];
       
    data_type db1[0:L2-1][0:0];
    data_type db2[0:L3-1][0:0];
    data_type db3[0:L4-1][0:0];
    
    data_type dW1[0:L2-1][0:L1-1];
    data_type dW2[0:L3-1][0:L2-1];
    data_type dW3[0:L4-1][0:L3-1];
    
    data_type piped_a1[0:L1-1][0:0];
    data_type piped_a2[0:L2-1][0:0];
    data_type piped_a3[0:L3-1][0:0];
    //data_type piped_a4[0:L4-1][0:0];
    data_type piped_dAL[0:L4-1][0:0];
    
    data_type piped_y[0:L4-1][0:0];
        
    data_type piped_z1[0:L2-1][0:0];
    data_type piped_z2[0:L3-1][0:0];
    data_type piped_z3[0:L4-1][0:0];
        
    double_data_type dW1_acc[0:L2-1][0:L1-1];
    double_data_type dW2_acc[0:L3-1][0:L2-1];
    double_data_type dW3_acc[0:L4-1][0:L3-1];
    
    double_data_type db1_acc[0:L2-1][0:0];
    double_data_type db2_acc[0:L3-1][0:0];
    double_data_type db3_acc[0:L4-1][0:0];
    
    data_type W1_update[0:L2-1][0:L1-1];
    data_type W2_update[0:L3-1][0:L2-1];
    data_type W3_update[0:L4-1][0:L3-1];
    data_type b1_update[0:L2-1][0:0];
    data_type b2_update[0:L3-1][0:0];
    data_type b3_update[0:L4-1][0:0];
    
    data_type W1_mux[0:L2-1][0:L1-1];
    data_type W2_mux[0:L3-1][0:L2-1];
    data_type W3_mux[0:L4-1][0:L3-1];
    data_type b1_mux[0:L2-1][0:0];
    data_type b2_mux[0:L3-1][0:0];
    data_type b3_mux[0:L4-1][0:0];
    
    logic enable_update_layer_1, enable_update_layer_2, enable_update_layer_3;
    logic test_update;
    
    assign W1_out = W1_mux;
    assign W2_out = W2_mux;
    assign W3_out = W3_mux;
    assign b1_out = b1_mux;
    assign b2_out = b2_mux;
    assign b3_out = b3_mux;

// Forward Propagation 3-Layer    
//forward_propagation_net forward_net(.clk(clk), .reset(reset), .enable(en_forward), .W1(W1), .W2(W2), .W3(W3), 
//                    .a1(a1), .b1(b1), .b2(b2), .b3(b3), .y(y), .a2(a2), .a3(a3), .a4(a4), .dAL(dAL), .cost(), 
//                    .z1(z1), .z2(z2), .z3(z3));
forward_propagation_net forward_net(.clk(clk), .reset(reset), .enable(en_forward), .W1(W1_mux), .W2(W2_mux), .W3(W3_mux), 
                    .a1(a1), .b1(b1_mux), .b2(b2_mux), .b3(b3_mux), .y(piped_y), .a2(a2), .a3(a3), .a4(a4), .dAL(dAL), .cost(), 
                    .z1(z1), .z2(z2), .z3(z3));
                    
// Backward Propagation 3-Layer
backward_propagation_net backward_net(.clk(clk), .reset(reset), .enable(en_backward), .W1(W1_mux), .W2(W2_mux), .W3(W3_mux), .z1(piped_z1), .z2(piped_z2), .z3(piped_z3), 
                   .a1(piped_a1), .a2(piped_a2), .a3(piped_a3), .da4(piped_dAL), .db1(db1), .db2(db2), .db3(db3), .dW1(dW1), .dW2(dW2), .dW3(dW3));

// Control unit
//forward_net_control #(COUNT_DELAY) control(.clk(clk), .reset(reset), .enable(1'b1), .sample(sample_data));
forward_net_control #(COUNT_DELAY) control(.clk(clk), .reset(reset), .enable(en_forward), .sample(sample_data));


// Gradient Accumulator
accumulator_layered #(SAMPLES) accumulator_layered(
    .clk(clk), .reset(reset), .enable(en_forward), .sample_data(sample_data),
    .dW1(dW1), .dW2(dW2), .dW3(dW3), .db1(db1), .db2(db2), .db3(db3), 
    .dW1_acc(dW1_acc), .dW2_acc(dW2_acc), .dW3_acc(dW3_acc), .db1_acc(db1_acc), .db2_acc(db2_acc), .db3_acc(db3_acc));

// Update weights and bias 
update update(
    .learning_rate((LEARNING_RATE + AVERAGE_FACTOR)), .W1(W1_mux), .W2(W2_mux), .W3(W3_mux), .b1(b1_mux), .b2(b2_mux), .b3(b3_mux), 
    .dW1(dW1_acc), .dW2(dW2_acc), .dW3(dW3_acc), .db1(db1_acc), .db2(db2_acc), .db3(db3_acc), 
    .W1_update(W1_update), .W2_update(W2_update), .W3_update(W3_update), .b1_update(b1_update), .b2_update(b2_update), .b3_update(b3_update));


// Flip Flops for pipelining the design
layered_flip_flop #(L1, 1, TOTAL_LAYERS, LAYER_0, 8) layered_flip_flop_a1 (.clk(clk), .reset(reset), .sample_data(sample_data), .data(a1), .out_data(piped_a1));

layered_flip_flop #(L2, 1, TOTAL_LAYERS, LAYER_1, 5) layered_flip_flop_a2 (.clk(clk), .reset(reset), .sample_data(sample_data), .data(a2), .out_data(piped_a2));
layered_flip_flop #(L2, 1, TOTAL_LAYERS, LAYER_1, 6) layered_flip_flop_z1 (.clk(clk), .reset(reset), .sample_data(sample_data), .data(z1), .out_data(piped_z1));

layered_flip_flop #(L3, 1, TOTAL_LAYERS, LAYER_2, 3) layered_flip_flop_a3 (.clk(clk), .reset(reset), .sample_data(sample_data), .data(a3), .out_data(piped_a3));
layered_flip_flop #(L3, 1, TOTAL_LAYERS, LAYER_2, 4) layered_flip_flop_z2 (.clk(clk), .reset(reset), .sample_data(sample_data), .data(z2), .out_data(piped_z2));

//layered_flip_flop #(L4, 1, TOTAL_LAYERS, LAYER_3, 1) layered_flip_flop_a4 (.clk(clk), .reset(reset), .sample_data(sample_data), .data(a4), .out_data(piped_a4));
layered_flip_flop #(L4, 1, TOTAL_LAYERS, LAYER_3, 1) layered_flip_flop_a4 (.clk(clk), .reset(reset), .sample_data(sample_data), .data(dAL), .out_data(piped_dAL));
layered_flip_flop #(L4, 1, TOTAL_LAYERS, LAYER_3, 2) layered_flip_flop_z3 (.clk(clk), .reset(reset), .sample_data(sample_data), .data(z3), .out_data(piped_z3));

layered_flip_flop #(L4, 1, TOTAL_LAYERS, LAYER_3, 2) layered_flip_flop_y (.clk(clk), .reset(reset), .sample_data(sample_data), .data(y), .out_data(piped_y));


// select = 0 original input, select = 1 update input
//mux_input_neural_network mux_input_neural_network(.W1(W1), .W2(W2), .W3(W3), .b1(b1), .b2(b2), .b3(b3), 
//    .W1_update(W1_update), .W2_update(W2_update), .W3_update(W3_update), .b1_update(b1_update), .b2_update(b2_update), .b3_update(b3_update), 
//    .W1_ff(W1_mux), .W2_ff(W2_mux), .W3_ff(W3_mux), .b1_ff(b1_mux), .b2_ff(b2_mux), .b3_ff(b3_mux), 
//    .clk(clk), .reset(reset), .enable(load_inital_parameters), .select(input_select));          
mux_input_neural_network mux_input_neural_network(.W1(W1), .W2(W2), .W3(W3), .b1(b1), .b2(b2), .b3(b3), 
    .W1_update(W1_update), .W2_update(W2_update), .W3_update(W3_update), .b1_update(b1_update), .b2_update(b2_update), .b3_update(b3_update), 
    .W1_out(W1_mux), .W2_out(W2_mux), .W3_out(W3_mux), .b1_out(b1_mux), .b2_out(b2_mux), .b3_out(b3_mux), 
    .clk(clk), .reset(reset), .enable_initial(load_inital_parameters), .block_reset(block_reset_on_mux),
    .enable_update_layer_1(enable_update_layer_1), .enable_update_layer_2(enable_update_layer_2), .enable_update_layer_3(enable_update_layer_3), .select(input_select));

mux_control #(COUNT_DELAY, (SAMPLES), 6) mux_control_layer_3(.clk(clk), .reset(reset), .enable(en_forward), .out(enable_update_layer_3));
mux_control #(COUNT_DELAY, (SAMPLES), 7) mux_control_layer_2(.clk(clk), .reset(reset), .enable(en_forward), .out(enable_update_layer_2));
mux_control #(COUNT_DELAY, (SAMPLES), 8) mux_control_layer_1(.clk(clk), .reset(reset), .enable(en_forward), .out(enable_update_layer_1));

   
//mux_control #(COUNT_DELAY, (SAMPLES), 6) mux_control_layer_3(.clk(clk), .reset(reset && (~test_update)), .enable(en_forward), .out(enable_update_layer_3));
//mux_control #(COUNT_DELAY, (SAMPLES), 7) mux_control_layer_2(.clk(clk), .reset(reset && (~test_update)), .enable(en_forward), .out(enable_update_layer_2));
//mux_control #(COUNT_DELAY, (SAMPLES), 8) mux_control_layer_1(.clk(clk), .reset(reset && (~test_update)), .enable(en_forward), .out(enable_update_layer_1));

//mux_control #(COUNT_DELAY, (SAMPLES), 9) mux_control_update(.clk(clk), .reset(reset), .enable(en_forward), .out(test_update), .hold(test_hold));
                


endmodule