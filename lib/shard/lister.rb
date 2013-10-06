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
        shard_configs = shard_gist.shard_configs

        shard_configs.each do |name, configs|
          hash[name] = build_shard(configs)
        end
      end
    end

    private

    def fetch_gists
      Octokit.gists username
    end

    def gist_by_id(id)
      gists.detect { |gist| gist.id == id.to_s }
    end

    def load_gists
      gists = fetch_gists

      @gists = gists.map { |gist| Gist.new(gist) }
    end

    def build_shard(configs)
      gist = gist_by_id(configs['id'])
      Shard::ShardRecord.new(configs, gist)
    end

    def shard_gist
      @shard_gist ||= gists.detect { |gist| gist.description == 'Shards' }
    end

  end

end
