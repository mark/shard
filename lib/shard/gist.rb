require 'open-uri'
require 'yaml'

class Shard

  class Gist

    ################
    #              #
    # Declarations #
    #              #
    ################

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(hash)
      @basic = hash
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def description
      @basic.description
    end

    def id
      @basic.id
    end
    
    def ruby_files
      files.select { |filename| filename =~ /\.rb$/ }.values
    end

    def shard_configs
      return @shard_configs if @shard_configs

      file = files['shards.yml']
      return (@shard_configs = {}) unless file

      file_url = file.raw_url
      contents = open(file_url).read

      @shard_configs = if contents
        YAML.load contents
      else
        {}
      end
    end

    private

    def files
      @basic.files
    end


  end

end
