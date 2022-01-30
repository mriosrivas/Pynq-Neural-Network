`include "forward_net_header.vh"
`include "typedef.vh"


/*module neural_network_tb();
    parameter INITIAL_INPUT = 1'b0;
    parameter UPDATE = 1'b1;

    //logic clk, reset;//, en_acc;
    data_type W1[0:L2-1][0:L1-1];
    data_type W2[0:L3-1][0:L2-1];
    data_type W3[0:L4-1][0:L3-1];
       
    data_type b1[0:L2-1][0:0];
    data_type b2[0:L3-1][0:0];
    data_type b3[0:L4-1][0:0];
    
    data_type a1[0:L1-1][0:0];
    data_type y[0:L4-1][0:0];
    
    logic clk, reset, block_reset_on_mux, en_forward, en_backward, load_inital_parameters, input_select;
    
    integer i;
    parameter ITERATIONS = 100;
    
    neural_network dut(.clk(clk), .reset(reset), .block_reset_on_mux(block_reset_on_mux), 
    .en_forward(en_forward), .en_backward(en_backward), .load_inital_parameters(load_inital_parameters), .input_select(input_select),
    .W1(W1), .W2(W2), .W3(W3), .b1(b1), .b2(b2), .b3(b3), .a1(a1), .y(y));
    
     // generate clock
    always
        begin
            clk = 1; #5; clk = 0; #5;
        end

 initial begin   
    W1[0][0]=1898;
    W1[0][1]=-2408;
    W1[1][0]=-775;
    W1[1][1]=-2429;
    W1[2][0]=3000;
    W1[2][1]=-3128;
    W1[3][0]=2304;
    W1[3][1]=-3307;
    W1[4][0]=-1027;
    W1[4][1]=-1389;
     
    W2[0][0]=1738;
    W2[0][1]=-1173;
    W2[0][2]=3065;
    W2[0][3]=-2391;
    W2[0][4]=3722;
    W2[1][0]=2965;
    W2[1][1]=1143;
    W2[1][2]=3494;
    W2[1][3]=-1568;
    W2[1][4]=1684;
    W2[2][0]=1964;
    W2[2][1]=2653;
    W2[2][2]=-2649;
    W2[2][3]=2446;
    W2[2][4]=-520;
    W2[3][0]=-486;
    W2[3][1]=337;
    W2[3][2]=-2598;
    W2[3][3]=-1386;
    W2[3][4]=-3262;
    W2[4][0]=-1790;
    W2[4][1]=4031;
    W2[4][2]=-708;
    W2[4][3]=641;
    W2[4][4]=-77;
    
    W3[0][0]=-3238;
    W3[0][1]=3653;
    W3[0][2]=2920;
    W3[0][3]=622;
    W3[0][4]=1633;
    
    b1[0][0]=0;
    b1[1][0]=0;
    b1[2][0]=0;
    b1[3][0]=0;
    b1[4][0]=0;
    
    b2[0][0]=0;
    b2[1][0]=0;
    b2[2][0]=0;
    b2[3][0]=0;
    b2[4][0]=0;
    
    b3[0][0]=0;

//    b1[0][0]=-30;
//    b1[1][0]=-167;
//    b1[2][0]=21;
//    b1[3][0]=-38;
//    b1[4][0]=56;
    
//    b2[0][0]=98;
//    b2[1][0]=-112;
//    b2[2][0]=-90;
//    b2[3][0]=0;
//    b2[4][0]=-50;
    
//    b3[0][0]=-125;


//    W1[0][0]=1896;
//    W1[0][1]=-2397;
//    W1[1][0]=-682;
//    W1[1][1]=-2420;
//    W1[2][0]=3001;
//    W1[2][1]=-3137;
//    W1[3][0]=2301;
//    W1[3][1]=-3293;
//    W1[4][0]=-1059;
//    W1[4][1]=-1393;
    
//    W2[0][0]=1750;
//    W2[0][1]=-1160;
//    W2[0][2]=3081;
//    W2[0][3]=-2375;
//    W2[0][4]=3737;
//    W2[1][0]=2951;
//    W2[1][1]=1127;
//    W2[1][2]=3475;
//    W2[1][3]=-1587;
//    W2[1][4]=1666;
//    W2[2][0]=1953;
//    W2[2][1]=2640;
//    W2[2][2]=-2664;
//    W2[2][3]=2431;
//    W2[2][4]=-535;
//    W2[3][0]=-486;
//    W2[3][1]=337;
//    W2[3][2]=-2598;
//    W2[3][3]=-1386;
//    W2[3][4]=-3262;
//    W2[4][0]=-1797;
//    W2[4][1]=4023;
//    W2[4][2]=-717;
//    W2[4][3]=632;
//    W2[4][4]=-86;
    
//    W3[0][0]=-3261;
//    W3[0][1]=3619;
//    W3[0][2]=2904;
//    W3[0][3]=622;
//    W3[0][4]=1622;
    
//    b1[0][0]=-30;
//    b1[1][0]=-167;
//    b1[2][0]=21;
//    b1[3][0]=-38;
//    b1[4][0]=56;
    
//    b2[0][0]=98;
//    b2[1][0]=-112;
//    b2[2][0]=-90;
//    b2[3][0]=0;
//    b2[4][0]=-50;
    
//    b3[0][0]=-125;

    
    //First Iteration
    
    
    
    en_forward = 0;
    en_backward = 0;
    block_reset_on_mux = 0;
    
    // Reset Signal
    reset = 0;  
    #100 reset = 1;
    
    // Signal that Blocks Main Reset Signal
    block_reset_on_mux = 1;
    
    // Initial selection of weights and biases
    #100 input_select = INITIAL_INPUT;
    
    // Pulse signal to load weights and biases
    load_inital_parameters = 0; 
    #10 load_inital_parameters = 1;
    #10 load_inital_parameters = 0;
    
    //Start calculation of Neural Network
    #100 en_forward = 1; en_backward = 1;
    
    // Iteration no. 1
    //First value
    y[0][0] = 4096;
    a1[0][0] = -4750;
    a1[1][0] = 1013;
    // Second value    
    #100 y[0][0] = 4096;
    a1[0][0] = 250;
    a1[1][0] = -1555;
    // Wait
    #1500
    
    
    for(i=0; i<ITERATIONS-1;i++) begin 
    //Iteration no. 2
    // Pulse reset
    reset = 0; #100 reset = 1; 
    input_select = UPDATE;
    //First value
    y[0][0] = 4096;
    a1[0][0] = -4750;
    a1[1][0] = 1013;
    // Second value     
    #100 y[0][0] = 4096;
    a1[0][0] = 250;
    a1[1][0] = -1555;
    // Wait
    #1500;
    end
    
//    //Iteration no. 3
//    // Pulse reset
//    reset = 0; #100 reset = 1; 
//    input_select = UPDATE;
//    //First value
//    y[0][0] = 4096;
//    a1[0][0] = -4750;
//    a1[1][0] = 1013;
//    // Second value     
//    #100 y[0][0] = 4096;
//    a1[0][0] = 250;
//    a1[1][0] = -1555;
//    // Wait
//    #1500;
        
    end

endmodule*/


module neural_network_tb();
    parameter INITIAL_INPUT = 1'b0;
    parameter UPDATE = 1'b1;

    //logic clk, reset;//, en_acc;
    data_type W1[0:L2-1][0:L1-1];
    data_type W2[0:L3-1][0:L2-1];
    data_type W3[0:L4-1][0:L3-1];
       
    data_type b1[0:L2-1][0:0];
    data_type b2[0:L3-1][0:0];
    data_type b3[0:L4-1][0:0];
    
    data_type a1[0:L1-1][0:0];
    data_type y[0:L4-1][0:0];
    
    logic clk, reset, block_reset_on_mux, en_forward, en_backward, load_inital_parameters, input_select;
    
    integer i, j, k;
    integer weights_file, inputs_file, expected_outputs_file, gradient_cross_entropy_file;
    parameter EPOCHS = 100;
    parameter SIZE_OF_X = 2048;
    
    neural_network dut(.clk(clk), .reset(reset), .block_reset_on_mux(block_reset_on_mux), 
    .en_forward(en_forward), .en_backward(en_backward), .load_inital_parameters(load_inital_parameters), .input_select(input_select),
    .W1(W1), .W2(W2), .W3(W3), .b1(b1), .b2(b2), .b3(b3), .a1(a1), .y(y));
    
     // generate clock
    always
        begin
            clk = 1; #5; clk = 0; #5;
        end

 initial begin   
 
 
    weights_file = $fopen("/home/manuel/Desktop/ICIL/Files/sim/python/initial_parameters.txt","r");
    inputs_file = $fopen("/home/manuel/Desktop/ICIL/Files/sim/python/x_train.txt","r");
    expected_outputs_file = $fopen("/home/manuel/Desktop/ICIL/Files/sim/python/y_train.txt","r");
    
    
    for(i=0; i<L2; i++) for(j=0; j<L1; j++)  $fscanf(weights_file,"%d",W1[i][j]);
    for(i=0; i<L2; i++)  $fscanf(weights_file,"%d",b1[i][0]);
    
    for(i=0; i<L3; i++) for(j=0; j<L2; j++)  $fscanf(weights_file,"%d",W2[i][j]);
    for(i=0; i<L3; i++)  $fscanf(weights_file,"%d",b2[i][0]);
   
    for(i=0; i<L4; i++) for(j=0; j<L3; j++)  $fscanf(weights_file,"%d",W3[i][j]);
    for(i=0; i<L4; i++)  $fscanf(weights_file,"%d",b3[i][0]);
    
    
    en_forward = 0;
    en_backward = 0;
    block_reset_on_mux = 0;
    
    // Reset Signal
    reset = 0;  
    #100 reset = 1;
    
    // Signal that Blocks Main Reset Signal
    block_reset_on_mux = 1;
    
    // Initial selection of weights and biases
    #100 input_select = INITIAL_INPUT;
    
    // Pulse signal to load weights and biases
    load_inital_parameters = 0; 
    #10 load_inital_parameters = 1;
    #10 load_inital_parameters = 0;
    
    //Start calculation of Neural Network
    #100 en_forward = 1; en_backward = 1;
    //y[0][0] = 0;
 
 for (k=0; k<EPOCHS; k++) begin 
    for(j=0; j<SIZE_OF_X; j++) begin 
      for(i=0; i<L1; i++) 
       begin
       $fscanf(inputs_file,"%d",a1[i][0]);
       if(i==0) $fscanf(expected_outputs_file,"%d",y[i][0]);
       end
       #100;
   end
   $rewind(inputs_file);
   $rewind(expected_outputs_file);
   #2000 reset = 0; #100 reset = 1; 
   input_select = UPDATE;
   
 end
   

    
//    //First Iteration
    
    
    
//    en_forward = 0;
//    en_backward = 0;
//    block_reset_on_mux = 0;
    
//    // Reset Signal
//    reset = 0;  
//    #100 reset = 1;
    
//    // Signal that Blocks Main Reset Signal
//    block_reset_on_mux = 1;
    
//    // Initial selection of weights and biases
//    #100 input_select = INITIAL_INPUT;
    
//    // Pulse signal to load weights and biases
//    load_inital_parameters = 0; 
//    #10 load_inital_parameters = 1;
//    #10 load_inital_parameters = 0;
    
//    //Start calculation of Neural Network
//    #100 en_forward = 1; en_backward = 1;
    
//    // Iteration no. 1
//    //First value
//    y[0][0] = 4096;
//    a1[0][0] = -4750;
//    a1[1][0] = 1013;
//    // Second value    
//    #100 y[0][0] = 4096;
//    a1[0][0] = 250;
//    a1[1][0] = -1555;
//    // Wait
//    #1500
    
    
//    for(i=0; i<ITERATIONS-1;i++) begin 
//    //Iteration no. 2
//    // Pulse reset
//    reset = 0; #100 reset = 1; 
//    input_select = UPDATE;
//    //First value
//    y[0][0] = 4096;
//    a1[0][0] = -4750;
//    a1[1][0] = 1013;
//    // Second value     
//    #100 y[0][0] = 4096;
//    a1[0][0] = 250;
//    a1[1][0] = -1555;
//    // Wait
//    #1500;
//    end
    
        
    end

endmodule
