# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-shell-commander/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-shell-commander"
  spec.version       = VagrantShellCommander::VERSION
  spec.authors       = ["Federico Gimenez Nieto"]
  spec.email         = ["federico.gimenez@gmail.com"]
  spec.description   = %q{This Vagrant plugin allows you to execute a given shell command on all the machines of your multinode environment. You can aldo specify the working directory to execute the command}
  spec.summary       = %q{Vagrant plugin for executing arbitrary shell commands on guest(s)}
  spec.homepage      = "https://github.com/fgimenez/vagrant-shell-commander"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "reek"
  spec.add_development_dependency "cane"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "simplecov"
end
