# frozen_string_literal: true
# require 'chef/knife/cloud/server/create_options'

class Chef
  class Knife
    class Cloud
      module OvirtVolumeCreateOptions
        def self.included(includer)
          includer.class_eval do
            # Ovirt Volume create params.
            option :vm_id,
                   long: '--vm-id <id>',
                   description: 'Virtual Machine to attach the volume to',
                   boolean: false,
                   default: nil

            option :volume_size,
                   long: '--volume-size <size>',
                   description: 'Size of volume in Gigabytes',
                   boolean: false,
                   default: '8'

            option :volume_domain_id,
                   long: '--volume-domain-id <id>',
                   description: 'template to build server from',
                   boolean: false,
                   default: nil

            option :volume_interface,
                   long: '--volume-interface <interface>',
                   description: 'interface type for volume',
                   boolean: false,
                   default: 'virtio'

            option :volume_bootable,
                   long: '--volume-bootable <boolean>',
                   description: 'should this volume be bootable',
                   boolean: false,
                   default: 'false'
            option :volume_alias,
                   long: '--volume-alias <alias>',
                   description: 'alias for the volume',
                   boolean: false,
                   default: nil
          end
        end
      end
    end
  end
end
