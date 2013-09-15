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
      
      if [nil, ''].include? cli_options[:values][:cmd]
        env.ui.info cli_options[:parser]
      else
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
                                   cli_options[:values][:dir],
                                   cli_options[:values][:user])) do |type, data|
        env.ui.success("#{machine.name}::")
        env.ui.info(data, prefix: false, new_line: false)
      end
    end

    # Adds the change to a working directory to the given command
    #
    # @param cmd [String] Shell command
    # @param cwd [String] Optional working directory
    # @param cwd [String] Optional executing user
    # @return [String] Command with directory change if cwd is present and optional executing user
    #
    def add_cwd_to_command(cmd, cwd=nil, user=nil)
      cmd = "cd #{cwd} && #{cmd}" if cwd
      cmd = "sudo su - #{user} -c \"#{cmd}\"" if user
      cmd
    end
  end
end
