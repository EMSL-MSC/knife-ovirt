# frozen_string_literal: true
require 'chef/knife/cloud/server/delete_options'
require 'chef/knife/cloud/server/delete_command'
require 'chef/knife/cloud/ovirt_service'
require 'chef/knife/cloud/ovirt_service_options'
require 'chef/knife/ovirt_helpers'

class Chef
  class Knife
    class Cloud
      class OvirtServerDelete < ServerDeleteCommand
        include ServerDeleteOptions
        include OvirtServiceOptions
        include OvirtHelpers

        banner 'knife ovirt server delete VMID|VMNAME [VMID|VMNAME] (options)'
        def execute_command
          @name_args.each do |server_name|
            service.delete_server(map_name(server_name))
            delete_from_chef(server_name)
          end
        end

        # map vm names to ID's so they get deleted
        def map_name(server_name)
          servers = @service.list_servers
          snames = servers.map(&:name)
          names = []
          @name_args.each do |name|
            if snames.include? name
              servers.each do |server|
                names << server.id if server.name == name
              end
            else
              names << name
            end
          end
          if names.length != 1
            raise CloudExceptions::ServerDeleteError, "Too many ID's for #{server_name} => #{names}"
          end
          names[0]
        end
      end
    end
  end
end
