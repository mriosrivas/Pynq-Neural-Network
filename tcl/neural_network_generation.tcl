# Define project name
set project_name "neural_network"

# Define project path
set project_path "/home/manuel/Desktop/ICIL/New_Neural_Network/projects/"

# Define file dependencies
# Source files
set src_files "/home/manuel/Desktop/ICIL/New_Neural_Network/design/neural_network/hdl/src/"
# Simulation files
set sim_files "/home/manuel/Desktop/ICIL/New_Neural_Network/design/neural_network/hdl/sim/"
# Memory files
set mem_src_files "/home/manuel/Desktop/ICIL/New_Neural_Network/design/neural_network/mem/src/"
set mem_sim_files "/home/manuel/Desktop/ICIL/New_Neural_Network/design/neural_network/mem/sim/"

# Set project path and name
append project_full_path $project_path
append project_full_path $project_name

create_project $project_name $project_full_path -part xc7z020clg400-1

set_property board_part www.digilentinc.com:pynq-z1:part0:1.0 [current_project]

current_project $project_name

# Import HDL files

import_files -norecurse [join [list $src_files typedef.vh] ""]
import_files -norecurse [join [list $src_files forward_net_header.vh] ""]
import_files -norecurse [join [list $src_files forward_propagation_net.sv] ""]
import_files -norecurse [join [list $src_files neural_network.sv] ""]
import_files -norecurse [join [list $src_files state_machine_nn.sv] ""] 
import_files -norecurse [join [list $src_files loss.sv] ""] 
import_files -norecurse [join [list $src_files cross_entropy_table_1.sv] ""] 
import_files -norecurse [join [list $src_files accumulator.sv] ""] 
import_files -norecurse [join [list $src_files cross_entropy_table_2.sv] ""] 
import_files -norecurse [join [list $src_files bias.sv] ""] 
import_files -norecurse [join [list $src_files backward_net.sv] ""] 
import_files -norecurse [join [list $src_files neurons.sv] ""] 
import_files -norecurse [join [list $src_files layered_flip_flop.sv] ""] 
import_files -norecurse [join [list $src_files mux_input_neural_network.sv] ""] 
import_files -norecurse [join [list $src_files auxiliary_modules.sv] ""] 
import_files -norecurse [join [list $src_files forward_net.sv] ""] 
import_files -norecurse [join [list $src_files top_neural_network.sv] ""] 
import_files -norecurse [join [list $src_files neural_net_top.sv] ""] 
import_files -norecurse [join [list $src_files sigma_int.sv] ""] 
import_files -norecurse [join [list $src_files transpose.sv] ""] 
import_files -norecurse [join [list $src_files relu.sv] ""] 
import_files -norecurse [join [list $src_files sigmoid.sv] ""] 
import_files -norecurse [join [list $src_files backward_propagation_net.sv] ""] 
import_files -norecurse [join [list $src_files mult.sv] ""] 
import_files -norecurse [join [list $src_files update.sv] ""]

update_compile_order -fileset sources_1

# Set top module
set_property top neural_net_double_data_top [current_fileset]
update_compile_order -fileset sources_1

# Import Simulation files
set_property SOURCE_SET sources_1 [get_filesets sim_1]
import_files -fileset sim_1 -norecurse [join [list $sim_files top_module_neural_network_tb.sv] ""]
import_files -fileset sim_1 -norecurse [join [list $sim_files neural_network_tb.sv] ""]
update_compile_order -fileset sim_1

# Set top module for simulation
set_property top top_neural_network_tb [get_filesets sim_1]
set_property top_lib xil_defaultlib [get_filesets sim_1]
update_compile_order -fileset sim_1

# Create Sigmoid Memory
create_bd_design "BRAM"
update_compile_order -fileset sources_1
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_0
endgroup

set sigmoid_coe_path [join [list $mem_src_files sigmoid.coe] ""]

# Memory parameters
set_property -dict [list CONFIG.Memory_Type {Single_Port_ROM} CONFIG.Enable_32bit_Address {false} CONFIG.Use_Byte_Write_Enable {false} CONFIG.Byte_Size {9} CONFIG.Write_Width_A {12} CONFIG.Write_Depth_A {65536} CONFIG.Read_Width_A {12} CONFIG.Enable_A {Always_Enabled} CONFIG.Write_Width_B {12} CONFIG.Read_Width_B {12} CONFIG.Register_PortA_Output_of_Memory_Primitives {true} CONFIG.Load_Init_File {true} CONFIG.Coe_File $sigmoid_coe_path CONFIG.Use_RSTA_Pin {false} CONFIG.Port_A_Write_Rate {0} CONFIG.use_bram_block {Stand_Alone} CONFIG.EN_SAFETY_CKT {false}] [get_bd_cells blk_mem_gen_0]

startgroup
make_bd_pins_external  [get_bd_pins blk_mem_gen_0/addra] [get_bd_pins blk_mem_gen_0/clka] [get_bd_pins blk_mem_gen_0/douta]
endgroup

regenerate_bd_layout
validate_bd_design
save_bd_design

# Make wrapper
set sigmoid_memory_board_path [join [list $project_full_path / $project_name .srcs/sources_1/bd/BRAM/BRAM.bd] ""]
make_wrapper -files [get_files $sigmoid_memory_board_path] -top

set sigmoid_memory_wrapper_path [join [list $project_full_path / $project_name .srcs/sources_1/bd/BRAM/hdl/BRAM_wrapper.v] ""]
add_files -norecurse $sigmoid_memory_wrapper_path
update_compile_order -fileset sources_1


# For Simulation
# Create Data Memory
create_bd_design "data"
update_compile_order -fileset sources_1
# Memory for X0
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_0
endgroup

set x0_coe_path [join [list $mem_sim_files X0.coe] ""]
set_property -dict [list CONFIG.Memory_Type {Single_Port_ROM} CONFIG.Enable_32bit_Address {false} CONFIG.Use_Byte_Write_Enable {false} CONFIG.Byte_Size {9} CONFIG.Write_Depth_A {2048} CONFIG.Enable_A {Always_Enabled} CONFIG.Register_PortA_Output_of_Memory_Primitives {true} CONFIG.Load_Init_File {true} CONFIG.Coe_File $x0_coe_path CONFIG.Use_RSTA_Pin {false} CONFIG.Port_A_Write_Rate {0} CONFIG.use_bram_block {Stand_Alone} CONFIG.EN_SAFETY_CKT {false}] [get_bd_cells blk_mem_gen_0]

# Memory for X1
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_1
endgroup

set x1_coe_path [join [list $mem_sim_files X1.coe] ""]
set_property -dict [list CONFIG.Memory_Type {Single_Port_ROM} CONFIG.Enable_32bit_Address {false} CONFIG.Use_Byte_Write_Enable {false} CONFIG.Byte_Size {9} CONFIG.Write_Depth_A {2048} CONFIG.Enable_A {Always_Enabled} CONFIG.Register_PortA_Output_of_Memory_Primitives {true} CONFIG.Load_Init_File {true} CONFIG.Coe_File $x1_coe_path CONFIG.Use_RSTA_Pin {false} CONFIG.Port_A_Write_Rate {0} CONFIG.use_bram_block {Stand_Alone} CONFIG.EN_SAFETY_CKT {false}] [get_bd_cells blk_mem_gen_1]

# Memory for Y
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_2
endgroup

set y_coe_path [join [list $mem_sim_files Y.coe] ""]
set_property -dict [list CONFIG.Memory_Type {Single_Port_ROM} CONFIG.Enable_32bit_Address {false} CONFIG.Use_Byte_Write_Enable {false} CONFIG.Byte_Size {9} CONFIG.Write_Depth_A {2048} CONFIG.Enable_A {Always_Enabled} CONFIG.Register_PortA_Output_of_Memory_Primitives {true} CONFIG.Load_Init_File {true} CONFIG.Coe_File $y_coe_path CONFIG.Use_RSTA_Pin {false} CONFIG.Port_A_Write_Rate {0} CONFIG.use_bram_block {Stand_Alone} CONFIG.EN_SAFETY_CKT {false}] [get_bd_cells blk_mem_gen_2]

regenerate_bd_layout

startgroup
make_bd_pins_external  [get_bd_pins blk_mem_gen_0/addra]
connect_bd_net [get_bd_ports addra_0] [get_bd_pins blk_mem_gen_1/addra]
connect_bd_net [get_bd_ports addra_0] [get_bd_pins blk_mem_gen_2/addra]
endgroup
set_property name address [get_bd_ports addra_0]

startgroup
make_bd_pins_external  [get_bd_pins blk_mem_gen_0/clka]
connect_bd_net [get_bd_ports clka_0] [get_bd_pins blk_mem_gen_1/clka]
connect_bd_net [get_bd_ports clka_0] [get_bd_pins blk_mem_gen_2/clka]
endgroup
set_property name clk [get_bd_ports clka_0]

startgroup
make_bd_pins_external  [get_bd_pins blk_mem_gen_0/douta]
make_bd_pins_external  [get_bd_pins blk_mem_gen_1/douta]
make_bd_pins_external  [get_bd_pins blk_mem_gen_2/douta]
endgroup

set_property name X0 [get_bd_ports douta_0]
set_property name X1 [get_bd_ports douta_1]
set_property name Y [get_bd_ports douta_2]

regenerate_bd_layout
validate_bd_design
save_bd_design

# Make wrapper
set data_memory_board_path [join [list $project_full_path / $project_name .srcs/sources_1/bd/data/data.bd] ""]
make_wrapper -files [get_files $data_memory_board_path] -top

set data_memory_wrapper_path [join [list $project_full_path / $project_name .srcs/sources_1/bd/data/hdl/data_wrapper.v] ""]
add_files -norecurse $data_memory_wrapper_path
update_compile_order -fileset sources_1

# For Synthesis
# Create Double Data Memory
create_bd_design "data_double"
update_compile_order -fileset sources_1

# Memory for X0
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_0
endgroup
set_property -dict [list CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Enable_32bit_Address {true} CONFIG.Use_Byte_Write_Enable {true} CONFIG.Byte_Size {8} CONFIG.Write_Depth_A {2048} CONFIG.Enable_A {Always_Enabled} CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Register_PortA_Output_of_Memory_Primitives {true} CONFIG.Register_PortB_Output_of_Memory_Primitives {true} CONFIG.Load_Init_File {true} CONFIG.Coe_File $x0_coe_path CONFIG.Use_RSTA_Pin {true} CONFIG.Use_RSTB_Pin {true} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Port_B_Enable_Rate {100} CONFIG.use_bram_block {Stand_Alone} CONFIG.EN_SAFETY_CKT {true}] [get_bd_cells blk_mem_gen_0]

# Memory for X1
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_1
endgroup
set_property -dict [list CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Enable_32bit_Address {true} CONFIG.Use_Byte_Write_Enable {true} CONFIG.Byte_Size {8} CONFIG.Write_Depth_A {2048} CONFIG.Enable_A {Always_Enabled} CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Register_PortA_Output_of_Memory_Primitives {true} CONFIG.Register_PortB_Output_of_Memory_Primitives {true} CONFIG.Load_Init_File {true} CONFIG.Coe_File $x1_coe_path CONFIG.Use_RSTA_Pin {true} CONFIG.Use_RSTB_Pin {true} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Port_B_Enable_Rate {100} CONFIG.use_bram_block {Stand_Alone} CONFIG.EN_SAFETY_CKT {true}] [get_bd_cells blk_mem_gen_1]

# Memory for Y
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_2
endgroup
set_property -dict [list CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Enable_32bit_Address {true} CONFIG.Use_Byte_Write_Enable {true} CONFIG.Byte_Size {8} CONFIG.Write_Depth_A {2048} CONFIG.Enable_A {Always_Enabled} CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Register_PortA_Output_of_Memory_Primitives {true} CONFIG.Register_PortB_Output_of_Memory_Primitives {true} CONFIG.Load_Init_File {true} CONFIG.Coe_File $y_coe_path CONFIG.Use_RSTA_Pin {true} CONFIG.Use_RSTB_Pin {true} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Port_B_Enable_Rate {100} CONFIG.use_bram_block {Stand_Alone} CONFIG.EN_SAFETY_CKT {true}] [get_bd_cells blk_mem_gen_2]

startgroup
make_bd_pins_external  [get_bd_pins blk_mem_gen_0/addra]
connect_bd_net [get_bd_ports addra_0] [get_bd_pins blk_mem_gen_1/addra]
connect_bd_net [get_bd_ports addra_0] [get_bd_pins blk_mem_gen_2/addra]
endgroup

startgroup
make_bd_pins_external  [get_bd_pins blk_mem_gen_0/clka]
connect_bd_net [get_bd_ports clka_0] [get_bd_pins blk_mem_gen_1/clka]
connect_bd_net [get_bd_ports clka_0] [get_bd_pins blk_mem_gen_2/clka]
endgroup

startgroup
make_bd_pins_external  [get_bd_pins blk_mem_gen_0/dina]
connect_bd_net [get_bd_ports dina_0] [get_bd_pins blk_mem_gen_1/dina]
connect_bd_net [get_bd_ports dina_0] [get_bd_pins blk_mem_gen_2/dina]
endgroup

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0
set_property -dict [list CONFIG.CONST_VAL {0}] [get_bd_cells xlconstant_0]
endgroup
connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins blk_mem_gen_0/rsta]
connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins blk_mem_gen_1/rsta]
connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins blk_mem_gen_2/rsta]

startgroup
make_bd_pins_external  [get_bd_pins blk_mem_gen_0/wea]
connect_bd_net [get_bd_ports wea_0] [get_bd_pins blk_mem_gen_1/wea]
connect_bd_net [get_bd_ports wea_0] [get_bd_pins blk_mem_gen_2/wea]
endgroup

startgroup
make_bd_pins_external  [get_bd_pins blk_mem_gen_0/douta]
make_bd_pins_external  [get_bd_pins blk_mem_gen_1/douta]
make_bd_pins_external  [get_bd_pins blk_mem_gen_2/douta]
endgroup

set_property name address [get_bd_ports addra_0]
set_property name clk [get_bd_ports clka_0]
set_property name din [get_bd_ports dina_0]
set_property name we [get_bd_ports wea_0]
set_property name X0 [get_bd_ports douta_0]
set_property name X1 [get_bd_ports douta_1]
set_property name Y [get_bd_ports douta_2]
regenerate_bd_layout

#startgroup
#make_bd_pins_external  [get_bd_pins blk_mem_gen_2/dinb] [get_bd_pins blk_mem_gen_2/doutb] [get_bd_pins blk_mem_gen_1/dinb] [get_bd_pins blk_mem_gen_1/doutb] [get_bd_pins blk_mem_gen_0/dinb] [get_bd_pins blk_mem_gen_2/addrb] [get_bd_pins blk_mem_gen_2/clkb] [get_bd_pins blk_mem_gen_1/addrb] [get_bd_pins blk_mem_gen_0/doutb] [get_bd_pins blk_mem_gen_0/addrb] [get_bd_pins blk_mem_gen_1/clkb] [get_bd_pins blk_mem_gen_0/clkb] [get_bd_pins blk_mem_gen_1/web] [get_bd_pins blk_mem_gen_0/web] [get_bd_pins blk_mem_gen_2/enb] [get_bd_pins blk_mem_gen_2/rstb] [get_bd_pins blk_mem_gen_1/enb] [get_bd_pins blk_mem_gen_1/rstb] [get_bd_pins blk_mem_gen_0/enb] [get_bd_pins blk_mem_gen_0/rstb] [get_bd_pins blk_mem_gen_2/web]
#endgroup

startgroup
make_bd_intf_pins_external  [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTB]
make_bd_intf_pins_external  [get_bd_intf_pins blk_mem_gen_1/BRAM_PORTB]
make_bd_intf_pins_external  [get_bd_intf_pins blk_mem_gen_2/BRAM_PORTB]
endgroup

set_property name BRAM_PORT_X0 [get_bd_intf_ports BRAM_PORTB_0]
set_property name BRAM_PORT_X1 [get_bd_intf_ports BRAM_PORTB_1]
set_property name BRAM_PORT_Y [get_bd_intf_ports BRAM_PORTB_2]

regenerate_bd_layout
validate_bd_design
save_bd_design

# Make wrapper
set data_double_memory_board_path [join [list $project_full_path / $project_name .srcs/sources_1/bd/data_double/data_double.bd] ""]
make_wrapper -files [get_files $data_double_memory_board_path] -top

set data_double_memory_wrapper_path [join [list $project_full_path / $project_name .srcs/sources_1/bd/data_double/hdl/data_double_wrapper.v] ""]
add_files -norecurse $data_double_memory_wrapper_path
update_compile_order -fileset sources_1


# Create IP
source ip_neural_network_generation.tcl
