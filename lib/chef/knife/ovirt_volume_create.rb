# Copyright (C) 2017 Battelle Memorial Institute
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD-2 license.  See the LICENSE file for details.
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
            size_gb: locate_config_value('volume_size'),
            active: 'true',
          }
          [:storage_domain, :interface, :bootable, :alias].each do |opt|
            @create_options[opt] = locate_config_value("volume_#{opt}") if locate_config_value("volume_#{opt}")
          end
          # binding.pry
          @columns_with_info = [
            { label: 'Name', key: 'name' },
            { label: 'Status', key: 'status' },
          ]
        end

        def execute_command
          result = service.connection.add_volume(locate_config_value(:vm_id), @create_options)
          name = (result / 'disk/name').first.text
          id = (result / 'disk').first['id']

          print "\nWaiting For Volume(#{name}) to become available"
          Fog.wait_for(120) do
            print '.'
            volume_ready(locate_config_value(:vm_id), id)
          end
          print "\nActivating Volume"
          service.connection.activate_volume(locate_config_value(:vm_id), id: id)
        end
      end
    end
  end
end
