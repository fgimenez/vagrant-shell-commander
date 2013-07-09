module VagrantShellCommander
  # Main plugin command
  class Command < Vagrant.plugin("2", "command")
    def execute
      cli_options = OptionManager.new.execute
      argv = parse_options(cli_options[:parser])
      
      return unless argv
      
      0
    end

    private
  end
end
