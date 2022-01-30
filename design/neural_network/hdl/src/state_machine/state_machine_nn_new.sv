//module state_machine_nn(
//        input logic clk, enable, reset, //Maybe I need to change this
//        output logic reset_local,
//        output logic block_reset_on_mux,
//        output logic en_forward,
//        output logic en_backward,
//        output logic load_initial_parameters,
//        output logic input_select,
//        output logic [31:0] address
//        );

//logic en_address, en_epochs, en_delay, first_epoch_done;
//logic [10:0] counter;
//logic [12:0] epochs;
//logic [10:0] delay_timer;

//reg [3:0] state;

//parameter state_0 = 0, 
//          state_1 = 1, 
//          state_2 = 2, 
//          state_3 = 3,
//          state_4 = 4,
//          state_5 = 5,
//          state_6 = 6,
//          state_7 = 7,
//          state_8 = 8,
//          state_9 = 9,
//          state_10 = 10;
          
//parameter DELAY = 2000;
//parameter COUNT = 100;
//parameter EPOCH = 0;

//always @(state) 
//     begin
//          case (state)
//               state_0: begin
//                    reset_local = 0;
//                    block_reset_on_mux = 0;
//                    en_forward = 0;
//                    en_backward = 0;
//                    load_initial_parameters = 0;
//                    input_select = 0;
//                    en_address = 0;
//                    en_epochs = 0;
//                    en_delay = 0;
//                    first_epoch_done = 0;
//                    end
//               state_1: begin
//                    reset_local = 1;
//                    block_reset_on_mux = 1;
//                    en_forward = 0;
//                    en_backward = 0;
//                    load_initial_parameters = 0;
//                    input_select = 0; 
//                    en_address = 0;   
//                    en_epochs = 0;      
//                    en_delay = 0;
//                    first_epoch_done = 0;    
//               end
//               state_2: begin
//                    reset_local = 1;
//                    block_reset_on_mux = 1;
//                    en_forward = 0;
//                    en_backward = 0;
//                    load_initial_parameters = 1;
//                    input_select = 0;   
//                    en_address = 0;
//                    en_epochs = 0;
//                    en_delay = 0;
//                    first_epoch_done = 0;
//               end
//               state_3: begin
//                    reset_local = 1;
//                    block_reset_on_mux = 1;
//                    en_forward = 0;
//                    en_backward = 0;
//                    load_initial_parameters = 0;
//                    input_select = 0;
//                    en_address = 0;
//                    en_epochs = 1;
//                    en_delay = 0;
//                    first_epoch_done = 0;
//               end
//               state_4: begin   //This is when first data is sent
//                    reset_local = 1;
//                    block_reset_on_mux = 1;
//                    en_forward = 1;
//                    en_backward = 1;
//                    load_initial_parameters = 0;
//                    input_select = 0;
//                    en_address = 1;
//                    en_epochs = 0;
//                    en_delay = 0;
//                    first_epoch_done = 0;
//                    //for address = 0 to address = 2048:
//                    //    get x0, x1 , y
//               end
//               state_5: begin
//                    reset_local = 1;
//                    block_reset_on_mux = 1;
//                    en_forward = 1;
//                    en_backward = 1;
//                    load_initial_parameters = 0;
//                    input_select = 0;   
//                    en_address = 0;    
//                    en_epochs = 1;  
//                    en_delay = 1;
//                    first_epoch_done = 0;   
//               end
//               state_6: begin //This is when a new epoch starts
//                    reset_local = 1;
//                    block_reset_on_mux = 1;
//                    en_forward = 1;
//                    en_backward = 1;
//                    load_initial_parameters = 0;
//                    if (!first_epoch_done) input_select = 0; //Here
//                    else input_select = 1; //Here
//                    en_address = 1;
//                    en_epochs = 0;
//                    en_delay = 0;
//                    //for address = 0 to address = 2048:
//                    //    get x0, x1 , y      
//               end
//               state_7: begin
//                    reset_local = 1;
//                    block_reset_on_mux = 1;
//                    en_forward = 1;
//                    en_backward = 1;
//                    load_initial_parameters = 0;
//                    if (!first_epoch_done) input_select = 0; //Here
//                    else input_select = 1; //Here
//                    //input_select = 0; //Here
//                    en_address = 0;
//                    en_epochs = 0;
//                    en_delay = 1;
//                    first_epoch_done = 1;
                                
//               end
//               state_8: begin
//                    reset_local = 0;
//                    block_reset_on_mux = 1;
//                    en_forward = 1;
//                    en_backward = 1;
//                    load_initial_parameters = 0;
//                    input_select = 0;
//                    en_address = 0; 
//                    en_epochs = 1; 
//                    en_delay = 0;
//                    first_epoch_done = 1;
//                    //goto state 6 until all epochs finish    
//               end
//               state_9: begin
//                    reset_local = 1;
//                    block_reset_on_mux = 1;
//                    en_forward = 0;
//                    en_backward = 0;
//                    load_initial_parameters = 0;
//                    input_select = 1;
//                    en_address = 0;
//                    en_epochs = 0;
//                    en_delay = 1;
//                    first_epoch_done = 1;
//               end
//               state_10: begin
//                    reset_local = 1;
//                    block_reset_on_mux = 1;
//                    en_forward = 0;
//                    en_backward = 0;
//                    load_initial_parameters = 0;
//                    input_select = 1;
//                    en_address = 0;
//                    en_epochs = 0;
//                    en_delay = 0;
//                    first_epoch_done = 1;
//               end
               
//               default: begin
//                    reset_local = 0;
//                    block_reset_on_mux = 0;
//                    en_forward = 0;
//                    en_backward = 0;
//                    load_initial_parameters = 0;
//                    input_select = 0;
//                    en_address = 0;
//                    en_epochs = 0;
//                    first_epoch_done = 1;
//                    end
//          endcase
//     end

//always @(posedge clk or posedge reset)
//     begin
//          if (!reset)
//               state = state_0;
//          else if(enable)
//               case (state)
//                    state_0:
//                         state = state_1;
//                    state_1:
//                         state = state_2;
//                    state_2:
//                         state = state_3;
//                    state_3:
//                         state = state_4;
//                    state_4:
//                        if (address == 2047) state = state_5;
//                        else state = state_4;
//                    state_5:
//                         state = state_6;
//                    state_6:
//                        if (address == 2047) state = state_7;
//                        else state = state_6;
//                    state_7:
//                        if (delay_timer < DELAY) state = state_7;
//                        else state = state_8;
//                    state_8:
//                        if (epochs == EPOCH) state = state_9;
//                        else state = state_6;
//                    state_9:
//                        if (delay_timer < DELAY) state = state_9;
//                        else state = state_10;
//                    state_10:
//                        state = state_10;
//               endcase
//     end



//always @(posedge clk) begin
//    if (!reset) counter <= 0;
//    else if(en_address) begin
//          if(counter < COUNT)
//                counter <= counter + 1;
//          else counter <= 0;
//          end
                

//end

//always @(posedge clk) begin
//    if (!reset) epochs <= 0;
//    else if(en_epochs) begin
//          if(epochs < EPOCH)
//                epochs <= epochs + 1;
//          else epochs <= 0;
//          end
                

//end

//always @(posedge clk) begin
//    if (!reset) delay_timer <= 0;
//    else if(en_delay) begin
//          if(delay_timer < DELAY)
//                delay_timer <= delay_timer + 1;
//          else delay_timer <= 0;
//          end
                

//end

  
//always @(posedge clk) begin
//    if (!reset) address <= 0;
//    else if (en_address) begin
//          if((counter == COUNT) && (address < 2048) && (!en_delay)) address <= address + 1;
//          end
//    else if (!en_address && en_delay) address <= 2047;
//    else if (!en_address && !en_delay) address <= 0;               

//end


//endmodule


module state_machine_nn(
        input logic clk, enable, reset, //Maybe I need to change this
        output logic reset_local,
        output logic block_reset_on_mux,
        output logic en_forward,
        output logic en_backward,
        output logic load_initial_parameters,
        output logic input_select,
        output logic [31:0] address,
        input logic [12:0] EPOCH,
        output logic [63:0] timer
        
        );

logic en_address, en_epochs, en_delay, first_epoch_done;
logic [10:0] counter;
logic [12:0] epochs;
logic [10:0] delay_timer;
logic [4:0] delay_load_initial;

reg [4:0] state;

parameter state_0 = 0, 
          state_1 = 1, 
          state_2 = 2, 
          state_3 = 3,
          state_4 = 4,
          state_5 = 5,
          state_6 = 6,
          state_7 = 7,
          state_8 = 8,
          state_9 = 9,
          state_10 = 10,
          state_11 = 11,
          state_12 = 12,
          state_13 = 13,
          state_14 = 14,
          state_15 = 15,
          state_16 = 16,
          state_17 = 17,
          state_18 = 18;
          
parameter DELAY = 2000; //2000 for ROM
parameter COUNT = 250; //100 for ROM
parameter DELAY_LOAD_INITIAL = 4;
//parameter EPOCH = 0;

always @(state) 
     begin
          case (state)
               state_0: begin
                    reset_local <= 0;
                    block_reset_on_mux <= 0;
                    en_forward <= 0;
                    en_backward <= 0;
                    load_initial_parameters <= 0;
                    input_select <= 0;
                    en_address <= 0;
                    en_epochs <= 0;
                    en_delay <= 0;
                    first_epoch_done <= 0;
                    end
                    
               state_1: begin
                    reset_local <= 1;
                    block_reset_on_mux <= 1;
                    en_forward <= 0;
                    en_backward <= 0;
                    load_initial_parameters <= 0;
                    input_select <= 0;
                    en_address <= 0;
                    en_epochs <= 0;
                    en_delay <= 0;
                    first_epoch_done <= 0;
                    end
                    
               state_2: begin
                    reset_local <= 1;
                    block_reset_on_mux <= 1;
                    en_forward <= 0;
                    en_backward <= 0;
                    load_initial_parameters <= 1;
                    input_select <= 0;
                    en_address <= 0;
                    en_epochs <= 0;
                    en_delay <= 0;
                    first_epoch_done <= 0;
                    end
                    
               state_3: begin
                    reset_local <= 1;
                    block_reset_on_mux <= 1;
                    en_forward <= 0;
                    en_backward <= 0;
                    load_initial_parameters <= 0;
                    input_select <= 0;
                    en_address <= 0;
                    en_epochs <= 1;
                    en_delay <= 0;
                    first_epoch_done <= 0;
                    end
                    
               state_4: begin
                    reset_local <= 1;
                    block_reset_on_mux <= 1;
                    en_forward <= 1;
                    en_backward <= 1;
                    load_initial_parameters <= 0;
                    input_select <= 0;
                    en_address <= 1;
                    en_epochs <= 0;
                    en_delay <= 0;
                    first_epoch_done <= 0;
                    end
                    
               state_5: begin
                    reset_local <= 1;
                    block_reset_on_mux <= 1;
                    en_forward <= 1;
                    en_backward <= 1;
                    load_initial_parameters <= 0;
                    input_select <= 0;
                    en_address <= 1;
                    en_epochs <= 0;
                    en_delay <= 0;
                    first_epoch_done <= 0;
                    end
                    
               state_6: begin
                    reset_local <= 1;
                    block_reset_on_mux <= 1;
                    en_forward <= 1;
                    en_backward <= 1;
                    load_initial_parameters <= 0;
                    input_select <= 0;
                    en_address <= 0;
                    en_epochs <= 1;
                    en_delay <= 1;
                    first_epoch_done <= 0;
                    end
                    
                state_7: begin
                    reset_local <= 1;
                    block_reset_on_mux <= 1;
                    en_forward <= 1;
                    en_backward <= 1;
                    load_initial_parameters <= 0;
                    input_select <= 0;
                    en_address <= 1;
                    en_epochs <= 0;
                    en_delay <= 0;
                    first_epoch_done <= 0;
                    end
                    
               state_8: begin
                    reset_local <= 1;
                    block_reset_on_mux <= 1;
                    en_forward <= 1;
                    en_backward <= 1;
                    load_initial_parameters <= 0;
                    input_select <= 0;
                    en_address <= 1;
                    en_epochs <= 0;
                    en_delay <= 0;
                    first_epoch_done <= 0;
                    end
                    
               state_9: begin
                    reset_local <= 1;
                    block_reset_on_mux <= 1;
                    en_forward <= 1;
                    en_backward <= 1;
                    load_initial_parameters <= 0;
                    input_select <= 0;
                    en_address <= 0;
                    en_epochs <= 0;
                    en_delay <= 1;
                    first_epoch_done <= 1;
                    end
                    
                state_10: begin
                    reset_local <= 1;
                    block_reset_on_mux <= 1;
                    en_forward <= 1;
                    en_backward <= 1;
                    load_initial_parameters <= 0;
                    input_select <= 0;
                    en_address <= 0;
                    en_epochs <= 0;
                    en_delay <= 1;
                    first_epoch_done <= 1;
                    end
                    
               state_11: begin
                    reset_local <= 0;
                    block_reset_on_mux <= 1;
                    en_forward <= 1;
                    en_backward <= 1;
                    load_initial_parameters <= 0;
                    input_select <= 0;
                    en_address <= 0;
                    en_epochs <= 1;
                    en_delay <= 0;
                    first_epoch_done <= 1;
                    end
                    
               state_12: begin
                    reset_local <= 1;
                    block_reset_on_mux <= 1;
                    en_forward <= 1;
                    en_backward <= 1;
                    load_initial_parameters <= 0;
                    input_select <= 1;
                    en_address <= 1;
                    en_epochs <= 0;
                    en_delay <= 0;
                    first_epoch_done <= 1;
                    end
                    
              state_13: begin
                    reset_local <= 1;
                    block_reset_on_mux <= 1;
                    en_forward <= 1;
                    en_backward <= 1;
                    load_initial_parameters <= 0;
                    input_select <= 1;
                    en_address <= 1;
                    en_epochs <= 0;
                    en_delay <= 0;
                    first_epoch_done <= 1;
                    end
                    
              state_14: begin
                    reset_local <= 1;
                    block_reset_on_mux <= 1;
                    en_forward <= 1;
                    en_backward <= 1;
                    load_initial_parameters <= 0;
                    input_select <= 1;
                    en_address <= 0;
                    en_epochs <= 0;
                    en_delay <= 1;
                    first_epoch_done <= 1;
                    end
                    
              state_15: begin
                    reset_local <= 1;
                    block_reset_on_mux <= 1;
                    en_forward <= 1;
                    en_backward <= 1;
                    load_initial_parameters <= 0;
                    input_select <= 1;
                    en_address <= 0;
                    en_epochs <= 0;
                    en_delay <= 1;
                    first_epoch_done <= 1;
                    end
                    
               state_16: begin
                    reset_local <= 1;
                    block_reset_on_mux <= 0;
                    en_forward <= 0;
                    en_backward <= 0;
                    load_initial_parameters <= 0;
                    input_select <= 1;
                    en_address <= 0;
                    en_epochs <= 0;
                    en_delay <= 1;
                    first_epoch_done <= 1;
                    end
                    
                state_17: begin
                    reset_local <= 1;
                    block_reset_on_mux <= 0;
                    en_forward <= 0;
                    en_backward <= 0;
                    load_initial_parameters <= 0;
                    input_select <= 1;
                    en_address <= 0;
                    en_epochs <= 0;
                    en_delay <= 1;
                    first_epoch_done <= 1;
                    end
                    
                state_18: begin
                    reset_local <= 1;
                    block_reset_on_mux <= 0;
                    en_forward <= 0;
                    en_backward <= 0;
                    load_initial_parameters <= 0;
                    input_select <= 1;
                    en_address <= 0;
                    en_epochs <= 0;
                    en_delay <= 0;
                    first_epoch_done <= 1;
                    end
               
               default: begin
                    reset_local <= 0;
                    block_reset_on_mux <= 0;
                    en_forward <= 0;
                    en_backward <= 0;
                    load_initial_parameters <= 0;
                    input_select <= 0;
                    en_address <= 0;
                    en_epochs <= 0;
                    en_delay <= 0;
                    first_epoch_done <= 0;
                    end
          endcase
     end

always @(posedge clk or posedge reset)
     begin
          if (!reset)
               state = state_0;
          else if(enable)
               case (state)
                    state_0:
                         state = state_1;
                    state_1:
                         state = state_2;
                    state_2:
                        if (delay_load_initial < DELAY_LOAD_INITIAL) state = state_2;
                         else state = state_3;
                    state_3:
                         state = state_4;
                    state_4:
                        state = state_5;
                    state_5:
                         if (address == 2047) state = state_6;
                         else state = state_5;
                    state_6:
                        state = state_7;
                    state_7:
                        state = state_8;
                    state_8:
                        if (address == 2047) state = state_9;
                        else state = state_8;
                    state_9:
                        state = state_10;
                    state_10:
                        if (delay_timer < DELAY) state = state_10;
                        else state = state_11;
                    state_11:
                        state = state_12;
                    state_12:
                        state = state_13;
                    state_13:
                         if (address == 2047) state = state_14;
                         else state = state_13;
                    state_14:
                        state = state_15;
                    state_15:
                        if (epochs != EPOCH) begin
                            if (delay_timer < DELAY) state = state_15;
                            else state = state_11; 
                        end
                        else begin
                            if (delay_timer < DELAY) state = state_15;
                            else state = state_16; 
                        end
                    state_16:
                        state = state_17;
                    state_17:
                        if (delay_timer < DELAY) state = state_17;
                        else state = state_18;
                    state_18:
                        state = state_18;                                   
               endcase
     end



always @(posedge clk) begin
    if (!reset) counter <= 0;
    else if(en_address) begin
          if(counter < COUNT)
                counter <= counter + 1;
          else counter <= 0;
          end
                

end

always @(posedge clk) begin
    if (!reset) epochs <= 0;
    else if(en_epochs) begin
          if(epochs < EPOCH)
                epochs <= epochs + 1;
          else epochs <= 0;
          end
                

end

always @(posedge clk) begin
    if (!reset) delay_timer <= 0;
    else if(en_delay) begin
          if(delay_timer < DELAY)
                delay_timer <= delay_timer + 1;
          else delay_timer <= 0;
          end
                

end



always @(posedge clk) begin
    if (!reset) delay_load_initial <= 0;
    else if(load_initial_parameters) begin
          if(delay_load_initial < DELAY_LOAD_INITIAL)
                delay_load_initial <= delay_load_initial + 1;
          else delay_load_initial <= 0;
          end
                

end

  
always @(posedge clk) begin
    if (!reset) address <= 0;
    else if (en_address) begin
          if((counter == COUNT) && (address < 2048) && (!en_delay)) address <= address + 1;
          end
    else if (!en_address && en_delay) address <= 2047;
    else if (!en_address && !en_delay) address <= 0;               

end



always @(posedge clk) 
    begin
        if (!reset) timer <= 0;
        else if(enable && en_forward) 
            begin
                timer <= timer + 1;
             end
    end

endmodule
