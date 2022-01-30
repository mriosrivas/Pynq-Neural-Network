# Define IP path
set ip_root_path "/home/manuel/Desktop/ICIL/New_Neural_Network/ip/"
# Define IP folder
set folder "neural_network_ip"

append ip_full_path $ip_root_path
append ip_full_path $folder

ipx::package_project -root_dir $ip_full_path -vendor user.org -library user -taxonomy /UserIP -import_files -set_current false

set ip_xml_path [join [list $ip_full_path /component.xml] ""]
ipx::unload_core $ip_xml_path
ipx::edit_ip_in_project -upgrade true -name $folder -directory $ip_full_path $ip_xml_path
update_compile_order -fileset sources_1

ipx::add_bus_parameter ASSOCIATED_BUSIF [ipx::get_bus_interfaces BRAM_PORT_X0_clk -of_objects [ipx::current_core]]
ipx::add_bus_parameter ASSOCIATED_BUSIF [ipx::get_bus_interfaces BRAM_PORT_X1_clk -of_objects [ipx::current_core]]
ipx::add_bus_parameter ASSOCIATED_BUSIF [ipx::get_bus_interfaces BRAM_PORT_Y_clk -of_objects [ipx::current_core]]
ipx::add_bus_parameter ASSOCIATED_BUSIF [ipx::get_bus_interfaces clk -of_objects [ipx::current_core]]


set_property core_revision 2 [ipx::current_core]
ipx::update_source_project_archive -component [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::save_core [ipx::current_core]

close_project

