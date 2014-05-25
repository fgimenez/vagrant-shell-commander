module VagrantPlugins
  module ShellCommander
    # Plugin definition
    #
    class Plugin < Vagrant.plugin("2")
      name 'vagrant shell commander'
      
      command 'sh' do
        Command
      end
      
      config 'sh' do
        Config
      end
      
      action_hook :sh_hook do |hook|
        hook.after(Vagrant::Action::Builtin::Provision, Action)
      end
    end
  end
end
