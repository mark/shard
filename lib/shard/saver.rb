class Shard

  class Saver

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    include ShardDirectory

    attr_reader :shard, :version

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(shard, version)
      @shard   = shard
      @version = version
    end

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.save(shard, version)
      new(shard, version).save!
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def save!
      create_shard_dir(shard.username, shard.name, version)

      shard.ruby_files.each do |filename|
        write_file(filename)
      end
    end

    private

    def file_contents(filename)
      url = file_url(filename)
      open(url).read
    end

    def file_url(filename)
      "https://gist.github.com/#{ shard.username }/#{ shard.id }/raw/#{ shard.commit(version) }/#{ filename }"
    end

    def write_file(filename)
      path = file_path(shard.username, shard.name, version, filename)

      File.write path, file_contents(filename)
    end
    
  end

end
