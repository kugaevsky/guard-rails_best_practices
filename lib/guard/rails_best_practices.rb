require 'guard'
require 'guard/guard'

require File.join(File.dirname(__FILE__), "rails_best_practices/version")

module Guard
  class RailsBestPractices < Guard
    autoload :Notifier, 'guard/rails_best_practices/notifier'

    def initialize(watchers = [], options = {})
      rbp_opts = {  :vendor         => true,
                    :spec           => true,
                    :test           => true,
                    :features       => true
                  }
      guard_opts = { :run_at_start   => true }
      options = rbp_opts.merge options
      options = guard_opts.merge options

      super
    end

    def start
      run_bestpractices if options[:run_at_start]
    end

    def stop
      true
    end

    def reload
      run_bestpractices
    end

    def run_all
      run_bestpractices
    end

    def run_on_change(paths)
      run_bestpractices
    end

    def run_on_deletion(paths)
    end

    def notify?
      !!options[:notify]
    end

  private
    def run_bestpractices
      started_at = Time.now

      run_options = options.select do |key, value|
        value && ![:run_at_start, :notify].include?(key)
      end.to_a.map do |opt|
        f_opt = opt[0].to_s.gsub('_','-')
        if [:format, :exclude, :only].include?(opt[0])
          [ f_opt, opt[1] ].join(' ')
        else
          f_opt
        end
      end

      cmd = (['rails_best_practices'] + run_options).join(' --')

      UI.info "Running Rails Best Practices checklist with command\n=> #{cmd}\n", :reset => true

      @result = system(cmd)

      Notifier::notify( @result, Time.now - started_at ) if notify?
      @result
    end

  end
end
