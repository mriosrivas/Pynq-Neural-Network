/*
* neurons.sv
* created by : Manuel Rios
* date: 18-Aug-20

* Module forward_neurons
* Functionality:
* calculates the forward propagation of an array of M neurons
* input ports:
* A: matrix of dimension M by N
* x: vector of dimension N by 1
* b: bias vector of dimension M by 1
* clk: clock signal
* reset: system reset, low asserted
* output ports:
* a: activation vector of dimension M by 1
*/
`include "typedef.vh"


module forward_neurons #(parameter M = 5, parameter N = 3, parameter ACTVATION_FUNCTION = "relu") 
    (input logic clk,
    input data_type A[0:M-1][0:N-1],
    input data_type x[0:N-1][0:0],
    input data_type b[0:M-1][0:0],
    input logic reset,
    output data_type a[0:M-1][0:0],
    output data_type z[0:M-1][0:0]);
    
    data_type Ax[0:M-1][0:0];
    data_type Ax_shifted [0:M-1][0:0];
    //data_type z[0:M-1][0:0];
    data_type activation_out[0:M-1][0:0];
    
    
mult #(M, N) multiplier(.clk(clk), .A(A), .x(x), .reset(reset), .b(Ax));

shifter #(M, 12) shifter(.in(Ax), .out(Ax_shifted));

bias #(M) add_bias(.clk(clk), .z(Ax_shifted), .b(b), .reset(reset), .a(z));
   
clip #(M, 12) clip(.in(activation_out), .out(a));

generate
if (ACTVATION_FUNCTION=="relu") relu #(M) relu(.clk(clk), .z(z), .reset(reset), .a(activation_out));  
else if (ACTVATION_FUNCTION=="sigmoid") sigmoid #(M) sigmoid(.clk(clk), .z(z), .reset(reset), .a(activation_out));  
endgenerate

    
endmodule

/*
* Module backward_neurons
* Functionality:
* calculates the backward propagation of an array of M neurons
* input ports:
* W: matrix of dimension M by N
* dz: gradient vector of dimension M by 1
* a: activation vector of dimension N by 1
* clk: clock signalhttps://docs.google.com/document/d/1SKmEhFQkMPfgcsnGQpgSH0rENY1Otq66CcVw5m_jZvI/edit?usp=sharing
* reset: system reset, low asserted
* output ports:
* da: activaiton gradient vector of dimension N by 1
* db: bias gradient vector of dimension M by 1
* weight gradient matrix of dimension M by N
*/

//M: Number of Rows
//N: Number of Columns

module backward_neurons #(parameter M = 5, parameter N = 3, parameter ACTVATION_FUNCTION = "relu") 
    (input logic clk,
    input data_type W[0:M-1][0:N-1],
    input data_type z[0:M-1][0:0],
    input data_type da_prev[0:M-1][0:0],
    input data_type a[0:N-1][0:0],
    input logic reset,
    output data_type da[0:N-1][0:0],
    output data_type db[0:M-1][0:0],
    output data_type dw[0:M-1][0:N-1]);
    
    data_type a_t[0:0][0:N-1];
    data_type W_t[0:N-1][0:M-1];
    data_type dz[0:M-1][0:0];
    data_type dw_unshifted[0:M-1][0:N-1];
    data_type da_unshifted[0:N-1][0:0];
 

generate
if (ACTVATION_FUNCTION=="relu") relu_backdrop #(M) relu_backdrop(.clk(clk), .z(z), .da(da_prev), .reset(reset), .dz(dz));
else if (ACTVATION_FUNCTION=="sigmoid") sigmoid_backdrop #(M, 12) sigmoid_backdrop(.clk(clk), .da(da_prev), .z(z), .dz(dz), .reset(reset)); 
endgenerate


transpose #(N,1) transpose_a(.A(a), .A_t(a_t));
vector_mult #(M,N) vector_mult_dw(.clk(clk), .V(dz), .U(a_t), .reset(reset), .VU(dw_unshifted));
shifter_matrix #(M, N, 12) shifter_dw(.in(dw_unshifted), .out(dw));

transpose #(M, N) transpose_W(.A(W), .A_t(W_t));
mult #(N, M) multiplier_da(.clk(clk), .A(W_t), .x(dz), .reset(reset), .b(da_unshifted));
shifter_matrix #(N, 1, 12) shifter_da(.in(da_unshifted), .out(da));


always @(posedge clk)
    db <= dz;
    
endmodule