#!/bin/bash
<%!
    import common.project_utils as project
%>
SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )";
SCRIPT_DIR="$( readlink -f $SCRIPT_DIR )";
cd "$SCRIPT_DIR";

export PROJECT_INSTALL_DIR=$(cd ${project_install_prefix} && pwd);

if [ -z "$WINDIR" ]; then
    SIMULATOR_BIN_NAME="./simulator-cli";
else
    SIMULATOR_BIN_NAME="simulator-cli.exe";
fi

export LD_LIBRARY_PATH=$PROJECT_INSTALL_DIR/lib:$PROJECT_INSTALL_DIR/tools/shared:$LD_LIBRARY_PATH ;
<% is_first_addr = False %>
% for svr_index in project.get_service_index_range(int(project.get_global_option('server.tconnd_cluster', 'number', 0))):
  <% 
  client_url = project.get_tsf4g_tconnd_cluster_client_url(svr_index)[6:]
  ip_split = client_url.rfind(':')
  connect_ip = client_url[0:ip_split]
  connect_port = client_url[ip_split + 1:]
  %>
  % if is_first_addr:
# $SIMULATOR_BIN_NAME --host ${connect_ip} --port ${connect_port} --tgcpapi-zone-id ${project.get_global_option('global', 'zone_id', 0)} "$@";
  % else:
$SIMULATOR_BIN_NAME --host ${connect_ip} --port ${connect_port} --tgcpapi-zone-id ${project.get_global_option('global', 'zone_id', 0)} "$@";
  <% is_first_addr = True %>
  % endif
% endfor
% if not is_first_addr:
$SIMULATOR_BIN_NAME --tgcpapi-zone-id ${project.get_global_option('global', 'zone_id', 0)} "$@";
% endif