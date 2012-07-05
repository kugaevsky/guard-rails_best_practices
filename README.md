# Guard - Rails Best Practices

BDD your [Rails Best Practices](http://rails-bestpractices.com/) checklist alongside your specs with [Guard](https://github.com/guard/guard).

By adding your own checklists, this can be a great way to enforce those code style documents that everyone on your team has forgotten!

## Install

In your Rails 3.0+ application, add the `guard`, `rails_best_practices`, and `guard-rails_best_practices` gems to your `Gemfile`:

    group :development do
      gem 'rails_best_practices'
      gem 'guard'
      gem 'guard-rails_best_practices'
    end

Add guard definitions to your `Guardfile` by running:

    guard init rails_best_practices

Guard will now inform you of Rails Best Practices warnings.

## Options

These options are available (with the following defaults).

**Rails best practices options**

    :vendor         => true   # Include vendor/
    :spec           => true   # Include spec/
    :test           => true   # Include test/
    :features       => true   # Include features/
    :without_color  => false  # Only output plain text without color
    :silent         => false  # Silent mode

    :format                   # Output format
    :with_textmate  => false  # Open file by textmate in html format
    :with_mvim      => false  # Open file by mvim in html format
    :with_hg        => false  # Display hg commit and username, only support html format
    :with_git       => false  # Display git commit and username, only support html format

    :exclude                  # Don't analyze files matching a pattern (comma-separated regexp list)
    :only                     # analyze files only matching a pattern (comma-separated regexp list)

**Guard options**

    :run_at_start  => true  # Run checklist when guard starts
    :notify        => false # Send notifications to Growl/lib-notify

See https://github.com/railsbp/rails_best_practices for details.

It is recommended that you run `rails_best_practices -g` to generate a `rails_best_practices.yml` file for your application,
so you can tune the checklists to your own unique tastes.

You can also extend `rails_best_practices` by [writing your own checklists](https://github.com/railsbp/rails_best_practices/wiki/How-to-write-your-own-check-list) .

## Authors

[Logan Koester](http://github.com/logankoester)
