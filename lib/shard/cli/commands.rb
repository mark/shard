require 'thor'

module Shard::CLI

  class Commands < Thor

    ########
    #      #
    # List #
    #      #
    ########
    
    desc "list USERNAME", "List all shards for Github user USERNAME"
    
    def list(username)
      Shard::CLI::List.run(username)
    end

    ########
    #      #
    # Exec #
    #      #
    ########
    
    desc "USERNAME/SHARD", "Runs the shard named SHARD for Github user USERNAME"

    def exec(shard_line)
      Shard::Loader.load shard_line
    end

    #########
    #       #
    # Fetch #
    #       #
    #########
    
    desc "USERNAME/SHARD fetch", "Downloads the shard named SHARD for Github user USERNAME"

    def fetch(shard_line)
      Shard::Saver.save shard_line, verbose: true
    end

    ########
    #      #
    # Test #
    #      #
    ########
    
    desc "USERNAME/SHARD test", "Runs the tests for shard named SHARD for Github user USERNAME"

    def test(shard_line)
      Shard::Loader.test shard_line
    end

    ##########
    #        #
    # Config #
    #        #
    ##########
    
    desc "config", "Set up Github credentials for use in shard"

    def config
      Shard::CLI::Config.run
    end

    ########
    #      #
    # View #
    #      #
    ########
    
    desc "USERNAME/SHARD view", "Opens the shard in a browser window"

    def view(shard_line)
      if line = Shard::Ref.parse(shard_line)
        lister = Shard::Lister.new(line.user)
        shard  = lister.shards[line.name]
        url    = shard.url

        `open #{ url }`
      else
        puts "'#{ shard_line }' is not a valid shard reference."
      end
    end

    ########
    #      #
    # Fork #
    #      #
    ########
    
    desc "USERNAME/SHARD fork", "Forks a copy of the shard into your Github account (requires authentication)"

    def fork(shard_line)
        Shard::CLI::Fork.run shard_line
    end


  end

end
