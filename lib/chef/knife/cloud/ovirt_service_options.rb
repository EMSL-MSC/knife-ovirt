require 'chef/knife/cloud/fog/options'
class Chef
  class Knife
    class Cloud
      module OvirtServiceOptions
        def self.included(includer)
          includer.class_eval do
            include FogOptions

            # TODO: - define your cloud specific auth options.
            # Example:
            # Myplugin Connection params.
            # option :azure_username,
            #  :short => "-A USERNAME",
            #  :long => "--myplugin-username KEY",
            #  :description => "Your Myplugin Username",
            #  :proc => Proc.new { |key| Chef::Config[:knife][:myplugin_username] = key }
          end
        end
      end
    end
  end
end
