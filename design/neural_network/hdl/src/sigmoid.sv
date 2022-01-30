`include "typedef.vh"

//parameter M = 5; //Number of Rows

module sigmoid #(parameter M = 5)
    (input logic clk,
    input data_type z[0:M-1][0:0],
    logic reset,
    output data_type a[0:M-1][0:0]);
    
    read_table #(M, 4, 12) read_table(.z(z), .clk(clk), .reset(reset), .a(a));
    
endmodule


module read_table #(parameter M = 5, parameter EXTRA_BITS=4, parameter SIGMOID_DECIMAL_BITS=12)
    (input data_type z[0:M-1][0:0],
    input logic clk, reset,
    output data_type a[0:M-1][0:0]);
    
    parameter MAX_VALUE = (2**(EXTRA_BITS + SIGMOID_DECIMAL_BITS))-1;
    parameter MIN_VALUE = -(2**(EXTRA_BITS + SIGMOID_DECIMAL_BITS));
    
    int correction;
    
    data_type z_serial[0:0][0:0];
    data_type clipped_z_serial[0:0][0:0];
    data_type correct_z_serial[0:0][0:0];
    data_type z_serial_to_parallel[0:0][0:0];
    data_type correct_z_serial_to_parallel[0:0][0:0];
    
    serialize #(M) serialize(.clk(clk), .in(z), .reset(reset), .out(z_serial));
    sigma_int sigma_int(.in(correct_z_serial[0][0]), .clk(clk), .out(z_serial_to_parallel[0][0]));
    parallelize #(M) parallelize(.clk(clk), .in(correct_z_serial_to_parallel), .reset(reset), .out(a));
    
    always_comb begin
        if (z_serial[0][0]> MAX_VALUE) clipped_z_serial[0][0] = MAX_VALUE;
        else if (z_serial[0][0]< MIN_VALUE) clipped_z_serial[0][0] = MIN_VALUE;
        else clipped_z_serial[0][0]= z_serial[0][0];
        
        if(clipped_z_serial[0][0] < 0) begin
            correct_z_serial[0][0] = -clipped_z_serial[0][0];
            correction = 2**SIGMOID_DECIMAL_BITS;
            end
        else    begin 
            correct_z_serial[0][0] = clipped_z_serial[0][0];
            correction = 0;
        
        end
        
        if(correction==0) correct_z_serial_to_parallel[0][0] = z_serial_to_parallel[0][0] + correction;
        else correct_z_serial_to_parallel[0][0] = -z_serial_to_parallel[0][0] + correction;
    end
    
        
endmodule



module serialize #(parameter M = 5)
    (input logic clk,
    input data_type in[0:M-1][0:0],
    logic reset,
    output data_type out[0:0][0:0]);
    
    int counter;
       
always @(posedge clk) begin
    if (!reset) counter <= 0; 
    else begin
        if (counter<M) counter <= counter + 1'b1;
        else counter <= 0;
    end
end

assign out[0][0] = in[counter][0];    


endmodule



module parallelize #(parameter M = 5)
    (input logic clk,
    input data_type in[0:0][0:0],
    logic reset,
    output data_type out[0:M-1][0:0]);
    
    int counter;
       
always @(posedge clk) begin
    if (!reset) counter <= 0; 
    else begin 
        if (counter<M) begin
            counter <= counter + 1'b1;
            out[counter][0] <= in[0][0]; 
            end
        else counter <= 0;
    end
end

endmodule



module sigmoid_backdrop #(parameter M = 5, parameter SIGMOID_DECIMAL_BITS=12)
    (input logic clk,
    input data_type da[0:M-1][0:0],
    input data_type z[0:M-1][0:0],
    output data_type dz[0:M-1][0:0],
    input logic reset);
    
    data_type a[0:M-1][0:0];
    data_type temp_da[0:M-1][0:0];
    
    sigmoid #(M) sigmoid(.clk(clk), .z(z), .reset(reset), .a(a));
    
    genvar i;
        generate
            for(i=0; i<M; i++) begin
                assign temp_da[i][0] = (a[i][0]*((2**SIGMOID_DECIMAL_BITS) - a[i][0]))>>>SIGMOID_DECIMAL_BITS;
                assign dz[i][0] = (temp_da[i][0]*da[i][0])>>>SIGMOID_DECIMAL_BITS;
            end
            
        endgenerate        
        
//    genvar i;
//        generate
//            for(i=0; i<M; i++) begin
//                always_comb begin
//                temp_da[i][0] = (a[i][0]*((2**SIGMOID_DECIMAL_BITS) - a[i][0]))>>>SIGMOID_DECIMAL_BITS;
//                dz[i][0] = (temp_da[i][0]*da[i][0])>>>SIGMOID_DECIMAL_BITS;
//                end
//            end
//           
//        endgenerate 
endmodule