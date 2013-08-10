$:.unshift(File.dirname(__FILE__) + '/../../lib')
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:spec)
Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = %w{--format pretty}
end

task default: [:spec, :cucumber]
