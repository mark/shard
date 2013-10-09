class Shard

  class Saver

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    include ShardDirectory

    attr_reader :shard, :gist, :full_gist

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(shard)
      @shard   = shard
    end

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.save(shard)
      new(shard).save!
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def save!
      create_shard_dir(shard.username, shard.name, shard.version)
      fetch_shard_contents

      gist.ruby_files.each do |file|
        write_file(file)
      end
    end

    private

    def fetch_shard_contents
      lister     = Shard::Lister.new(shard.username)
      @gist      = lister.shards[shard.name]
      @full_gist = Octokit.gist gist.id
    end

    def file_contents(filename)
      full_gist.files[filename].content
    end

    def write_file(file)
      path = file_path(shard.username, shard.name, shard.version, file.filename)

      File.write path, file_contents(file.filename)
    end
    
  end

end
