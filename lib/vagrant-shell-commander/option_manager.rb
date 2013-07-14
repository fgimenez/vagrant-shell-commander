module VagrantShellCommander
  # Option parser
  #
  class OptionManager
    # Main parsing method
    # @return [Hash] The keys are :parser for the object returned by
    #   OptionParser and :values for the actual option values
    #
    def execute
      options = {}
      block = lambda do |parser|
        parser.banner = "Usage: vagrant sh -c 'COMMAND' -d [DIR] [MACHINE]"

        parser.separator ''

        parser.on('-d [DIR]', '--directory [DIR]', 
                  'Directory to execute the command') do |dir|
          options[:dir] = dir
        end

        parser.on("-c 'COMMAND'", "--command 'COMMAND'", 
                  'Command to execute') do |cmd|
          options[:cmd] = cmd
        end
      end

      {parser: OptionParser.new(&block), values: options}
    end
  end
end

