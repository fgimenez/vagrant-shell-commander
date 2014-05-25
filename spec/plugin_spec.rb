require 'spec_helper'

describe VagrantPlugins::ShellCommander::Plugin do
  it 'should have a name' do
    expect(described_class.name).not_to be_nil
  end

  it "should define a command of type Command" do
    default_command = described_class.components.commands[:sh]
    expect(default_command[1]).to eql(primary: true)
  end

  it "should define a config of type Config" do
    default_config = described_class.components.configs[:top].to_hash[:"sh"]
    expect(default_config).to be(VagrantPlugins::ShellCommander::Config)
  end

  context 'action hooks' do
    let(:hook) {double(append: true, prepend: true)}

    it 'should define an action hook for after share folders' do
      hook_proc = described_class.components.action_hooks[:__all_actions__][0]
      hook = double
      expect(hook).to receive(:after).with(Vagrant::Action::Builtin::Provision, VagrantPlugins::ShellCommander::Action)
      hook_proc.call(hook)
    end
  end
end
