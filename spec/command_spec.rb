require 'spec_helper'

describe VagrantShellCommander::Command do
  let(:subject) {described_class.new('2', 'command')}
  let(:argv) {double()}

  before(:each) do
    subject.stub(:parse_options).and_return(argv)
  end

  describe '#execute' do
    it 'returns 0 if all went good' do
      expect(subject.execute).to eql(0)
    end
    
    describe 'options' do
      after(:each) do
        subject.execute
      end

      it 'parses the given options' do
        opts = {parser: 'parser', values: 'values'}
        VagrantShellCommander::OptionManager.stub_chain(:new, :execute).
          and_return(opts)
        
        subject.should_receive(:parse_options).with(opts[:parser])
      end
      
      it 'returns on option parsing failure' do
        subject.stub(:parse_options).and_return(false)
        
        expect(subject.execute).to eql(nil)
      end
      
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
