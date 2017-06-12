require 'chef/knife/cloud/ovirt_service'

class Chef
  class Knife
    class Cloud
      module OvirtHelpers
        def create_service_instance
          OvirtService.new
        end

        def validate!
          #  super(:openstack_username, :openstack_password, :openstack_auth_url)
          super(:ovirt_username, :ovirt_password, :ovirt_url)
        end
      end
    end
  end
end
