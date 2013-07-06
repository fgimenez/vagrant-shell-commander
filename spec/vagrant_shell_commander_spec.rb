require 'spec_helper'

describe VagrantShellCommander::Plugin do
  it 'should have a name' do
    expect(described_class.name).not_to be_nil
  end

  describe "main command" do
    it "should define a command of type Command" do
      default_command = described_class.command.
        to_hash[:"execute-shell-command"]
      expect(default_command).to be(VagrantShellCommander::Command)
    end
  end
end
