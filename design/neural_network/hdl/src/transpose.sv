/*
* transpose.sv
* created by : Manuel Rios
* date: 13-Aug-20
* Functionality:
* calculates the transpose of a matrix 
* ports:
* A: matrix of dimensions M by N
* clk: clock signal
* reset: system reset, low asserted
*/
`include "typedef.vh"


module transpose #(parameter M = 5, parameter N = 3)
    (input data_type A[0:M-1][0:N-1],
    output data_type A_t[0:N-1][0:M-1]);
    
genvar i, j;
        generate
            for(j=0;j<=N-1;j=j+1)
                for(i=0; i<=M-1; i=i+1)
                    assign A_t[j][i] = A[i][j];
        endgenerate 
    
endmodule