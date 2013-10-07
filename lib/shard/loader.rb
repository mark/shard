class Shard

  class Loader

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    include ShardDirectory

    attr_reader :username, :shard, :filename, :version

    SHARD_LINE_REGEX = %r{([a-zA-Z0-9_-]+)/(\w+)(?:/([a-zA-Z0-9_.-]+))?(?::(\w+))?}

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(shard_line)
      parse_shard_line(shard_line)
    end

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.load(shard, version, scope)
      new(shard, version).load!(scope)
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def load!(scope)

    end

    private

    def parse_filename(raw_filename)
      return 'shard.rb' unless raw_filename

      raw_filename += '.rb' unless raw_filename =~ /\.rb$/
    end

    def parse_shard_line(shard_line)
      if match = shard_line.match(SHARD_LINE_REGEX)
        @username = match[1]
        @shard    = match[2]
        @filename = parse_filename match[3]
        @version  = parse_version  match[4]
      end
    end

    def parse_version(raw_version)
      raw_version || 'HEAD'
    end

  end

end
