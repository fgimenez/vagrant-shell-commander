require 'spec_helper'

describe VagrantPlugins::ShellCommander::Action do
  let(:app) {double(call: true)}
  let(:state) {double(id: :poweron)}
  let(:cmd) {'cmd'}
  let(:sh) {double(after_share_folders: cmd)}
  let(:config) {double(sh: sh)}
  let(:machine_env) {double(config: config, state: state, action: true)}
  let(:action_env) {{machine: machine_env}}
  let(:env) {double(:[] => machine_env)}
  let(:subject) {described_class.new(app, env)}

  describe "#call" do
    it "should call the next middleware" do
      expect(app).to receive(:call).with(action_env)

      subject.call(action_env)
    end

    describe "SSHRun call" do
      it "should call SSHRun action of the current machine with the after_boot option as command" do
        expect(machine_env).to receive(:action).with(:ssh_run, ssh_run_command: cmd, ssh_opts: {extra_args: []})

        subject.call(action_env)
      end
      
      it "should not call SSHRun action if after_share_folder option is nil" do
        machine_env = double(config: config, state: state)
        action_env = {machine: machine_env}
        
        expect(machine_env).not_to receive(:action)

        subject.call(action_env)
      end

      it "should not call SSHRun action if machine is not powered on" do
        state = double(id: :poweroff)
        machine_env = double(config: config, state: state, action: true)
        action_env = {machine: machine_env}
        
        expect(machine_env).not_to receive(:action)

        subject.call(action_env)
      end

    end
  end
end
