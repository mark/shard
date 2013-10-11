module Shard::CLI

  require 'shard/cli/commands'
  require 'shard/cli/config'

  ##################
  #                #
  # Module Methods #
  #                #
  ##################
  
  def self.start(args)
    if args[0] =~ Shard::SHARD_LINE
      args << "exec" if args.length == 1
      args[0], args[1] = args[1], args[0]
    end

    Commands.start(args)
  end

end
