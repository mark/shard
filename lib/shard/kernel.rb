module Kernel

  def shard(shard_line)
    Shard::Loader.load(shard_line)
  end

  def require_shard_file(filename = nil)
    raise ArgumentError unless Shard.current_loader

    Shard.current_loader.load_file(filename)
  end

end
