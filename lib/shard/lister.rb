class Shard

  class Lister

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :username

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(username)
      @username = username
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def gists
      @gists ||= fetch_gists.map { |gist| Gist.new(gist) }
    end

    def shards
      @shards ||= Hash.new.tap do |hash|
        valid = gists.select { |gist| gist.valid_shard? }
        valid.each do |shard|
          hash[shard.name] = shard
        end
      end
    end

    def shard_names
      shards.keys.sort
    end

    private

    def fetch_gists
      Shard.api.gists username
    end

    def gist_by_id(id)
      gists.detect { |gist| gist.id == id.to_s }
    end

  end

end
