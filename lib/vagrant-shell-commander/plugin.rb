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
      
      %w[up reload].each do |event|
        action_hook("sh_hook_#{event}".to_sym, "machine_action_#{event}".to_sym) do |hook|
          hook.append(Action)
        end
      end
    end
  end
end
