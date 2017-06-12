require 'chef/knife/cloud/server/create_command'
# require 'chef/knife/myplugin_helpers'
# require 'chef/knife/cloud/myplugin_server_create_options'
# require 'chef/knife/cloud/myplugin_service'
# require 'chef/knife/cloud/myplugin_service_options'
require 'chef/knife/cloud/exceptions'

class Chef
  class Knife
    class Cloud
      class OvirtServerCreate < ServerCreateCommand
        # include MypluginHelpers
        # include MypluginServerCreateOptions
        # include MypluginServiceOptions

        banner 'knife overt server create (options)'
      end
    end
  end
end
