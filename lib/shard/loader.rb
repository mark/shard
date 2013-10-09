class Shard

  class Loader

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    include ShardDirectory

    attr_reader :shard

    SHARD_LINE_REGEX = %r{([a-zA-Z0-9_-]+)/(\w+)(?::(\w+))?}

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
    
    def self.load(shard_line)
      new(shard_line).load
    end

    def self.test(shard_line)
      new(shard_line).test
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def load
      ensure_shard_saved

      require shard_file_path
    end

    def test
      ensure_shard_saved

      require shard_file_path
      require *shard_test_paths
    end

    private

    def already_loaded?
      shard_dir_exists?(shard.username, shard.name, shard.version)
    end

    def ensure_shard_saved
      unless already_loaded?
        Shard::Saver.save shard
      end
    end

    def parse_shard_line(shard_line)
      if match = shard_line.match(SHARD_LINE_REGEX)
        username = match[1]
        name     = match[2]
        version  = parse_version match[3]

        @shard = Shard::ShardRecord.new(username, name, version)
      end
    end

    def parse_version(raw_version)
      raw_version || 'HEAD'
    end

    def shard_file_path
      path = file_path(shard.username, shard.name, shard.version, '*shard.rb')
      Dir[ path ].first
    end

    def shard_test_paths
      test_path  = file_path(shard.username, shard.name, shard.version, '*_test.rb')
      test_files = Dir[ test_path ]

      spec_path  = file_path(shard.username, shard.name, shard.version, '*_spec.rb')
      spec_files = Dir[ spec_path ]

      test_files + spec_files
    end

  end

end
