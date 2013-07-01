# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant/shell/commander/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-shell-commander"
  spec.version       = Vagrant::Shell::Commander::VERSION
  spec.authors       = ["Federico Gimenez Nieto"]
  spec.email         = ["federico.gimenez@gmail.com"]
  spec.description   = %q{Vagrant plugin for executing arbitrary shell commands on guest}
  spec.summary       = %q{Vagrant plugin for executing arbitrary shell commands on guest}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "reek"
  spec.add_development_dependency "cane"
  spec.add_development_dependency "yard"
end
