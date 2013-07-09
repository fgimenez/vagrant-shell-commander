module VagrantShellCommander
  # Main plugin command
  class Command < Vagrant.plugin("2", "command")
    def execute
      cli_options = OptionManager.new.execute
      argv = parse_options(cli_options[:parser])
      
      return unless argv
      
      with_target_vms(argv) do |machine|
        if machine.state.id != :running
          env.ui.info("Machine #{machine.name} is not running.")
          next
        end

        machine.communicate.execute(cli_options[:values][:cmd]) do |type, data|
          #env.ui.info(data)
        end
      end

      0
    end
  end
end
