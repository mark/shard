gem 'octokit'
gem 'thor'

require 'open-uri'

class Shard
  class << self
    attr_accessor :current_loader
  end
end

require 'shard/shard_directory'
require 'shard/loader'
require 'shard/saver'
require 'shard/lister'
require 'shard/gist'
require 'shard/shard_record'
require 'shard/cli'
require 'shard/kernel'
