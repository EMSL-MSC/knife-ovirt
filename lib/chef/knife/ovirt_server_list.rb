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

        def humanize(bytes)
          b = bytes.to_i
          suf = %w(B KiB MiB GiB TiB EiB)
          c = suf[0]
          6.times do |count|
            if b < 1024
              c = suf[count]
              break
            end
            b /= 1024.0
          end
          format('%.2f ', b) + c
        end
      end
    end
  end
end
