# Copyright (C) 2017 Battelle Memorial Institute
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD-2 license.  See the LICENSE file for details.
# frozen_string_literal: true
require 'chef/knife/cloud/list_resource_command'
require 'chef/knife/ovirt_helpers'
require 'chef/knife/cloud/ovirt_service_options'

class Chef
  class Knife
    class Cloud
      class OvirtStorageList < ResourceListCommand
        include OvirtHelpers
        include OvirtServiceOptions

        banner 'knife ovirt storage list (options)'

        def query_resource
          @service.connection.storage_domains
        rescue Excon::Errors::BadRequest => e
          response = Chef::JSONCompat.from_json(e.response.body)
          ui.fatal("Unknown server error (#{response['badRequest']['code']}): #{response['badRequest']['message']}")
          raise e
        end

        def storage_domain_name(id)
          @storage_domains.select do |domain|
            puts domain
            domain.id == id
          end[0].name
        end

        def list(storages)
          storage_list = [
            ui.color('ID', :bold),
            ui.color('Name', :bold),
            ui.color('Used', :bold),
            ui.color('Avail', :bold),
            ui.color('%Used', :bold),
            ui.color('Kind', :bold),
            ui.color('Role', :bold),
          ]
          begin
            storages.each do |storage|
              storage_list << storage.id
              storage_list << storage.name
              storage_list << humanize((storage.used || 0))
              storage_list << humanize(storage.available)
              storage_list << format('%02.1f ', 100 * (storage.used || 0).to_i / (storage.available || 1).to_i)
              storage_list << storage.kind
              storage_list << storage.role
              # There is a description field too, but it doesent seem to be available through fog.
            end
          rescue Excon::Errors::BadRequest => e
            response = Chef::JSONCompat.from_json(e.response.body)
            ui.fatal("Unknown server error (#{response['badRequest']['code']}): #{response['badRequest']['message']}")
            raise e
          end
          puts ui.list(storage_list, :uneven_columns_across, 7)
        end
      end
    end
  end
end
