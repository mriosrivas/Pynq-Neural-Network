`include "forward_net_header.vh"
`include "typedef.vh"

// M number of rows
// N number of columns
// TOTAL_LAYERS total number of forward layers in the neural network
// LAYER_NUMBER layer that is being deployed, starting from 0 for input layer, 1 for first hidden layer, and so on.
// PIPES number of stacked flip flops to use 

module layered_flip_flop #(parameter M=2, parameter N=1, parameter TOTAL_LAYERS = 3, parameter LAYER_NUMBER = 0, parameter PIPES=8)
    (input logic clk, reset, sample_data,
    input data_type data[0:M-1][0:N-1],
    output data_type out_data[0:M-1][0:N-1]);
    
    data_type piped_data[0:PIPES-1][0:M-1][0:N-1];


genvar p;                    
generate 
    for(p=0; p<(2*(TOTAL_LAYERS-LAYER_NUMBER+1)); p++) begin
    if(p==0) 
        begin
            flip_flop  #(M, N) flip_flop_layer(clk, reset, sample_data, data, piped_data[p]);
        end
    if(p>0)
        begin
            flip_flop  #(M, N) flip_flop_layer(clk, reset, sample_data, piped_data[p-1], piped_data[p]);
        end
    end
endgenerate

genvar i, j;
    generate
    for (j=0; j<N; j=j+1) begin
        for (i=0; i<M; i=i+1) begin
           assign out_data[i][j] = piped_data[PIPES-1][i][j];
        end
     end
    
    endgenerate
    

endmodule