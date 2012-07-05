require 'spec_helper'

describe Guard::RailsBestPractices::Notifier do
  subject { Guard::RailsBestPractices::Notifier }

  it 'should format success message' do
    message = subject.guard_message(true, 5.5)
    message.should == "Rails Best Practices has been run successfully\nin 5.50 seconds."
  end

  it 'should format fail message' do
    message = subject.guard_message(false, 5.5)
    message.should == "Rails Best Practices run has failed!\nPlease check manually."
  end

  it 'should select success image' do
    subject.guard_image(true).should == :success
  end

  it 'should select failed image' do
    subject.guard_image(false).should == :failed
  end

  it 'should call Guard::Notifier for succeed checklist run' do
    ::Guard::Notifier.should_receive(:notify).with(
      "Rails Best Practices has been run successfully\nin 5.50 seconds.",
      :title => 'Rails Best Practices',
      :image => :success
    )
    subject.notify(true, 5.5)
  end

  it 'should call Guard::Notifier for failed checklist run' do
    ::Guard::Notifier.should_receive(:notify).with(
      "Rails Best Practices run has failed!\nPlease check manually.",
      :title => 'Rails Best Practices',
      :image => :failed
    )
    subject.notify(false, 5.5)
  end
end
