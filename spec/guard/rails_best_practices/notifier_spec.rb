require 'spec_helper'

describe Guard::RailsBestPractices::Notifier do
  subject { described_class }

  let(:guard_notifier) { ::Guard::Notifier }

  describe '#guard_message' do
    context 'when recieves true and duration' do
      it 'should format success message' do
        subject.guard_message(true, 5.5).
        should eq "Rails Best Practices has been run successfully\nin 5.50 seconds."
      end
    end

    context 'when recieves false and duration' do
      it 'should format fail message' do
        subject.guard_message(false, 5.5).
        should eq "Rails Best Practices run has failed!\nPlease check manually."
      end
    end
  end

  describe '#image' do
    context 'when receives true' do
      specify { subject.guard_image(true).should be :success }
    end

    context 'when receives false' do
      specify { subject.guard_image(false).should be :failed }
    end
  end

  describe '#notify' do
    context 'when recieves success' do
      it 'should call Guard::Notifier for succeed checklist run' do
        guard_notifier.should_receive(:notify).with(
          "Rails Best Practices has been run successfully\nin 5.50 seconds.",
          :title => 'Rails Best Practices',
          :image => :success
          )
        subject.notify(true, 5.5)
      end
    end

    context 'when recieves failed' do
      it 'should call Guard::Notifier for failed checklist run' do
        guard_notifier.should_receive(:notify).with(
          "Rails Best Practices run has failed!\nPlease check manually.",
          :title => 'Rails Best Practices',
          :image => :failed
        )
        subject.notify(false, 5.5)
      end
    end
  end
end
