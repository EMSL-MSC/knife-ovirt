# Knife OVirt

## Requirements
 * fog
 * rbovirt
 * chef
 * knife-cloud

## Installation

Once you have [ChefDK](https://downloads.chef.io/chefdk) installed you can run:

`chef gem install knife-ovirt`

## Configuration

You can set the authorization parameters for ovirt in your `knife.rb` file like this:

```ruby
knife[:ovirt_username]="Your OVirt Username"
knife[:ovirt_url]="Your OVirt API URL"
knife[:ovirt_password]="Your OVirt Password"
```
You can also specify these options on the command line as (`--ovirt-username`, `--ovirt-password`, `--ovirt-url`)

These parameters are required for all the commands below, and can be specified in a knife.rb config file or on the command line.

## Commands

The plugin provides

### `knife ovirt server list (options)`
List the Virtual Machines that are defined on the OVirt System.


### `knife ovirt server create (options)`
Create a new server in the OVirt cluster based off an existing template. One of `--ovirt-template-name` or `--ovirt-template` is required.

 * `--ovirt-template <id>` specify a template ID to clone the new VM from

 * `--ovirt-tmeplate-name <name>` specify the name of a template to clone the new VM from

 * `--ovirt-volumes <list of hashes>` specify the volumes to create or attach to the new vm. for example to create a new volume and attach an existing one:
 ```ruby
 knife[:ovirt_volumes] = [
   {
     size_gb: 2,
     domain_id: 'f7a25cf2-b2d4-43d3-8180-78f8f1c48b7d',
     interface: 'virtio_scsi',
     alias: 'testvol',
     bootable: 'false'
   },
   {
     id: 'd9e995f0-1c2d-4e9f-9cdf-4eb39b619d57',
     interface: 'virtio_scsi',
   }
 ]```

 * `--ovirt_cloud_init <cloud_init yaml>` specify a yaml string containing the cloud_init data needed to pass to the system.  One method is to do it this way in a the knife.rb config:

```ruby
knife[:ovirt_cloud_init] = {
  ssh_authorized_keys: [File.read("#{ENV['HOME']}/.ssh/ovirt.pub")],
  user: knife[:ssh_user],
  ip: knife[:bootstrap_ip_address],
  netmask: '255.255.255.0',
  gateway: '192.168.1.1',
  nicname: 'eth0',
  dns: '192.168.1.1',
  domain: 'example.com',
  hostname: knife[:chef_node_name],
}.to_yaml
```

### `knife ovirt server delete VMID|VMNAME [VMID|VMNAME] (options)`

Delete a Virtual Machine or list of Virtual Machines

### `knife ovirt volume list (options)`

List the volumes that are currently defined on the OVirt System

### `knife ovirt volume create (options)`

Create a new volume on the OVirt System
 * `--vm-id <id>` Virtual Machine to attach the volume to

 * `--volume-alias <alias>` alias for the volume

 * `--volume-bootable <boolean>` should this volume be bootable

 * `--volume-domain-id <id>` template to build server from

 * `--volume-interface <interface>` interface type for volume

 * `--volume-size <size>` Size of volume in Gigabytes

## License

Author:: Evan Felix ([evan.felix@pnnl.gov](mailto:evan.felix@pnnl.gov))

Copyright:: Copyright 2017 Battelle Memorial Institute

License:: BSD-2

## Disclaimer

This material was prepared as an account of work sponsored by an agency of the United States Government.  Neither the United States Government nor the United States Department of Energy, nor Battelle, nor any of their employees, nor any jurisdiction or organization that has cooperated in the development of these materials, makes any warranty, express or implied, or assumes any legal liability or responsibility for the accuracy, completeness, or usefulness or any information, apparatus, product, software, or process disclosed, or represents that its use would not infringe privately owned rights.

Reference herein to any specific commercial product, process, or service by trade name, trademark, manufacturer, or otherwise does not necessarily constitute or imply its endorsement, recommendation, or favoring by the United States Government or any agency thereof, or Battelle Memorial Institute. The views and opinions of authors expressed herein do not necessarily state or reflect those of the United States Government or any agency thereof.

PACIFIC NORTHWEST NATIONAL LABORATORY
           operated by
            BATTELLE
            for the
UNITED STATES DEPARTMENT OF ENERGY
 under Contract DE-AC05-76RL01830
