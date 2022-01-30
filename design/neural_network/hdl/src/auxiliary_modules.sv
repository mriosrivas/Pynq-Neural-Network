//`include "forward_net_header.vh"
`include "typedef.vh"

 module flip_flop #(parameter M = 5, parameter N = 3)
        (input logic clk, reset, enable,
        input data_type D[0:M-1][0:N-1],
        output data_type Q[0:M-1][0:N-1]);
        
        
        genvar i, j;
        
        generate
        
        for (i=0; i<=M-1; i=i+1) begin
            for (j=0; j<=N-1; j=j+1) begin
        always_ff @(posedge clk)
            if (!reset) Q[i][j] <= 0;
            else if (enable) Q[i][j] <= D[i][j];
            end
            end
            
        endgenerate
 
 endmodule


module shifter #(parameter SIZE = 5, parameter SHAMT = 12)
    (
    input data_type in[0:SIZE-1][0:0],
    output data_type out[0:SIZE-1][0:0]
    );
    
    genvar i;
    generate
        for (i=0; i<SIZE; i=i+1) begin
           assign out[i][0] = in[i][0]>>>SHAMT;
        end
    
    endgenerate
endmodule


module shifter_matrix #(parameter M = 5, parameter N = 5, parameter SHAMT = 12)
    (
    input data_type in[0:M-1][0:N-1],
    output data_type out[0:M-1][0:N-1]
    );
    
    genvar i, j;
    generate
    for (j=0; j<N; j=j+1) begin
        for (i=0; i<M; i=i+1) begin
           assign out[i][j] = in[i][j]>>>SHAMT;
        end
     end
    
    endgenerate
endmodule


module clip #(parameter SIZE = 5, parameter SHAMT = 12)
    (
    input data_type in[0:SIZE-1][0:0],
    output data_type out[0:SIZE-1][0:0]
    );
    
    genvar i;
    generate
        for (i=0; i<SIZE; i=i+1) begin
           assign out[i][0] = in[i][0]>2**SHAMT-1  ? 2**SHAMT-1  : in[i][0];
        end
    
    endgenerate
endmodule


module delayed_ff #(parameter M=5, parameter COUNT=25)
    (
    input logic clk, reset, enable,
    input data_type in[0:M-1][0:0], //input    
    output data_type out[0:M-1][0:0] //output
    ); 
    
    int counter;
    logic signal;
    
    genvar i;
        generate
            for (i=0; i<M; i++) begin
            always @(posedge clk) begin
            if (!reset) out[i][0] = 0;
            else if(counter == COUNT)   out[i][0] <= in[i][0];
            end
            end
        endgenerate
    
    always @(posedge clk) begin
        if (!reset) 
            begin 
                counter <= COUNT; 
                signal <= 0;
            end
        else begin
            if (enable == 1 && counter < COUNT) 
                begin 
                    counter <= counter + 1;
                    signal <= 0; 
                end
                
            else if (enable == 1 && counter == COUNT) 
                begin 
                    counter <= 0; 
                    signal <= 1;
                end
         end
    
    end
    
    
    endmodule

 
    
module control_counter #(parameter LOW_COUNT=5, parameter HIGH_COUNT=10, parameter DELAY=3)
    (input logic clk, reset, enable,
    output logic out);
    
    parameter COUNT = (LOW_COUNT+1)*HIGH_COUNT;
    parameter DELAY_COUNT = DELAY*(LOW_COUNT+1);
    logic [31:0] counter;
    logic delay_count;
    
    always @(posedge clk) begin 
        if(!reset) begin 
            counter<=0;
            delay_count <= 0; 
            end
        else if(reset && enable && delay_count==0) begin 
            counter <= counter + 1;
            if(counter == DELAY_COUNT) begin 
                delay_count <= 1;
                counter <= 0;
            end
        end
        else if(reset && enable && delay_count==1 && counter<COUNT) counter <= counter + 1;
        else if(reset && enable && delay_count==1 && counter >= COUNT) counter <= 0;        
    end
    
    //assign out = (counter==COUNT && delay_count==1);
    assign out = (counter==0 && delay_count==1);

endmodule



module mux_matrix #(parameter M = 5, parameter N = 5)
    (
    input data_type in_0[0:M-1][0:N-1],
    input data_type in_1[0:M-1][0:N-1],
    output data_type out[0:M-1][0:N-1],
    input logic select
    );
    
    genvar i, j;
    generate
    for (j=0; j<N; j=j+1) begin
        for (i=0; i<M; i=i+1) begin
           assign out[i][j] = select ? in_1[i][j] : in_0[i][j];
        end
     end
    
    endgenerate
endmodule