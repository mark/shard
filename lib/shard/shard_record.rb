class Shard::ShardRecord

  ################
  #              #
  # Declarations #
  #              #
  ################
  
  attr_reader :username, :name, :version

  ###############
  #             #
  # Constructor #
  #             #
  ###############
  
  def initialize(username, name, version = "HEAD")
    @username = username
    @name     = name
    @version  = version
  end

  ####################
  #                  #
  # Instance Methods #
  #                  #
  ####################

end
