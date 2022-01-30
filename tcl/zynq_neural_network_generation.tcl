# Define project name
set project_name "zynq_neural_network"

# Define project path
set project_path "/home/manuel/Desktop/ICIL/New_Neural_Network/projects/"

# Set project path and name
append project_full_path $project_path
append project_full_path $project_name

# Define repo path
set repo_path "/home/manuel/Desktop/ICIL/New_Neural_Network/ip"

create_project $project_name $project_full_path -part xc7z020clg400-1

set_property board_part www.digilentinc.com:pynq-z1:part0:1.0 [current_project]

set_property  ip_repo_paths  $repo_path [current_project]
update_ip_catalog

create_bd_design "design_neural_network"
update_compile_order -fileset sources_1

# Add Zynq Processing System
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
endgroup

apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]

# Add AXI BRAM Controller
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_X0
set_property -dict [list CONFIG.PROTOCOL {AXI4LITE} CONFIG.SINGLE_PORT_BRAM {1} CONFIG.ECC_TYPE {0}] [get_bd_cells axi_bram_X0]

create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_X1
set_property -dict [list CONFIG.PROTOCOL {AXI4LITE} CONFIG.SINGLE_PORT_BRAM {1} CONFIG.ECC_TYPE {0}] [get_bd_cells axi_bram_X1]

create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_Y
set_property -dict [list CONFIG.PROTOCOL {AXI4LITE} CONFIG.SINGLE_PORT_BRAM {1} CONFIG.ECC_TYPE {0}] [get_bd_cells axi_bram_Y]

startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/processing_system7_0/M_AXI_GP0} Slave {/axi_bram_X0/S_AXI} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins axi_bram_X0/S_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/processing_system7_0/M_AXI_GP0} Slave {/axi_bram_X1/S_AXI} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins axi_bram_X1/S_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/processing_system7_0/M_AXI_GP0} Slave {/axi_bram_Y/S_AXI} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins axi_bram_Y/S_AXI]
endgroup


# Add Neural Network
startgroup
create_bd_cell -type ip -vlnv user.org:user:neural_net_double_data_top:1.0 neural_net_double_da_0
endgroup

connect_bd_net [get_bd_pins axi_bram_X0/bram_addr_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_X0_addr]
connect_bd_net [get_bd_pins axi_bram_X0/bram_clk_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_X0_clk]
connect_bd_net [get_bd_pins axi_bram_X0/bram_wrdata_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_X0_din]
connect_bd_net [get_bd_pins axi_bram_X0/bram_en_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_X0_en]
connect_bd_net [get_bd_pins axi_bram_X0/bram_rst_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_X0_rst]
connect_bd_net [get_bd_pins axi_bram_X0/bram_we_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_X0_we]
connect_bd_net [get_bd_pins neural_net_double_da_0/BRAM_PORT_X0_dout] [get_bd_pins axi_bram_X0/bram_rddata_a]


connect_bd_net [get_bd_pins axi_bram_X1/bram_addr_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_X1_addr]
connect_bd_net [get_bd_pins axi_bram_X1/bram_clk_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_X1_clk]
connect_bd_net [get_bd_pins axi_bram_X1/bram_wrdata_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_X1_din]
connect_bd_net [get_bd_pins axi_bram_X1/bram_en_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_X1_en]
connect_bd_net [get_bd_pins axi_bram_X1/bram_rst_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_X1_rst]
connect_bd_net [get_bd_pins axi_bram_X1/bram_we_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_X1_we]
connect_bd_net [get_bd_pins axi_bram_X1/bram_rddata_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_X1_dout]


connect_bd_net [get_bd_pins axi_bram_Y/bram_addr_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_Y_addr]
connect_bd_net [get_bd_pins axi_bram_Y/bram_clk_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_Y_clk]
connect_bd_net [get_bd_pins axi_bram_Y/bram_wrdata_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_Y_din]
connect_bd_net [get_bd_pins axi_bram_Y/bram_en_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_Y_en]
connect_bd_net [get_bd_pins axi_bram_Y/bram_rst_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_Y_rst]
connect_bd_net [get_bd_pins axi_bram_Y/bram_we_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_Y_we]
connect_bd_net [get_bd_pins axi_bram_Y/bram_rddata_a] [get_bd_pins neural_net_double_da_0/BRAM_PORT_Y_dout]

apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/processing_system7_0/FCLK_CLK0 (100 MHz)" }  [get_bd_pins neural_net_double_da_0/clk]

# Add AXI Input
startgroup
create_bd_cell -type ip -vlnv user.org:user:AXI_neural_input_interface_v1_0:1.0 AXI_neural_input_int_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/processing_system7_0/FCLK_CLK0 (100 MHz)} Clk_slave {Auto} Clk_xbar {/processing_system7_0/FCLK_CLK0 (100 MHz)} Master {/processing_system7_0/M_AXI_GP0} Slave {/AXI_neural_input_int_0/axi_input} intc_ip {/axi_mem_intercon} master_apm {0}}  [get_bd_intf_pins AXI_neural_input_int_0/axi_input]

# From AXI Input -> Neural Network
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W1_00] [get_bd_pins neural_net_double_da_0/W1_00]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W1_01] [get_bd_pins neural_net_double_da_0/W1_01]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W1_10] [get_bd_pins neural_net_double_da_0/W1_10]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W1_11] [get_bd_pins neural_net_double_da_0/W1_11]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W1_20] [get_bd_pins neural_net_double_da_0/W1_20]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W1_21] [get_bd_pins neural_net_double_da_0/W1_21]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W1_30] [get_bd_pins neural_net_double_da_0/W1_30]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W1_31] [get_bd_pins neural_net_double_da_0/W1_31]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W1_40] [get_bd_pins neural_net_double_da_0/W1_40]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W1_41] [get_bd_pins neural_net_double_da_0/W1_41]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_00] [get_bd_pins neural_net_double_da_0/W2_00]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_01] [get_bd_pins neural_net_double_da_0/W2_01]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_02] [get_bd_pins neural_net_double_da_0/W2_02]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_03] [get_bd_pins neural_net_double_da_0/W2_03]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_04] [get_bd_pins neural_net_double_da_0/W2_04]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_10] [get_bd_pins neural_net_double_da_0/W2_10]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_11] [get_bd_pins neural_net_double_da_0/W2_11]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_12] [get_bd_pins neural_net_double_da_0/W2_12]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_13] [get_bd_pins neural_net_double_da_0/W2_13]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_14] [get_bd_pins neural_net_double_da_0/W2_14]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_20] [get_bd_pins neural_net_double_da_0/W2_20]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_21] [get_bd_pins neural_net_double_da_0/W2_21]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_22] [get_bd_pins neural_net_double_da_0/W2_22]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_23] [get_bd_pins neural_net_double_da_0/W2_23]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_24] [get_bd_pins neural_net_double_da_0/W2_24]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_30] [get_bd_pins neural_net_double_da_0/W2_30]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_31] [get_bd_pins neural_net_double_da_0/W2_31]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_32] [get_bd_pins neural_net_double_da_0/W2_32]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_33] [get_bd_pins neural_net_double_da_0/W2_33]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_34] [get_bd_pins neural_net_double_da_0/W2_34]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_40] [get_bd_pins neural_net_double_da_0/W2_40]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_41] [get_bd_pins neural_net_double_da_0/W2_41]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_42] [get_bd_pins neural_net_double_da_0/W2_42]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_43] [get_bd_pins neural_net_double_da_0/W2_43]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W2_44] [get_bd_pins neural_net_double_da_0/W2_44]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W3_00] [get_bd_pins neural_net_double_da_0/W3_00]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W3_01] [get_bd_pins neural_net_double_da_0/W3_01]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W3_02] [get_bd_pins neural_net_double_da_0/W3_02]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W3_03] [get_bd_pins neural_net_double_da_0/W3_03]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/W3_04] [get_bd_pins neural_net_double_da_0/W3_04]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/b1_00] [get_bd_pins neural_net_double_da_0/b1_00]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/b1_10] [get_bd_pins neural_net_double_da_0/b1_10]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/b1_20] [get_bd_pins neural_net_double_da_0/b1_20]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/b1_30] [get_bd_pins neural_net_double_da_0/b1_30]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/b1_40] [get_bd_pins neural_net_double_da_0/b1_40]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/b2_00] [get_bd_pins neural_net_double_da_0/b2_00]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/b2_10] [get_bd_pins neural_net_double_da_0/b2_10]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/b2_20] [get_bd_pins neural_net_double_da_0/b2_20]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/b2_30] [get_bd_pins neural_net_double_da_0/b2_30]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/b2_40] [get_bd_pins neural_net_double_da_0/b2_40]
connect_bd_net [get_bd_pins AXI_neural_input_int_0/b3_00] [get_bd_pins neural_net_double_da_0/b3_00]

# Add AXI Output
startgroup
create_bd_cell -type ip -vlnv user.org:user:AXI_neural_output_interface_v1_0:1.0 AXI_neural_output_in_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/processing_system7_0/FCLK_CLK0 (100 MHz)} Clk_slave {Auto} Clk_xbar {/processing_system7_0/FCLK_CLK0 (100 MHz)} Master {/processing_system7_0/M_AXI_GP0} Slave {/AXI_neural_output_in_0/s00_axi} intc_ip {/axi_mem_intercon} master_apm {0}}  [get_bd_intf_pins AXI_neural_output_in_0/s00_axi]

# Fron Neural Network -> AXI Output
connect_bd_net [get_bd_pins neural_net_double_da_0/W1_00_out] [get_bd_pins AXI_neural_output_in_0/W1_00]
connect_bd_net [get_bd_pins neural_net_double_da_0/W1_01_out] [get_bd_pins AXI_neural_output_in_0/W1_01]
connect_bd_net [get_bd_pins neural_net_double_da_0/W1_10_out] [get_bd_pins AXI_neural_output_in_0/W1_10]
connect_bd_net [get_bd_pins neural_net_double_da_0/W1_11_out] [get_bd_pins AXI_neural_output_in_0/W1_11]
connect_bd_net [get_bd_pins neural_net_double_da_0/W1_20_out] [get_bd_pins AXI_neural_output_in_0/W1_20]
connect_bd_net [get_bd_pins neural_net_double_da_0/W1_21_out] [get_bd_pins AXI_neural_output_in_0/W1_21]
connect_bd_net [get_bd_pins neural_net_double_da_0/W1_30_out] [get_bd_pins AXI_neural_output_in_0/W1_30]
connect_bd_net [get_bd_pins neural_net_double_da_0/W1_31_out] [get_bd_pins AXI_neural_output_in_0/W1_31]
connect_bd_net [get_bd_pins neural_net_double_da_0/W1_40_out] [get_bd_pins AXI_neural_output_in_0/W1_40]
connect_bd_net [get_bd_pins neural_net_double_da_0/W1_41_out] [get_bd_pins AXI_neural_output_in_0/W1_41]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_00_out] [get_bd_pins AXI_neural_output_in_0/W2_00]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_01_out] [get_bd_pins AXI_neural_output_in_0/W2_01]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_02_out] [get_bd_pins AXI_neural_output_in_0/W2_02]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_03_out] [get_bd_pins AXI_neural_output_in_0/W2_03]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_04_out] [get_bd_pins AXI_neural_output_in_0/W2_04]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_10_out] [get_bd_pins AXI_neural_output_in_0/W2_10]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_11_out] [get_bd_pins AXI_neural_output_in_0/W2_11]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_12_out] [get_bd_pins AXI_neural_output_in_0/W2_12]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_13_out] [get_bd_pins AXI_neural_output_in_0/W2_13]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_14_out] [get_bd_pins AXI_neural_output_in_0/W2_14]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_20_out] [get_bd_pins AXI_neural_output_in_0/W2_20]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_21_out] [get_bd_pins AXI_neural_output_in_0/W2_21]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_22_out] [get_bd_pins AXI_neural_output_in_0/W2_22]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_23_out] [get_bd_pins AXI_neural_output_in_0/W2_23]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_24_out] [get_bd_pins AXI_neural_output_in_0/W2_24]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_30_out] [get_bd_pins AXI_neural_output_in_0/W2_30]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_31_out] [get_bd_pins AXI_neural_output_in_0/W2_31]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_32_out] [get_bd_pins AXI_neural_output_in_0/W2_32]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_33_out] [get_bd_pins AXI_neural_output_in_0/W2_33]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_34_out] [get_bd_pins AXI_neural_output_in_0/W2_34]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_40_out] [get_bd_pins AXI_neural_output_in_0/W2_40]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_41_out] [get_bd_pins AXI_neural_output_in_0/W2_41]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_42_out] [get_bd_pins AXI_neural_output_in_0/W2_42]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_43_out] [get_bd_pins AXI_neural_output_in_0/W2_43]
connect_bd_net [get_bd_pins neural_net_double_da_0/W2_44_out] [get_bd_pins AXI_neural_output_in_0/W2_44]
connect_bd_net [get_bd_pins neural_net_double_da_0/W3_00_out] [get_bd_pins AXI_neural_output_in_0/W3_00]
connect_bd_net [get_bd_pins neural_net_double_da_0/W3_01_out] [get_bd_pins AXI_neural_output_in_0/W3_01]
connect_bd_net [get_bd_pins neural_net_double_da_0/W3_02_out] [get_bd_pins AXI_neural_output_in_0/W3_02]
connect_bd_net [get_bd_pins neural_net_double_da_0/W3_03_out] [get_bd_pins AXI_neural_output_in_0/W3_03]
connect_bd_net [get_bd_pins neural_net_double_da_0/W3_04_out] [get_bd_pins AXI_neural_output_in_0/W3_04]
connect_bd_net [get_bd_pins neural_net_double_da_0/b1_00_out] [get_bd_pins AXI_neural_output_in_0/b1_00]
connect_bd_net [get_bd_pins neural_net_double_da_0/b1_10_out] [get_bd_pins AXI_neural_output_in_0/b1_10]
connect_bd_net [get_bd_pins neural_net_double_da_0/b1_20_out] [get_bd_pins AXI_neural_output_in_0/b1_20]
connect_bd_net [get_bd_pins neural_net_double_da_0/b1_30_out] [get_bd_pins AXI_neural_output_in_0/b1_30]
connect_bd_net [get_bd_pins neural_net_double_da_0/b1_40_out] [get_bd_pins AXI_neural_output_in_0/b1_40]
connect_bd_net [get_bd_pins neural_net_double_da_0/b2_00_out] [get_bd_pins AXI_neural_output_in_0/b2_00]
connect_bd_net [get_bd_pins neural_net_double_da_0/b2_10_out] [get_bd_pins AXI_neural_output_in_0/b2_10]
connect_bd_net [get_bd_pins neural_net_double_da_0/b2_20_out] [get_bd_pins AXI_neural_output_in_0/b2_20]
connect_bd_net [get_bd_pins neural_net_double_da_0/b2_30_out] [get_bd_pins AXI_neural_output_in_0/b2_30]
connect_bd_net [get_bd_pins neural_net_double_da_0/b2_40_out] [get_bd_pins AXI_neural_output_in_0/b2_40]
connect_bd_net [get_bd_pins neural_net_double_da_0/b3_00_out] [get_bd_pins AXI_neural_output_in_0/b3_00]

# Add AXI Controller
startgroup
create_bd_cell -type ip -vlnv user.org:user:AXI_controller_v1_0:1.0 AXI_controller_v1_0_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/processing_system7_0/FCLK_CLK0 (100 MHz)} Clk_slave {Auto} Clk_xbar {/processing_system7_0/FCLK_CLK0 (100 MHz)} Master {/processing_system7_0/M_AXI_GP0} Slave {/AXI_controller_v1_0_0/s00_axi} intc_ip {/axi_mem_intercon} master_apm {0}}  [get_bd_intf_pins AXI_controller_v1_0_0/s00_axi]

connect_bd_net [get_bd_pins neural_net_double_da_0/timer_lo] [get_bd_pins AXI_controller_v1_0_0/timer_lo]
connect_bd_net [get_bd_pins neural_net_double_da_0/timer_hi] [get_bd_pins AXI_controller_v1_0_0/timer_hi]

connect_bd_net [get_bd_pins AXI_controller_v1_0_0/enable_network] [get_bd_pins neural_net_double_da_0/enable]
connect_bd_net [get_bd_pins AXI_controller_v1_0_0/EPOCH] [get_bd_pins neural_net_double_da_0/EPOCH]

startgroup
set_property -dict [list CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {10}] [get_bd_cells processing_system7_0]
endgroup

regenerate_bd_layout
validate_bd_design

# Create Wrapper
set zynq_neural_network_board_path [join [list $project_full_path / $project_name .srcs/sources_1/bd/design_neural_network/design_neural_network.bd] ""]
make_wrapper -files [get_files $zynq_neural_network_board_path] -top

set zynq_neural_network_wrapper_path [join [list $project_full_path / $project_name .srcs/sources_1/bd/design_neural_network/hdl/design_neural_network_wrapper.v] ""]
add_files -norecurse $zynq_neural_network_wrapper_path
                                                    
set_property synth_checkpoint_mode None [get_files  $zynq_neural_network_board_path]
generate_target all [get_files  $zynq_neural_network_board_path]
export_ip_user_files -of_objects [get_files $zynq_neural_network_board_path] -no_script -sync -force -quiet
#export_simulation -of_objects [get_files $zynq_neural_network_board_path] -directory /home/manuel/Desktop/ICIL/New_Neural_Network/projects/zynq_neural_network/zynq_neural_network.ip_user_files/sim_scripts -ip_user_files_dir /home/manuel/Desktop/ICIL/New_Neural_Network/projects/zynq_neural_network/zynq_neural_network.ip_user_files -ipstatic_source_dir /home/manuel/Desktop/ICIL/New_Neural_Network/projects/zynq_neural_network/zynq_neural_network.ip_user_files/ipstatic -lib_map_path [list {modelsim=/home/manuel/Desktop/ICIL/New_Neural_Network/projects/zynq_neural_network/zynq_neural_network.cache/compile_simlib/modelsim} {questa=/home/manuel/Desktop/ICIL/New_Neural_Network/projects/zynq_neural_network/zynq_neural_network.cache/compile_simlib/questa} {ies=/home/manuel/Desktop/ICIL/New_Neural_Network/projects/zynq_neural_network/zynq_neural_network.cache/compile_simlib/ies} {xcelium=/home/manuel/Desktop/ICIL/New_Neural_Network/projects/zynq_neural_network/zynq_neural_network.cache/compile_simlib/xcelium} {vcs=/home/manuel/Desktop/ICIL/New_Neural_Network/projects/zynq_neural_network/zynq_neural_network.cache/compile_simlib/vcs} {riviera=/home/manuel/Desktop/ICIL/New_Neural_Network/projects/zynq_neural_network/zynq_neural_network.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet
launch_runs synth_1 -jobs 8
wait_on_run synth_1

launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
