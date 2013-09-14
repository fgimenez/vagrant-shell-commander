require "vagrant-shell-commander/version"
require "vagrant-shell-commander/option_manager"

module VagrantShellCommander
  # Plugin definition
  #
  class Plugin < Vagrant.plugin("2")
    name 'vagrant shell commander'

    command 'sh' do
      require_relative 'vagrant-shell-commander/command'
      Command
    end

    config 'sh' do
      require_relative 'vagrant-shell-commander/config'
      Config
    end
  end
end
