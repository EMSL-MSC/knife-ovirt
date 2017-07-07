# frozen_string_literal: true
require 'chef/knife/cloud/ovirt_service'

class Chef
  class Knife
    class Cloud
      module OvirtHelpers
        def create_service_instance
          OvirtService.new
        end

        def validate!
          super(:ovirt_username, :ovirt_password, :ovirt_url)
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

        def volume_ready(vm_id, vol_id)
          # find the volume and chaeck its status
          service.connection.list_vm_volumes(vm_id).select do |vol|
            vol[:id] == vol_id
          end[0][:status] == 'ok'
        end
      end
    end
  end
end
