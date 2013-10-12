class Shard

  module ShardDirectory

    ##################
    #                #
    # Module Methods #
    #                #
    ##################
    
    def create_shard_dir(ref)
      dir = directory(ref)

      unless shard_dir_exists?(ref)
        FileUtils.mkpath(dir)
      end
    end

    def shard_dir_exists?(ref)
      Dir.exists? directory(ref)
    end

    def directory(ref)
      File.join(root_path, ref.user, ref.name, ref.version)
    end

    def root_path
      File.join(Dir.home, '.shard')
    end

    def file_path(ref, filename, options = {})
      File.join( directory(ref), filename )
    end

    def find_file_path(ref, filename, options = {})
      find_file_paths(ref, filename).first
    end

    def find_file_paths(ref, *filenames)
      full_names = filenames.map do |filename|
        File.join( directory(ref), filename)
      end

      Dir[ *full_names ]
    end

  end

end
