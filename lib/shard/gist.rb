require 'yaml'

class Shard

  class Gist

    ################
    #              #
    # Declarations #
    #              #
    ################

    SHARD_FILENAME = /(?:^(\w+)\.)?shard\.rb$/

    ###############
    #             #
    # Constructor #
    #             #
    ###############

    def initialize(gist_hash)
      @gist_hash = gist_hash
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################

    def all_files
      files.values
    end

    def description
      @gist_hash.description
    end

    def id
      @gist_hash.id
    end

    def name
      match = shard_file.filename.match(SHARD_FILENAME)

      match[1] || id
    end

    def ruby_files
      files.select { |filename| filename =~ /\.rb$/ }.values
    end

    def shard_file
      files.select { |filename| filename =~ SHARD_FILENAME }.values.first
    end

    def url
      @gist_hash.html_url
    end

    def username
      @gist_hash.user.login
    end

    def valid_shard?
      ! shard_file.nil?
    end

    private

    def files
      @gist_hash.files.attrs
    end


  end

end
