require 'spec_helper'

describe VagrantShellCommander::Command do
  let(:subject) {described_class.new}

  it 'has a help option'

  it 'has a cwd option'

  it 'has a command option'

  it 'has a vm option'

  it 'reports an error if the given vm is not defined'

  it 'reports an error if none vm is running'

  it 'executes the given command on every vm if vm option is missing'

  it 'shows the help when no command is given'
end
