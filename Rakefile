require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.pattern = 'tests/**/*_spec.rb'
  t.warning = false
  t.verbose = false
end

desc "Run tests"
task :default => :test
