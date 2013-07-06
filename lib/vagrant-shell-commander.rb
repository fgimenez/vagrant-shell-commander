require "vagrant-shell-commander/version"

module VagrantShellCommander
  # Plugin definition
  #
  class Plugin < Vagrant.plugin("2")
    name 'vagrant shell commander'

    command 'execute-shell-command' do
      require_relative 'vagrant-shell-commander/command'
      Command
    end
  end
end
