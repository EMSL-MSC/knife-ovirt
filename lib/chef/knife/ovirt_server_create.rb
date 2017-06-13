# frozen_string_literal: true
require 'chef/knife/cloud/server/create_command'
# require 'chef/knife/myplugin_helpers'
# require 'chef/knife/cloud/myplugin_server_create_options'
# require 'chef/knife/cloud/myplugin_service'
# require 'chef/knife/cloud/myplugin_service_options'
require 'chef/knife/ovirt_helpers'
require 'chef/knife/cloud/ovirt_server_create_options'
require 'chef/knife/cloud/ovirt_service'
require 'chef/knife/cloud/ovirt_service_options'
require 'chef/knife/cloud/exceptions'

class Chef
  class Knife
    class Cloud
      class OvirtServerCreate < ServerCreateCommand
        # include MypluginHelpers
        # include MypluginServerCreateOptions
        # include MypluginServiceOptions
        include OvirtHelpers
        include OvirtServerCreateOptions
        include OvirtServiceOptions

        banner 'knife ovirt server create (options)'
      end
    end
  end
end
