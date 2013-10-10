module Kernel

  def shard(shard_line)
    Shard::Loader.load(shard_line)
  end

end
