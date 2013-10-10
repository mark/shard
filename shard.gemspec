Gem::Specification.new do |s|

  s.name        = 'shard'
  s.version     = '0.1.1'
  s.date        = '2013-10-09'
  s.summary     = "Very lightweight ruby package manager built on gist."
  s.description = <<-EOF
Shard is a light-weight code loading-and-running-and-sharing tool, built on top of http://gist.github.com.

You can load the shard's code using a Kernel#shard method, and can load, run, and test a shard directly from the command line.
  EOF
  s.license     = "MIT"

  s.files       = ['lib/shard.rb'] + Dir['lib/shard/*.rb']
  s.executables << 'shard'

  s.authors     = ["Mark Josef"]
  s.email       = 'mcphage@gmail.com'
  s.homepage    = "https://github.com/mark/shard"

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency 'octokit', '= 1.25.0'
  s.add_dependency 'thor'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'bundler'
end
