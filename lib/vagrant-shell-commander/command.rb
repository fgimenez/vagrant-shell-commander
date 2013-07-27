module VagrantShellCommander
  # Main plugin command
  class Command < Vagrant.plugin("2", "command")
    attr_accessor :env

    # Main entry point of this command
    #
    def execute
      cli_options = OptionManager.new.execute
      argv = parse_options(cli_options[:parser])
      
      return unless argv
      
      unless [nil, ''].include? cli_options[:values][:cmd]
        with_target_vms(argv) do |machine|
          manage_machine(machine, cli_options) 
        end
      end
      0
    end

    private

    # Executes actions for a given machine
    #
    # @param [Vagrant::Machine] subject vm 
    # @param [Hash] Parser (:parser key) and parsed options (:values key)
    # @return nil
    #
    def manage_machine(machine, cli_options)
      if machine.state.id != :running
        env.ui.warn("Machine #{machine.name} is not running.")
        return
      end
      
      machine.communicate.
        execute(add_cwd_to_command(cli_options[:values][:cmd], 
                                   cli_options[:values][:dir])) do |type, data|
        env.ui.success("#{machine.name}::")
        env.ui.info(data)
      end
    end

    # Adds the change to a working directory to the given command
    #
    # @param cmd [String] Shell command
    # @param cwd [String] Optional working directory
    # @return [String] Command with directory change if cwd is present
    #
    def add_cwd_to_command(cmd, cwd=nil)
      return cmd unless cwd
      "cd #{cwd} && #{cmd}"
    end
  end
end
