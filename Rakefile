require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs.push %w(lib spec)
  t.pattern = 'spec/**/*_spec.rb'
end

task default: :test
