require 'octokit'

class Shard

  class Lister

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :username, :gists

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(username)
      @username = username
      
      load_gists
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def shards
      @shards ||= Hash.new.tap do |hash|
        gists.each do |gist|
          if Shard::ShardRecord.valid_shard?(gist)
            shard            = Shard::ShardRecord.new(gist)
            hash[shard.name] = shard
          end
        end
      end
    end

    def shard_names
      shards.keys.sort
    end

    private

    def fetch_gists
      Octokit.gists username
    end

    def gist_by_id(id)
      gists.detect { |gist| gist.id == id.to_s }
    end

    def load_gists
      @gists = fetch_gists.map { |gist| Gist.new(gist) }
    end

  end

end
