module VagrantShellCommander
  # Action for shell command hooking
  class Action
    # Constructor
    #
    # @param app [Action] Next middleware to call
    # @param env [Hash] Action environment
    # @return nil
    #
    def initialize(app, env)
      @app = app
      @machine = env[:machine]
    end

    # Call method of this middleware
    #
    # @param env [Hash] Action environment
    # @return nil
    #
    def call(env)
      @app.call(env)
      @machine.action(:ssh_run, 
                      ssh_run_command: env[:global_config].sh.after_share_folders)
    end
  end
end
