require 'spec_helper'

describe VagrantShellCommander::Command do
  let(:subject) {described_class.new('2', 'command')}

  describe '#execute' do
    it 'returns 0 if all went good' do
      expect(subject.execute).to eql(0)
    end
    
    describe 'options' do
      let(:option_parser) {double(:banner= => true)}

      before(:each) do
        OptionParser.stub(:new).
          and_yield(option_parser)
      end
      
      after(:each) do
        subject.execute
      end
      
      it 'displays a informing banner' do
        option_parser.should_receive(:banner=)
      end
      
      it 'has a help option'
      
      it 'has a cwd option'
      
      it 'has a cmd option'

    end

    describe 'error reporting' do
      it 'reports an error if the given vm is not defined'
      
      it 'reports information for every non-running machine'
    end
    
    describe 'command execution' do
      it 'executes the given command'
      
      it 'executes the given command on every vm if vm option is missing'
      
      it 'shows the help when no command is given'
    end
  end
end
