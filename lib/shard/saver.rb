class Shard

  class Saver

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    include ShardDirectory

    attr_reader :ref, :gist, :full_gist, :options

    SHA_LENGTH = 8

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(shard_line_or_ref, options = {})
      @ref     = Shard::Ref(shard_line_or_ref)
      @options = options
    end

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.save(shard_line, options = {})
      new(shard_line, options).save!
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def save!
      return if shard_dir_exists?(ref) && options[:lazy]
      
      create_shard_dir(ref)
      fetch_shard_contents

      gist.all_files.each do |file|
        write_file(file)
      end

      if options[:verbose]
        puts "VERSION #{ version }..."
      end
    end

    private

    def fetch_shard_contents
      lister     = Shard::Lister.new(ref.user)
      @gist      = lister.shards[ref.name]
      @full_gist = Octokit.gist gist.id
    end

    def file_contents(filename)
      full_gist.files[filename].content
    end

    def write_file(file)
      path     = file_path(ref, file.filename)
      contents = file_contents(file.filename)

      if options[:verbose]
        puts "Saving #{ file.filename }"
      end

      File.write path, contents
    end
    
    def version(length = SHA_LENGTH)
      full_version = full_gist.history.first.version
      full_version[0...length]
    end

  end

end
