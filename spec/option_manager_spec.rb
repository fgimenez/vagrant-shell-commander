require 'spec_helper'

describe VagrantPlugins::ShellCommander::OptionManager do
  let(:subject) {described_class.new}
  let(:argv) {double()}

  describe '#execute' do
    let(:option_parser) {double(:banner= => true, 
                                separator: true, 
                                on: true)}

    before(:each) do
      OptionParser.stub(:new).
        and_yield(option_parser)
      
      subject.stub(:parse_options).and_return(true)
    end
    
    after(:each) do

    end
      
    it 'displays a informing banner' do
      option_parser.should_receive(:banner=)

      subject.execute
    end
    
    it 'has a dir option' do
      dir_value = 'dir'
      
      option_parser.stub(:on).with('-d [DIR]', 
                                   anything, 
                                   anything).
        and_yield(dir_value)

      result = subject.execute

      expect(result[:values][:dir]).to eql(dir_value)
    end
    
    it 'has a cmd option' do
      cmd_value = 'cmd'
      
      option_parser.stub(:on).with("-c 'COMMAND'", 
                                   anything, 
                                   anything).
        and_yield(cmd_value)

      result = subject.execute

      expect(result[:values][:cmd]).to eql(cmd_value)
    end

    it 'has a user option' do
      user_value = 'user'
      
      option_parser.stub(:on).with('-u [USER]', 
                                   anything, 
                                   anything).
        and_yield(user_value)

      result = subject.execute

      expect(result[:values][:user]).to eql(user_value)
    end

  end
end
