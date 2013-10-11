require 'octokit'
require 'netrc'

class Shard

  class Credentials < Struct.new(:username, :password)

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    GITHUB_API_ENTRY = "api.github.com"

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.current
      username, password = Netrc.read[GITHUB_API_ENTRY]
      new(username, password)
    end

    def self.saved?
      current.present?
    end

    def self.valid?
      Octokit.validate_credentials netrc: true
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def save
      netrc_file                   = Netrc.read
      netrc_file[GITHUB_API_ENTRY] = username, password

      netrc_file.save
    end

    def present?
      !(username.nil? || password.nil?)
    end

  end

end
