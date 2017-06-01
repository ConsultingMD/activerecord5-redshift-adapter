require 'rake/testtask'
require 'bundler/gem_tasks'

require "#{__dir__}/test/config"
require "#{__dir__}/test/support/config"

desc 'Run tests by default'
task :default => :test

### Tests

desc 'Run Redshift tests'
Rake::TestTask.new('test') do |t|
  t.libs << 'test'
  t.test_files = (Dir.glob( "test/cases/**/*_test.rb" )\
    .reject {|x| x =~ %r[/adapters/] } \
    + Dir.glob("test/cases/adapters/redshift/**/*_test.rb")).sort
  t.warning = true
  t.verbose = true
end
