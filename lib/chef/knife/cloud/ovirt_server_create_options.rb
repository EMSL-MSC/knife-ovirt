# Copyright (C) 2017 Battelle Memorial Institute
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD-2 license.  See the LICENSE file for details.
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
            option :ovirt_volumes,
                   long: '--ovirt-volumes <list of hashes>',
                   description: 'List of Volumes to use,',
                   boolean: false,
                   default: nil

            option :ovirt_template,
                   long: '--ovirt-template <id>',
                   description: 'template to build server from',
                   boolean: false,
                   default: nil

            option :ovirt_template_name,
                   long: '--ovirt-template-name <name>',
                   description: 'template to build server from',
                   boolean: false,
                   default: nil

            option :ovirt_cloud_init,
                   long: '--ovirt-cloud-init CLOUD_INIT_DATA',
                   description: 'Your Ovirt cloud_init data',
                   proc: proc { |cloud_init| Chef::Config[:knife][:ovirt_cloud_init] = cloud_init }
          end
        end
      end
    end
  end
end
