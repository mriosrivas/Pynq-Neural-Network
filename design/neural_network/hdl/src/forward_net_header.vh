//ROWS = output neurons
//COLUMNS = input size

// 3 -> 4 -> 2 -> 1


`ifndef forward_net_header
`define forward_net_header
    //parameter L1 = 3; // Number of Rows
    //parameter L2 = 4; // Number of Columns
    //parameter L3 = 2;
    //parameter L4 = 1;
    parameter L1 = 2; // Number of Rows
    parameter L2 = 5; // Number of Columns
    parameter L3 = 5;
    parameter L4 = 1;
    
    //delay between samples = COUNT_DELAY + 1 cycles.
    //parameter COUNT_DELAY = 9; //Use this when testing just neural network. (Data generated in testbench.)
    parameter COUNT_DELAY = 99; //Use this when testing memory for X0, X1 and Y.

`endif
