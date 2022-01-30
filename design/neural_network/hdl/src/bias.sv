/*
* bias.sv
* created by : Manuel Rios
* date: 13-Aug-20
* Functionality:
* calculates the rectified linear unit of vector z, a=max(0,z) 
* ports:
* z: vector of dimension M by 1
* b: vector of dimension M by 1
* a: vector of dimension N by 1
* clk: clock signal
* reset: system reset, low asserted
*/

`include "typedef.vh"

//parameter M = 5; //Number of Rows

module bias #(parameter M = 5)
    (input logic clk,
    input data_type z[0:M-1][0:0],
    input data_type b[0:M-1][0:0],
    logic reset,
    output data_type a[0:M-1][0:0]);
    
 genvar j;
     generate
         for (j=0; j<=M-1; j=j+1) begin
             always_ff @(posedge clk) begin
                if(!reset) a[j][0] <= 0;
                else begin
                    a[j][0]<=b[j][0] + z[j][0]; 
                end
             end
         end
     endgenerate
    
endmodule