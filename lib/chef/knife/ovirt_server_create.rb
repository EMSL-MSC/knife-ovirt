# Copyright (C) 2017 Battelle Memorial Institute
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD-2 license.  See the LICENSE file for details.
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
              os: { boot: ['hd'] },
            },
            cloud_init: config[:ovirt_cloud_init],
            server_create_timeout: locate_config_value(:server_create_timeout),
          }
          @create_options[:server_def][:template] = config[:ovirt_template] if config[:ovirt_template]
          @create_options[:server_def][:template_name] = config[:ovirt_template_name] if config[:ovirt_template_name]

          @create_options[:server_volumes] = config[:ovirt_volumes] if config[:ovirt_volumes]

          @columns_with_info = [
            { label: 'VM ID', key: 'id' },
            { label: 'Name', key: 'name' },
            { label: 'Cores', key: 'cores' },
            { label: 'Memory', key: 'memory', value_callback: method(:humanize) },
            { label: 'Storage', key: 'storage', value_callback: method(:humanize) },
            { label: 'Status', key: 'status' },
          ]
        end
      end
    end
  end
end
