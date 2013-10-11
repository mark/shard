module Shard::CLI

  class List

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.run(username)
      new.run(username)
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def run(username)
      lister = Shard::Lister.new(username)

      if lister.shards.any?
        puts "Shards for Github user #{ username }:"
        puts

        lister.shard_names.each do |name|
          shard = lister.shards[name]
          puts "#{ name }:"
          puts "  Description | #{ shard.description }"
          puts "  URL         | #{ shard.url }"
          puts
        end
      else
        puts "Github user #{ username } does not have any shards."
        puts "Shards are gists that have a file named shard.rb or <foo>.shard.rb"
      end
    end

    private

  end

end

