# frozen_string_literal: true
require 'chef/knife/cloud/server/delete_options'
require 'chef/knife/cloud/server/delete_command'
require 'chef/knife/cloud/ovirt_service'
require 'chef/knife/cloud/ovirt_service_options'
require 'chef/knife/ovirt_helpers'

class Chef
  class Knife
    class Cloud
      class OvirtServerDelete < ServerDeleteCommand
        include ServerDeleteOptions
        include OvirtServiceOptions
        include OvirtHelpers

        banner 'knife ovirt server delete INSTANCEID [INSTANCEID] (options)'
      end
    end
  end
end
