# frozen_string_literal: true
require 'chef/knife/cloud/server/create_command'
require 'chef/knife/ovirt_helpers'
require 'chef/knife/cloud/ovirt_service'
require 'chef/knife/cloud/command'
require 'chef/knife/cloud/ovirt_service_options'
require 'chef/knife/cloud/ovirt_volume_create_options'
require 'chef/knife/cloud/exceptions'
require 'pry'

class Chef
  class Knife
    class Cloud
      class OvirtVolumeCreate < Command
        include OvirtHelpers
        include OvirtVolumeCreateOptions
        include OvirtServiceOptions

        banner 'knife ovirt volume create (options)'

        def before_exec_command
          super
          # setup the create options
          @create_options = {
            :size => locate_config_value("volume_size").to_i * 1024 * 1024 * 1024
          }
          [:storage_domain, :interface, :bootable].each do |opt|
            @create_options[opt] = locate_config_value("volume_#{opt}") if locate_config_value("volume_#{opt}")
          end
          # binding.pry
          @columns_with_info = [
            { label: 'Name', key: 'name' },
            { label: 'Status', key: 'status' },
          ]
        end

        def execute_command
          puts locate_config_value(:vm_id), @create_options

          service.connection.add_volume(locate_config_value(:vm_id), @create_options)
        end
      end
    end
  end
end
