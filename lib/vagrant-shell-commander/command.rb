module VagrantShellCommander
  # Main plugin command
  class Command < Vagrant.plugin("2", "command")
    def execute
      cli_options = OptionManager.new.execute
      argv = parse_options(cli_options[:parser])
      
      return unless argv
      
      with_target_vms(argv) do |machine|
        manage_machine(machine, cli_options) 
      end

      0
    end

    private
    def manage_machine(machine, cli_options)
      if machine.state.id != :running
        env.ui.info("Machine #{machine.name} is not running.")
        return
      end
      
      machine.communicate.execute(cli_options[:values][:cmd]) do |type, data|
        env.ui.info("#{machine.name}:: #{data}")
      end
    end
  end
end
