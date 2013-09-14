require 'spec_helper'

describe VagrantShellCommander::Config do

  it 'should have a sh attr_accessor' do
    object = described_class.new

    expect(object).to respond_to(:sh)
    expect(object).to respond_to(:sh=)
  end

end
