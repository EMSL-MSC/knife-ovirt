# Copyright (C) 2017 Battelle Memorial Institute
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD-2 license.  See the LICENSE file for details.
# frozen_string_literal: true
require 'chef/knife/cloud/fog/options'
class Chef
  class Knife
    class Cloud
      module OvirtServiceOptions
        def self.included(includer)
          includer.class_eval do
            include FogOptions
            # Ovirt Connection params.
            option :ovirt_username,
                   short: '-A USERNAME',
                   long: '--ovirt-username KEY',
                   description: 'Your Ovirt Username',
                   proc: proc { |key| Chef::Config[:knife][:ovirt_username] = key }

            option :ovirt_password,
                   short: '-K SECRET',
                   long: '--ovirt-password SECRET',
                   description: 'Your Ovirt Password',
                   proc: proc { |key| Chef::Config[:knife][:ovirt_password] = key }

            option :ovirt_url,
                   long: '--ovirt-url URL',
                   description: 'Your Ovirt URL',
                   proc: proc { |url| Chef::Config[:knife][:ovirt_url] = url }
          end
        end
      end
    end
  end
end
