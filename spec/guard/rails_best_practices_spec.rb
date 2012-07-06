# encoding: utf-8
require 'spec_helper'

describe Guard::RailsBestPractices do
  subject { described_class.new }

  context '#start' do
    it 'should call #run_bestpractices by default' do
      subject.should_receive(:run_bestpractices).and_return(true)
      subject.start
    end

    it 'should call #run_bestpractices with :run_on_start => true' do
      guard = Guard::RailsBestPractices.new('rails_best_practices', :run_on_start => true )
      guard.should_receive(:run_bestpractices).and_return(true)
      guard.start
    end

    it 'should call #run_bestpractices with :run_on_start => false' do
      guard = Guard::RailsBestPractices.new('rails_best_practices', :run_on_start => false )
      guard.should_receive(:run_bestpractices).and_return(true)
      guard.start
    end
  end

  context '#stop' do
    it 'should return true' do
      subject.stop.should be_true
    end
  end

  context '#reload' do
    it 'should call #run_bestpractices' do
      subject.should_receive(:run_bestpractices).and_return(true)
      subject.reload
    end
  end

  context '#run_all' do
    it 'should call #run_bestpractices' do
      subject.should_receive(:run_bestpractices).and_return(true)
      subject.run_all
    end
  end

  context '#run_on_change' do
    it 'should call #run_bestpractices' do
      subject.should_receive(:run_bestpractices).and_return(true)
      subject.run_on_change('')
    end
  end

  context '#notify?' do
    it 'should return false by default' do
      subject.notify?.should be_false
    end

    it 'should return false with :notify => false' do
      guard = Guard::RailsBestPractices.new('rails_best_practices', :notify => false )
      guard.notify?.should be_false
    end

    it 'should return true with :notify => true' do
      guard = Guard::RailsBestPractices.new('rails_best_practices', :notify => true )
      guard.notify?.should be_true
    end
  end

  context '#run_bestpractices' do
    it 'should call railsbp with default options' do
      subject.should_receive('system').with(anything()).and_return(true)
      subject.send(:run_bestpractices)
    end

    it 'should call railsbp with complex options' do
      options = { :run_at_start => false,
                  :features     => false,
                  :with_git     => true,
                  :format       => 'html',
                  :silent       => true,
                  :with_mvim    => true,
                  :exclude      => 'schema.rb'
                }
      guard = Guard::RailsBestPractices.new('rails_best_practices', options)
      guard.should_receive('system').with(anything()).and_return(true)
      guard.send(:run_bestpractices)
    end
  end

  context '#format_option' do
    it 'should return nil if option value is false' do
      subject.send(:format_option, :features, false).should be_nil
    end

    it 'should return nil if option for guard only' do
      subject.send(:format_option, :run_at_start, true).should be_nil
    end

    it 'should return formatted argument if option value is true' do
      subject.send(:format_option, :with_git, true).should == "with-git"
    end

    it 'should return formatted argument if option value is string' do
      subject.send(:format_option, :output_file, 'out.html').should == "output-file out.html"
    end
  end
end
