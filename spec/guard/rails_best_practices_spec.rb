# encoding: utf-8
require 'spec_helper'

describe Guard::RailsBestPractices do
  let(:run_at_start)      { described_class.new([], :run_at_start => true) }
  let(:not_run_at_start)  { described_class.new([], :run_at_start => false) }
  let(:notifiable)        { described_class.new([], :notify => true) }
  let(:unnotifiable)      { described_class.new([], :notify => false) }

  describe '#start' do
    context 'by default' do
      it 'should call #run_bestpractices' do
        subject.should_receive(:run_bestpractices).and_return(true)
        subject.start
      end
    end

    context 'when run_on_start set to true' do
      it 'should call #run_bestpractices' do
        run_at_start.should_receive(:run_bestpractices).and_return(true)
        run_at_start.start
      end
    end

    context 'when run_on_start set to false' do
      it 'should not call #run_bestpractices' do
        not_run_at_start.should_not_receive(:run_bestpractices).and_return(true)
        not_run_at_start.start
      end
    end
  end

  describe '#stop' do
    specify { subject.stop.should be_true }
  end

  describe '#reload' do
    it 'should call #run_bestpractices' do
      subject.should_receive(:run_bestpractices).and_return(true)
      subject.reload
    end
  end

  describe '#run_all' do
    it 'should call #run_bestpractices' do
      subject.should_receive(:run_bestpractices).and_return(true)
      subject.run_all
    end
  end

  describe '#run_on_change' do
    it 'should call #run_bestpractices' do
      subject.should_receive(:run_bestpractices).and_return(true)
      subject.run_on_change('')
    end
  end

  describe '#notify?' do
    context 'by default' do
      specify { subject.notify?.should be_false }
    end

    context 'when notify option set to true' do
      specify { notifiable.notify?.should be_true }
    end

    context 'when notify option set to false' do
      specify { unnotifiable.notify?.should be_false }
    end
  end

  describe '#run_bestpractices' do
    context 'by default' do
      it 'should run railsbp with default options' do
        subject.should_receive(:system).
          with(anything).
          and_return(true)
        subject.send(:run_bestpractices)
      end
    end

    context 'with complex options' do
      it 'should call railsbp with formatted command' do
        options = { :run_at_start => false,
                    :features     => false,
                    :with_git     => true,
                    :format       => 'html',
                    :silent       => true,
                    :with_mvim    => true,
                    :exclude      => 'schema.rb'
                  }
        guard = described_class.new([], options)
        guard.should_receive(:system).with(anything).and_return(true)
        guard.send(:run_bestpractices)
      end
    end
  end

  describe '#format_option' do
    context 'if option value is false' do
      specify { subject.send(:format_option, :features, false).should be_nil }
    end

    context 'if option for guard only' do
      specify { subject.send(:format_option, :run_at_start, true).should be_nil }
    end

    context 'if option value is true' do
      it 'should return formatted key' do
        subject.send(:format_option, :with_git, true).should eq "with-git"
      end
    end

    context 'if option value is string' do
      it 'should correctly format it' do
        subject.send(:format_option, :output_file, 'out.html').
                        should eq "output-file out.html"
      end
    end
  end
end
