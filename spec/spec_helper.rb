gem 'minitest'

require 'shard'

require 'minitest/autorun'

TestGists = Octokit.gists 'shard-test'
