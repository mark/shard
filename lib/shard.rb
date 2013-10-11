class Shard
  class << self
    attr_accessor :current_loader
  end

  SHARD_LINE = %r{([a-zA-Z0-9_-]+)/(\w+)(?::(\w+))?}

  require 'shard/shard_directory'
  require 'shard/loader'
  require 'shard/saver'
  require 'shard/lister'
  require 'shard/gist'
  require 'shard/shard_record'
  require 'shard/kernel'

end

