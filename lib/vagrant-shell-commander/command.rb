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
          #next
        end
      end

      0
    end

    private
  end
end
