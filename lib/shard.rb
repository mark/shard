class Shard
  
  def self.api
    @api ||= Octokit::Client.new netrc: (Credentials.saved? && Credentials.valid?)
  end

  def self.Ref(shard_line)
    case shard_line
    when String     then Shard::Ref.parse(shard_line)
    when Shard::Ref then shard_line
                    else raise ArgumentError
    end
  end

  require 'shard/credentials'
  require 'shard/shard_directory'
  require 'shard/loader'
  require 'shard/saver'
  require 'shard/lister'
  require 'shard/gist'
  require 'shard/ref'
  require 'shard/kernel'

end

