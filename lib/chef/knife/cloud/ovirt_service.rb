# frozen_string_literal: true
require 'chef/knife/cloud/fog/service'

class Chef
  class Knife
    class Cloud
      class OvirtService < FogService
        def initialize(options = {})
          Chef::Log.debug("ovirt_username #{Chef::Config[:knife][:ovirt_username]}")

          super(options.merge(auth_params: {
                                provider: 'ovirt',
                                ovirt_username: Chef::Config[:knife][:ovirt_username],
                                ovirt_password: Chef::Config[:knife][:ovirt_password],
                                ovirt_url: Chef::Config[:knife][:ovirt_url],
                              }))
        end

        def add_api_endpoint
          @auth_params.merge!(ovirt_url: Chef::Config[:knife][:api_endpoint]) unless Chef::Config[:knife][:api_endpoint].nil?
        end
      end
    end
  end
end
