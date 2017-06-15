# frozen_string_literal: true
require 'chef/knife/cloud/server/list_command'
require 'chef/knife/ovirt_helpers'
require 'chef/knife/cloud/ovirt_service_options'
require 'chef/knife/cloud/server/list_options'

require 'fog'

class Chef
  class Knife
    class Cloud
      class OvirtServerList < ServerListCommand
        include OvirtHelpers
        include OvirtServiceOptions
        include ServerListOptions

        banner 'knife ovirt server list (options)'

        def before_exec_command
          @columns_with_info = [
            { label: 'VM ID', key: 'id' },
            { label: 'Name', key: 'name' },
            { label: 'Cores', key: 'cores' },
            { label: 'Memory', key: 'memory', value_callback: method(:humanize) },
            { label: 'Storage', key: 'storage', value_callback: method(:humanize) },
            { label: 'Status', key: 'status' },
          ]
          super
        end
      end
    end
  end
end
