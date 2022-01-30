`include "forward_net_header.vh"
`include "typedef.vh"


module top_neural_network_tb();

    data_type W1[0:L2-1][0:L1-1];
    data_type W2[0:L3-1][0:L2-1];
    data_type W3[0:L4-1][0:L3-1];
       
    data_type b1[0:L2-1][0:0];
    data_type b2[0:L3-1][0:0];
    data_type b3[0:L4-1][0:0];
    
    data_type a1[0:L1-1][0:0];
    data_type y[0:L4-1][0:0];
    
    data_type X0, X1, Y;
    data_type address;
    
    logic clk, reset, enable;
    
    integer i, j, k;
    integer weights_file, gradient_cross_entropy_file;
    parameter EPOCHS = 100;
    parameter SIZE_OF_X = 2048;
    
    top_neural_network top_neural_network(
        .clk(clk), 
        .reset(reset), 
        .enable(enable), 
        .W1(W1), 
        .W2(W2), 
        .W3(W3), 
        .b1(b1), 
        .b2(b2), 
        .b3(b3), 
        .a1(a1), 
        .y(y),
        .address(address)
        );
    
//    data_wrapper data_wrapper (
//        .X0(X0), 
//        .X1(X1),   
//        .Y(Y),
//        .address(address),
//        .clk(clk)
//        );

data_double_wrapper data_double_wrapper(
        .BRAM_PORT_X0_addr(),
        .BRAM_PORT_X0_clk(),
        .BRAM_PORT_X0_din(),
        .BRAM_PORT_X0_dout(),
        .BRAM_PORT_X0_en(),
        .BRAM_PORT_X0_we(),
        .BRAM_PORT_X1_addr(),
        .BRAM_PORT_X1_clk(),
        .BRAM_PORT_X1_din(),
        .BRAM_PORT_X1_dout(),
        .BRAM_PORT_X1_en(),
        .BRAM_PORT_X1_we(),
        .BRAM_PORT_Y_addr(),
        .BRAM_PORT_Y_clk(),
        .BRAM_PORT_Y_din(),
        .BRAM_PORT_Y_dout(),
        .BRAM_PORT_Y_en(),
        .BRAM_PORT_Y_we(),
        .X0(X0), 
        .X1(X1),   
        .Y(Y),
        .address(address),
        .clk(clk),
        .din(),
        .we(3'b000));

    
    assign a1[0][0] = X0;
    assign a1[1][0] = X1;
    assign y[0][0] = Y;
    
     // generate clock
    always
        begin
            clk = 1; #5; clk = 0; #5;
        end

 initial begin   
 
 
    weights_file = $fopen("/home/manuel/Desktop/ICIL/Files/sim/python/initial_parameters.txt","r");
    //inputs_file = $fopen("/home/manuel/Desktop/ICIL/Files/sim/python/x_train.txt","r");
    //expected_outputs_file = $fopen("/home/manuel/Desktop/ICIL/Files/sim/python/y_train.txt","r");
    
    
    for(i=0; i<L2; i++) for(j=0; j<L1; j++)  $fscanf(weights_file,"%d",W1[i][j]);
    for(i=0; i<L2; i++)  $fscanf(weights_file,"%d",b1[i][0]);
    
    for(i=0; i<L3; i++) for(j=0; j<L2; j++)  $fscanf(weights_file,"%d",W2[i][j]);
    for(i=0; i<L3; i++)  $fscanf(weights_file,"%d",b2[i][0]);
   
    for(i=0; i<L4; i++) for(j=0; j<L3; j++)  $fscanf(weights_file,"%d",W3[i][j]);
    for(i=0; i<L4; i++)  $fscanf(weights_file,"%d",b3[i][0]);
    
       
    // Reset Signal
    reset = 0;  
    enable = 0;
    #100 reset = 1;
    
    // Enable Signal
    # 100 enable = 1;
         
        
    end

endmodule
    
