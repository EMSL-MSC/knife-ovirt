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

        # map vm names to ID's so they get deleted too
        def before_exec_command
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
          @name_args = names
        end
      end
    end
  end
end
