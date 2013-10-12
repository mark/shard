require 'io/console'

module Shard::CLI

  class Config

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.run
      new.run
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def run
      if credentials_saved?
        replace_credentials
      else
        add_credentials
      end
    end

    private

    def add_credentials
      puts <<-EOF
To use shard features that require a Github login,
please enter your username and password below.

Note, you can provide an Personal Access Token instead
of a password (recommended).
(See https://github.com/settings/tokens/new for more information)

EOF

      print "  Username | "
      username = STDIN.gets.to_s.chomp
      print "  Password | "
      password = STDIN.noecho(&:gets).to_s.chomp

      save_credentials(username, password)

      if credentials_saved?
        puts "\nCredentials saved to ~/.netrc"

        validate_login
      else
        puts "\nCredentials have been cleared."
      end
    end

    def credentials_saved?
      Shard::Credentials.saved?
    end

    def replace_credentials
      str = valid_login? ? "" : "invalid "
      
      puts "You currently have #{ str }Github credentials saved in ~/.netrc"
      print "Do you wish to replace them? [yn] "

      if yes?
        add_credentials
      end
    end

    def save_credentials(username, password)
      Shard::Credentials.new(username, password).save
    end

    def validate_login
      if valid_login?
        puts "\nThe saved Github credentials are valid."
      else
        puts "\nThe saved Github credentials are invalid."
        print "Do you wish to re-enter them? [yn] "

        if yes?
          add_credentials
        end
      end
    end

    def valid_login?
      Shard::Credentials.valid?
    end

    def yes?
      STDIN.gets.chomp.downcase == 'y'
    end

  end

end
