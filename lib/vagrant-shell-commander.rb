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

    action_hook :sh_hook do |hook|
      require_relative 'vagrant-shell-commander/action'
      hook.after(VagrantPlugins::ProviderVirtualBox::Action::ShareFolders, 
                 VagrantShellCommander::Action)
    end
  end
end
