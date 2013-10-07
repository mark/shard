class Shard

  module ShardDirectory

    ##################
    #                #
    # Module Methods #
    #                #
    ##################
    
    def self.create_root
      unless Dir.exists?(path)
        Dir.mkdir(path)
      end
    end

    def self.create_shard_dir(username, shard, version)
      dir = directory(username, shard, version)

      unless Dir.exists?(dir)
        FileUtils.mkpath(dir)
      end
    end

    def self.directory(username, shard, version)
      File.join(path, username, shard, version)
    end

    def self.path
      File.join(Dir.home, '.shard')
    end

    def self.file_path(username, shard, version, filename)
      File.join( directory(username, shard, version), filename )
    end

  end

end
