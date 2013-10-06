require 'spec_helper'

describe Shard::Gist do

  let(:hashie) { TestGists.detect { |g| g.description == gist_name } }

  subject { Shard::Gist.new(hashie) }

  describe "config gist" do

    let(:gist_name) { 'Shards' }

    it "has a shard config" do
      subject.shard_configs.must_be_instance_of Hash
    end

    it "specifies 2 shards" do
      subject.shard_configs.keys.length.must_equal 2
      subject.shard_configs['sample_shard'].wont_be_nil
    end

  end

  describe "shard gist" do

    let(:gist_name) { 'Shard: multiple files sample' }

    it "has 3 ruby files" do
      subject.ruby_files.length.must_equal 3
    end

    it "has a shard.rb file" do
      f = subject.ruby_files.detect { |f| f.filename == 'shard.rb' }
      f.wont_be_nil
    end

  end

end
