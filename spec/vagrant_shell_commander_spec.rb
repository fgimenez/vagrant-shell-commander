require 'spec_helper'

describe VagrantShellCommander::Plugin do
  it 'should have a name' do
    expect(described_class.name).not_to be_nil
  end

  it "should define a command of type Command" do
    default_command = described_class.command.
      to_hash[:"sh"]
    expect(default_command).to be(VagrantShellCommander::Command)
  end

  it "should define a config of type Config" do
    default_config = described_class.components.configs[:top].to_hash[:"sh"]
    expect(default_config).to be(VagrantShellCommander::Config)
  end

  context 'action hooks' do
    let(:hook) {double(append: true, prepend: true)}

    it "should define an action hook for machine_action_up" do
      hook_proc = described_class.components.action_hooks[:__all_actions__][0]
      hook = double
      expect(hook).to receive(:after).with(VagrantPlugins::ProviderVirtualBox::Action::ShareFolders,
                                           VagrantShellCommander::Action)
      hook_proc.call(hook)
    end
  end

end
