`include "forward_net_header.vh"
`include "typedef.vh"

// Sequential accumulator
/*
module accumulator #(parameter M = 5)
    (input data_type in[0:M-1][0:0],
    output double_data_type out[0:M-1][0:0],
    input logic clk,
    input logic reset,
    input logic enable);
    
    genvar k;
        generate
        for(k=0; k<= M-1; k=k+1) begin    
            always_ff @(posedge clk) begin
                if (!reset) out[k][0] <= 0;
                else if (enable) out[k][0] <= out[k][0] + in[k][0];
              end
         end
        endgenerate
endmodule
*/

module accumulator #(parameter M = 5, parameter N=1)
    (input data_type in[0:M-1][0:N-1],
    output double_data_type out[0:M-1][0:N-1],
    input logic clk,
    input logic reset,
    input logic enable);
    
    genvar i, j;
        generate
        for(i=0; i<= M-1; i=i+1) begin    
            for(j=0; j<= N-1; j=j+1) begin    
            always_ff @(posedge clk) begin
                if (!reset) out[i][j] <= 0;
                else if (enable) out[i][j] <= out[i][j] + in[i][j];
              end
         end
         end
        endgenerate
endmodule


module accumulator_layered #(parameter SAMPLES=2)(
    input logic clk, reset, enable, sample_data,
    input data_type dW1[0:L2-1][0:L1-1],
    input data_type dW2[0:L3-1][0:L2-1],
    input data_type dW3[0:L4-1][0:L3-1],
    input data_type db1[0:L2-1][0:0],
    input data_type db2[0:L3-1][0:0],
    input data_type db3[0:L4-1][0:0],
    
    output double_data_type dW1_acc[0:L2-1][0:L1-1],
    output double_data_type dW2_acc[0:L3-1][0:L2-1],
    output double_data_type dW3_acc[0:L4-1][0:L3-1],
    output double_data_type db1_acc[0:L2-1][0:0],
    output double_data_type db2_acc[0:L3-1][0:0],
    output double_data_type db3_acc[0:L4-1][0:0]);


    logic reset_acc_accumulator_layer_1, reset_acc_accumulator_layer_2, reset_acc_accumulator_layer_3;
    
    accumulator #(L2, L1) accumulator_dW1(.in(dW1), .out(dW1_acc), .clk(clk), .reset(reset && ~reset_acc_accumulator_layer_1), .enable(sample_data));
    accumulator #(L3, L2) accumulator_dW2(.in(dW2), .out(dW2_acc), .clk(clk), .reset(reset && ~reset_acc_accumulator_layer_2), .enable(sample_data));
    accumulator #(L4, L3) accumulator_dW3(.in(dW3), .out(dW3_acc), .clk(clk), .reset(reset && ~reset_acc_accumulator_layer_3), .enable(sample_data));
    
    accumulator #(L2, 1) accumulator_db1(.in(db1), .out(db1_acc), .clk(clk), .reset(reset && ~reset_acc_accumulator_layer_1), .enable(sample_data));
    accumulator #(L3, 1) accumulator_db2(.in(db2), .out(db2_acc), .clk(clk), .reset(reset && ~reset_acc_accumulator_layer_2), .enable(sample_data));
    accumulator #(L4, 1) accumulator_db3(.in(db3), .out(db3_acc), .clk(clk), .reset(reset && ~reset_acc_accumulator_layer_3), .enable(sample_data));
    
    control_counter #(COUNT_DELAY, (SAMPLES+1), 8) control_counter_accumulator_dW1(.clk(clk), .reset(reset), .enable(enable), .out(reset_acc_accumulator_layer_1));
    control_counter #(COUNT_DELAY, (SAMPLES+1), 7) control_counter_accumulator_dW2(.clk(clk), .reset(reset), .enable(enable), .out(reset_acc_accumulator_layer_2));
    control_counter #(COUNT_DELAY, (SAMPLES+1), 6) control_counter_accumulator_dW3(.clk(clk), .reset(reset), .enable(enable), .out(reset_acc_accumulator_layer_3));
    


endmodule