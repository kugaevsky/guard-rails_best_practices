require 'rubygems'
require 'guard/rails_best_practices'
require 'rspec'

RSpec.configure do |config|
  config.color_enabled = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true

  config.before(:each) do
    ENV["GUARD_ENV"]="test"
  end
end
