require 'fog'
require 'fog/ovirt'

#puts Fog::Compute[:ovirt].servers

f = Fog::Compute.new :provider => 'ovirt',:ovirt_username => "admin", :ovirt_server => "c0.emsl.pnl.gov", :ovirt_password=>ENV['OV_PASSWORD']
puts f
