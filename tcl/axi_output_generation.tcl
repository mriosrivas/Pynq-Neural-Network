# Define project name
set project_name "axi_output_neural_network"

# Define project path
set project_path "/home/manuel/Desktop/ICIL/New_Neural_Network/projects/axi_output_neural_network"

# Define file dependencies
# Source files
set src_files "/home/manuel/Desktop/ICIL/New_Neural_Network/design/axi/axi_output/hdl/src/"

create_project $project_name $project_path -part xc7z020clg400-1
set_property board_part www.digilentinc.com:pynq-z1:part0:1.0 [current_project]

update_ip_catalog

import_files -norecurse [join [list $src_files AXI_neural_output_interface_v1_0_S00_AXI.v] ""]
import_files -norecurse [join [list $src_files AXI_neural_output_interface_v1_0.v] ""]

update_compile_order -fileset sources_1
update_compile_order -fileset sources_1

current_project $project_name

source ip_axi_output_generation.tcl

