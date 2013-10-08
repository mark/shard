class Shard::ShardRecord

  ################
  #              #
  # Declarations #
  #              #
  ################
  
  attr_reader :gist

  ###############
  #             #
  # Constructor #
  #             #
  ###############
  
  def initialize(gist)
    @gist = gist
  end

  #################
  #               #
  # Class Methods #
  #               #
  #################
  
  def self.valid_shard?(gist)
    ! gist.shard_file.nil?
  end

  ####################
  #                  #
  # Instance Methods #
  #                  #
  ####################

  def description
    gist.description
  end

  def name
    shard_file = gist.shard_file
    match      = shard_file.filename.match(Shard::Gist::SHARD_FILENAME)

    match[1] || gist.id
  end

  def url
    gist.url
  end

  def username
    gist.user.login
  end

  def versions
    # @gist
  end

end
