# -*- encoding: utf-8 -*-
# frozen_string_literal: true
$LOAD_PATH.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'knife-ovirt'
  s.version     = '0.0.1'
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.authors     = ['Evan Felix']
  s.email       = ['evan.felix@pnnl.gov']
  s.homepage    = 'https://github.com/EMSL-MSC/knife-ovirt'
  s.summary     = "A Chef knife plugin for Ovirt VM's."
  s.description = "A Chef knife plugin for Ovirt VM's."
  s.license     = 'All Rights Reserved'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.2.2'

  s.add_dependency 'fog', '~> 1.23'
  s.add_dependency 'chef', '~> 12'
  s.add_dependency 'knife-cloud', '~> 1.2'
  s.add_dependency 'rbovirt', '~> 0.1.3'
end
