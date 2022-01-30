`include "forward_net_header.vh"
`include "typedef.vh"


module update(
    input data_type learning_rate,
    input data_type W1[0:L2-1][0:L1-1],
    input data_type W2[0:L3-1][0:L2-1],
    input data_type W3[0:L4-1][0:L3-1],    
    input data_type b1[0:L2-1][0:0],
    input data_type b2[0:L3-1][0:0],
    input data_type b3[0:L4-1][0:0],
    input data_type dW1[0:L2-1][0:L1-1],
    input data_type dW2[0:L3-1][0:L2-1],
    input data_type dW3[0:L4-1][0:L3-1],    
    input data_type db1[0:L2-1][0:0],
    input data_type db2[0:L3-1][0:0],
    input data_type db3[0:L4-1][0:0],
    output data_type W1_update[0:L2-1][0:L1-1],
    output data_type W2_update[0:L3-1][0:L2-1],
    output data_type W3_update[0:L4-1][0:L3-1],    
    output data_type b1_update[0:L2-1][0:0],
    output data_type b2_update[0:L3-1][0:0],
    output data_type b3_update[0:L4-1][0:0]);
    
    
    update_unit #(L2, L1) update_W1(.x(W1), .dx(dW1), .learning_rate(learning_rate), .y(W1_update));
    update_unit #(L3, L2) update_W2(.x(W2), .dx(dW2), .learning_rate(learning_rate), .y(W2_update));
    update_unit #(L4, L3) update_W3(.x(W3), .dx(dW3), .learning_rate(learning_rate), .y(W3_update));
    
    
    update_unit #(L2, 1) update_b1(.x(b1), .dx(db1), .learning_rate(learning_rate), .y(b1_update));
    update_unit #(L3, 1) update_b2(.x(b2), .dx(db2), .learning_rate(learning_rate), .y(b2_update));
    update_unit #(L4, 1) update_b3(.x(b3), .dx(db3), .learning_rate(learning_rate), .y(b3_update));
    
endmodule
    

module update_unit #(parameter M = 5, parameter N = 3)
    (input data_type x[0:M-1][0:N-1],
    input data_type dx[0:M-1][0:N-1],
    input data_type learning_rate,
    output data_type y[0:M-1][0:N-1]);
    
    genvar i, j;
        generate
            for(i=0; i<=M-1; i=i+1) begin
                for(j=0; j<=N-1; j=j+1) begin
                    assign y[i][j] = x[i][j] - (dx[i][j]>>>learning_rate);   
                end
            end
        
        endgenerate
    
endmodule