# Copyright (C) 2017 Battelle Memorial Institute
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD-2 license.  See the LICENSE file for details.
# frozen_string_literal: true
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
                   default: nil

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
