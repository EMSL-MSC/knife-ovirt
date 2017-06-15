# frozen_string_literal: true
require 'chef/knife/cloud/server/create_command'
require 'chef/knife/ovirt_helpers'
require 'chef/knife/cloud/ovirt_server_create_options'
require 'chef/knife/cloud/ovirt_service'
require 'chef/knife/cloud/ovirt_service_options'
require 'chef/knife/cloud/exceptions'

class Chef
  class Knife
    class Cloud
      class OvirtServerCreate < ServerCreateCommand
        include OvirtHelpers
        include OvirtServerCreateOptions
        include OvirtServiceOptions

        banner 'knife ovirt server create (options)'

        def before_exec_command
          super
          # setup the create options
          @create_options = {
            server_def: {
              name: config[:chef_node_name],
            },
            server_create_timeout: locate_config_value(:server_create_timeout),
          }
        end
      end
    end
  end
end
