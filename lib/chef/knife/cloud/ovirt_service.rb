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

        # originally lifted from knife-cloud/lib/chef/knife/cloud/fog/service.rb
        def create_server(options = {})
          begin
            add_custom_attributes(options[:server_def])
            server = connection.servers.create(options[:server_def])
            print "\nWaiting For Server"
            server.wait_for(Integer(options[:server_create_timeout])) { print '.'; !locked? }
            server.start_with_cloudinit(user_data: options[:cloud_init])
          rescue Excon::Error::BadRequest => e
            response = Chef::JSONCompat.from_json(e.response.body)
            message = if response['badRequest']['code'] == 400
                        "Bad request (400): #{response['badRequest']['message']}"
                      else
                        "Unknown server error (#{response['badRequest']['code']}): #{response['badRequest']['message']}"
                      end
            ui.fatal(message)
            raise CloudExceptions::ServerCreateError, message
          rescue Fog::Errors::Error => e
            raise CloudExceptions::ServerCreateError, e.message
          end

          print "\n#{ui.color("Waiting for server [wait time = #{options[:server_create_timeout]}]", :magenta)}"

          # wait for it to be ready to do stuff
          server.wait_for(Integer(options[:server_create_timeout])) { print '.'; ready? }

          puts("\n")
          server
        end
      end
    end
  end
end
