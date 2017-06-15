# frozen_string_literal: true
require 'chef/knife/cloud/server/create_options'

class Chef
  class Knife
    class Cloud
      module OvirtServerCreateOptions
        def self.included(includer)
          includer.class_eval do
            include ServerCreateOptions

            # Ovirt Server create params.
            option :ovirt_volume,
                   long: '--ovirt-volumes <size>',
                   description: 'List of Volumes to use, size is in Gigabytes',
                   boolean: false,
                   default: '8'
          end
        end
      end
    end
  end
end
