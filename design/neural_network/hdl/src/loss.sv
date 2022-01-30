`include "typedef.vh"


module loss_square_of_errors #(parameter M = 5)
    (input data_type y_hat[0:M-1][0:0],
    input data_type y[0:M-1][0:0],
    output data_type se[0:M-1][0:0]);
    
    genvar k;
        generate
            for(k=0; k<=M-1; k=k+1) begin
                assign se[k][0] = (y_hat[k][0] - y[k][0])**2;
            end
         endgenerate


endmodule


/*module loss_cross_entropy #(parameter M = 1, parameter SIGMOID_DECIMAL_BITS=12)
    (input data_type y_hat[0:M-1][0:0],
    input data_type y[0:M-1][0:0],
    input logic clk,
    input logic reset,
    output data_type se[0:M-1][0:0]);
    
    parameter COUNT = 4;
    int counter;
    data_type y_clipped[0:M-1][0:0];
    data_type temp, data_from_table;
    data_type data[0:1][0:0];
    
    parameter MAX_VALUE = (2**(SIGMOID_DECIMAL_BITS))-1;
    parameter MIN_VALUE = -(2**(SIGMOID_DECIMAL_BITS));
    
    
    log_int log_int(.in(temp), .out(data_from_table));
    
    always_comb begin
        if (y[0][0]> MAX_VALUE) y_clipped[0][0] = MAX_VALUE;
        else if (y[0][0]< MIN_VALUE) y_clipped[0][0] = MIN_VALUE;
        else y_clipped[0][0]= y[0][0];
        end
        
    always @(posedge clk) begin    
        if(!reset) counter <= 0;
        else if (counter < COUNT) begin 
        counter <= counter + 1; 
        if (counter == 1) temp <= y_clipped[0][0];
        else if (counter == 2) begin 
            data[0][0] <= data_from_table;
            temp <= (2**SIGMOID_DECIMAL_BITS) - y_clipped[0][0]; end
        else if (counter == 3) begin
            data[1][0] <= data_from_table;
            end
        end
        else counter <= 0;    
    end


endmodule*/


module loss_cross_entropy #(parameter M = 1, parameter SIGMOID_DECIMAL_BITS=12)
    (input data_type y_hat[0:M-1][0:0],
    input data_type y[0:M-1][0:0],
    input logic clk,
    input logic reset,
    output data_type loss[0:M-1][0:0]);
    
    parameter COUNT = 4;
    int counter;
    data_type input_to_table;
    data_type y_clipped[0:M-1][0:0];
    data_type data_from_table;
    data_type data[0:1][0:0];
    data_type temp[0:1][0:0];
    
    parameter MAX_VALUE = (2**(SIGMOID_DECIMAL_BITS))-1;
    parameter MIN_VALUE = -(2**(SIGMOID_DECIMAL_BITS));
    
    
    log_int log_int(.in(input_to_table), .out(data_from_table));
    
    always_comb begin
        if (y[0][0]> MAX_VALUE) y_clipped[0][0] = MAX_VALUE;
        else if (y[0][0]< MIN_VALUE) y_clipped[0][0] = MIN_VALUE;
        else y_clipped[0][0]= y[0][0];
        temp[0][0] = y_clipped[0][0];
        temp[1][0] = (2**SIGMOID_DECIMAL_BITS) - y_clipped[0][0];
        end
        
    always @(posedge clk) begin    
        if(!reset) counter <= 0;
        else if (counter < COUNT) begin 
            counter <= counter + 1; 
            if (counter == 0) input_to_table <= temp[0][0];
            else if (counter == 1) begin 
                data[0][0] <= data_from_table;
                input_to_table <= temp[1][0]; end
            else if (counter == 2) begin
                data[1][0] <= data_from_table;
                end
            else if (counter == 3)  loss[0][0] <= -(y_hat[0][0]*data[0][0]+ ((2**SIGMOID_DECIMAL_BITS)-y_hat[0][0])*data[1][0]);
            end
            else counter <= 0;    
    
    end
endmodule



module gradient_cross_entropy #(parameter M = 1, parameter SIGMOID_DECIMAL_BITS=12)
    (input data_type y_hat[0:M-1][0:0],
    input data_type y[0:M-1][0:0],
    output data_type dAL[0:M-1][0:0]);
    
    parameter MAX_VALUE = (2**(SIGMOID_DECIMAL_BITS))-1;
    parameter MIN_VALUE = -(2**(SIGMOID_DECIMAL_BITS));
    
    data_type y_clipped[0:M-1][0:0];
    data_type data_from_table[0:1][0:0];
      
    cross_entropy_table_1 cross_entropy_table_1(.in(y_clipped[0][0]), .out(data_from_table[0][0]));
    cross_entropy_table_2 cross_entropy_table_2(.in(y_clipped[0][0]), .out(data_from_table[1][0]));
    
    always_comb begin
        if (y[0][0]> MAX_VALUE) y_clipped[0][0] = MAX_VALUE;
        else if (y[0][0]< MIN_VALUE) y_clipped[0][0] = MIN_VALUE;
        else y_clipped[0][0]= y[0][0];
        if(y_hat[0][0] == 0) dAL[0][0] = data_from_table[0][0]<<SIGMOID_DECIMAL_BITS;
        else if (y_hat[0][0] == 2**SIGMOID_DECIMAL_BITS) dAL[0][0] = data_from_table[1][0]<<SIGMOID_DECIMAL_BITS;
        else dAL[0][0] = 0;
        end
        
endmodule