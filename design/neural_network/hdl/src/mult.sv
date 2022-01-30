/*
* mult.sv
* created by : Manuel Rios
* date: 21-Jul-20
* Functionality:
* multiplies a matrix (A) of dimensions M by N with vector (x) of dimension N by 1
* ports:
* A: matrix of dimensions M by N
* x: vector of dimension N by 1
* b: vector of dimension M by 1, which is b = Ax
* clk: clock signal
* reset: system reset, low asserted
*/
`include "typedef.vh"


module mult #(parameter M = 5, parameter N = 3)
    (input logic clk,
    input data_type A[0:M-1][0:N-1],
    input data_type x[0:N-1][0:0],
    input logic reset,
    output data_type b[0:M-1][0:0]);
    
    integer i,j;
    data_type B[0:M-1][0:N-1];   
    data_type y[0:M-1][0:N-2];

    always_ff @(posedge clk) begin
        for(i=0;i<=M-1;i=i+1)
            for(j=0; j<=N-1; j=j+1)
                B[i][j] = A[i][j]*x[j][0];  
    end 
    
    genvar k, m;
        generate
            for(k=0;k<=M-1;k=k+1) begin
            assign y[k][0] = B[k][0] + B[k][1];
                for(m=0; m<=N-3; m=m+1) // Here I changed from m<=N-1 to m<=N-3
                    always_ff @(posedge clk) begin
                            y[k][m+1] <= y[k][m] + B[k][m+2];
                        end
           end     
        endgenerate 
    
    genvar p;
        generate
        if (N>2) begin
            for(p=0; p<=M-1; p=p+1) begin
                always_ff @(posedge clk) begin
                    if (!reset) b[p][0] <= 0;
                    else b[p][0] <= y[p][N-2]; //change from else b[p] <= y[p][1]; to else b[p] <= y[p][N-2];
                end
            end
         end
         
         else if (N==2) begin
            for(p=0; p<=M-1; p=p+1) begin
                always_ff @(posedge clk) begin
                    if (!reset) b[p][0] <= 0;
                    else b[p][0] <= y[p][0];
                end
            end
         end
         
         
         else if (N==1) begin
            for(p=0; p<=M-1; p=p+1) begin
                always_ff @(posedge clk) begin
                    if (!reset) b[p][0] <= 0;
                    else b[p][0] <= B[p][0];
                end
            end
         end
        
        endgenerate
   

endmodule




module vector_mult #(parameter M = 5, parameter N = 3)
    (input logic clk,
    input data_type V[0:M-1][0:0],
    input data_type U[0:0][0:N-1],
    input logic reset,
    output data_type VU[0:M-1][0:N-1]);
    
    integer i,j;

    always_ff @(posedge clk) begin
        for(j=0;j<=N-1;j=j+1)
            for(i=0; i<=M-1; i=i+1)
                VU[i][j] = U[0][j]*V[i][0];  
    end 
    
    
endmodule