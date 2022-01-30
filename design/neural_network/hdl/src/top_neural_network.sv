`include "forward_net_header.vh"
`include "typedef.vh"

module top_neural_network(
    input logic clk, reset, enable,
    
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
    output data_type b3_out[0:L4-1][0:0],
    
    output data_type address,
    input logic [31:0] EPOCH,
    output logic [63:0] timer);
    
    logic reset_local, block_reset_on_mux, en_forward, en_backward, load_initial_parameters, input_select;
    

neural_network neural_network(
    .clk(clk), 
    .reset(reset && reset_local), 
    .block_reset_on_mux(block_reset_on_mux), 
    .en_forward(en_forward), 
    .en_backward(en_backward), 
    .load_inital_parameters(load_initial_parameters), 
    .input_select(input_select),
    
    .W1(W1),
    .W2(W2),
    .W3(W3),
    .b1(b1),
    .b2(b2),
    .b3(b3),
    
    .a1(a1),
    .y(y),
    
    .W1_out(W1_out),
    .W2_out(W2_out),
    .W3_out(W3_out),
    .b1_out(b1_out),
    .b2_out(b2_out),
    .b3_out(b3_out)
    );
    
state_machine_nn state_machine_nn(
        .clk(clk), 
        .enable(enable), 
        .reset(reset),
        .reset_local(reset_local),
        .block_reset_on_mux(block_reset_on_mux),
        .en_forward(en_forward),
        .en_backward(en_backward),
        .load_initial_parameters(load_initial_parameters),
        .input_select(input_select),
        .address(address),
        .EPOCH(EPOCH),
        .timer(timer)
        );
        
    
endmodule
