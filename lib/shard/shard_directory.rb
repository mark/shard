class Shard

  module ShardDirectory

    ##################
    #                #
    # Module Methods #
    #                #
    ##################
    
    def create_root
      unless Dir.exists?(path)
        Dir.mkdir(path)
      end
    end

    def create_shard_dir(username, shard, version)
      dir = directory(username, shard, version)

      unless shard_dir_exists?(username, shard, version)
        FileUtils.mkpath(dir)
      end
    end

    def shard_dir_exists?(username, shard, version)
      dir = directory(username, shard, version)

      Dir.exists?(dir)
    end

    def directory(username, shard, version)
      File.join(path, username, shard, version)
    end

    def path
      File.join(Dir.home, '.shard')
    end

    def file_path(username, shard, version, filename)
      File.join( directory(username, shard, version), filename )
    end

  end

end
