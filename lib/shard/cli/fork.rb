module Shard::CLI

  class Fork

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :ref

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(shard_line)
      @ref = Shard::Ref(shard_line)
    end

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.run(shard_line)
      new(shard_line).run
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def run
      if ref.nil?
        puts "That is not a valid shard reference."
        return
      end

      if Shard::Credentials.valid?
        fork_shard
      else
        puts "You are not currently logged into Github."
        Shard::Config.run

        if Shard::Credentials.saved?
          run
        end
      end
    end

    private

    def fork_shard
      lister = Shard::Lister.new(ref.user)
      shard  = lister.shards[ref.name]

      if shard
        puts "Forking #{ ref.user }/#{ ref.name }..."
        Shard.api.fork_gist(shard.id)
      else
        puts "That is not a valid shard reference."
      end
    end

  end

end
