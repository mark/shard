class Shard

  class Ref < Struct.new(:user, :name, :file, :version)

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    PATTERN = %r{([a-zA-Z0-9_-]+)/(\w+)} # (?::(\w+))?

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.parse(shard_line)
      if matcher = shard_line.match(PATTERN)
        user    = matcher[1]
        name    = matcher[2]
        file    = nil
        version = 'HEAD'

        new(user, name, file, version)
      else
        nil
      end
    end

    def self.valid?(shard_line)
      shard_line =~ PATTERN
    end

  end

end
