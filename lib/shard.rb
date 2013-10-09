gem 'octokit'
gem 'thor'

require 'open-uri'

require 'shard/shard_directory'
require 'shard/loader'
require 'shard/saver'
require 'shard/lister'
require 'shard/gist'
require 'shard/shard_record'
require 'shard/cli'

class Shard

  class << self
    attr_reader :current_loader
  end

end

module Kernel

  def shard(shard_line)
    Shard::Loader.load(shard_line)
  end

  def require_shard_file(filename)
    raise ArgumentError unless Shard.current_loader

    Shard.current_loader.load_file(filename)
  end

end
