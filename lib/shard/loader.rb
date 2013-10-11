class Shard

  class Loader

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    include ShardDirectory

    SHARD_FILE_PATTERN = %q(*shard.rb)
    TEST_FILE_PATTERNS = %w( *_spec.rb *_test.rb )

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
      load_file(SHARD_FILE_PATTERN)
    end

    def load_file(filename)
      ensure_shard_saved

      require file_path(ref, filename)
    end

    def test
      ensure_shard_saved

      require *file_paths(ref, *TEST_FILE_PATTERNS)
    end

    private

    def ensure_shard_saved
      Shard::Saver.save ref, lazy: true
    end

  end

end
