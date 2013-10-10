class Shard

  class Saver

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    include ShardDirectory

    attr_reader :shard, :gist, :full_gist, :options

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(shard, options = {})
      @shard   = shard
      @options = options
    end

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.save(shard, options = {})
      new(shard, options).save!
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def save!
      create_shard_dir(shard.username, shard.name, shard.version)
      fetch_shard_contents

      gist.all_files.each do |file|
        write_file(file)
      end

      if options[:verbose]
        puts "VERSION #{ version(8) }..."
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
      path     = file_path(shard.username, shard.name, shard.version, file.filename)
      contents = file_contents(file.filename)

      if options[:verbose]
        puts "Saving #{ file.filename }"
      end

      File.write path, contents
    end
    
    def version(length)
      full_version = full_gist.history.first.version
      full_version[0...length]
    end

  end

end
