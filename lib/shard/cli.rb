module Shard::CLI

  require 'shard/cli/commands'
  require 'shard/cli/config'

  ##################
  #                #
  # Module Methods #
  #                #
  ##################
  
  def self.start(args)
    if Shard::Ref.valid?(args[0])
      args << "exec" if args.length == 1
      args[0], args[1] = args[1], args[0]
    end

    Commands.start(args)
  end

end
