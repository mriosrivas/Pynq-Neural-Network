# Define IP path
set ip_root_path "/home/manuel/Desktop/ICIL/New_Neural_Network/ip/axi_output_ip"


update_compile_order -fileset sources_1
ipx::package_project -root_dir $ip_root_path -vendor user.org -library user -taxonomy /UserIP -import_files -set_current false

set ip_xml_path [join [list $ip_root_path /component.xml] ""]
ipx::unload_core $ip_xml_path

ipx::edit_ip_in_project -upgrade true -name tmp_edit_project -directory $ip_root_path $ip_xml_path

update_compile_order -fileset sources_1

set_property core_revision 2 [ipx::current_core]

ipx::update_source_project_archive -component [ipx::current_core]

ipx::create_xgui_files [ipx::current_core]

ipx::update_checksums [ipx::current_core]

ipx::save_core [ipx::current_core]

ipx::move_temp_component_back -component [ipx::current_core]

close_project -delete

#set_property  ip_repo_paths  /home/manuel/Desktop/ICIL/New_Neural_Network/ip/axi_output_ip [current_project]
#update_ip_catalog
