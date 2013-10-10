require 'thor'

class Shard::CLI < Thor

  ########
  #      #
  # List #
  #      #
  ########
  
  desc "list USERNAME", "List all shards for Github user USERNAME"
  
  def list(username)
    lister = Shard::Lister.new(username)

    if lister.shards.any?
      puts "Shards for Github user #{ username }:"
      puts

      lister.shard_names.each do |name|
        shard = lister.shards[name]
        puts "#{ name }:"
        puts "  Description | #{ shard.description }"
        puts "  URL         | #{ shard.url }"
        puts
      end
    else
      puts "Github user #{ username } does not have any shards."
      puts "Shards are gists that have a file named shard.rb or <foo>.shard.rb"
    end
  end

  ########
  #      #
  # Exec #
  #      #
  ########
  
  desc "exec USERNAME/SHARD", "Runs the shard named SHARD for Github user USERNAME"

  def exec(shard_line)
    Shard::Loader.load shard_line
  end

  #########
  #       #
  # Fetch #
  #       #
  #########
  
  desc "fetch USERNAME/SHARD", "Downloads the shard named SHARD for Github user USERNAME"

  def fetch(shard_line)
    username, shard = shard_line.split '/'
    shard = Shard::ShardRecord.new(username, shard, 'HEAD')

    Shard::Saver.save(shard, verbose: true)
  end

  ########
  #      #
  # Test #
  #      #
  ########
  
  desc "test USERNAME/SHARD", "Runs the tests for shard named SHARD for Github user USERNAME"

  def test(shard_line)
    Shard::Loader.test shard_line
  end

end
