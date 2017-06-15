# frozen_string_literal: true
require 'chef/knife/cloud/list_resource_command'
require 'chef/knife/ovirt_helpers'
require 'chef/knife/cloud/ovirt_service_options'

class Chef
  class Knife
    class Cloud
      class OvirtVolumeList < ResourceListCommand
        include OvirtHelpers
        include OvirtServiceOptions

        banner 'knife ovirt volume list (options)'

        def query_resource
          @service.connection.list_volumes
        rescue Excon::Errors::BadRequest => e
          response = Chef::JSONCompat.from_json(e.response.body)
          ui.fatal("Unknown server error (#{response['badRequest']['code']}): #{response['badRequest']['message']}")
          raise e
        end

        def list(volumes)
          volume_list = [
            ui.color('Name', :bold),
            ui.color('ID', :bold),
            ui.color('Size', :bold),
            ui.color('Status', :bold),
          ]
          begin
            volumes.each do |volume|
              volume_list << volume[:name]
              volume_list << volume[:id]
              volume_list << humanize(volume[:size])
              volume_list << volume[:status]
            end
          rescue Excon::Errors::BadRequest => e
            response = Chef::JSONCompat.from_json(e.response.body)
            ui.fatal("Unknown server error (#{response['badRequest']['code']}): #{response['badRequest']['message']}")
            raise e
          end
          puts ui.list(volume_list, :uneven_columns_across, 4)
        end
      end
    end
  end
end
