require 'spec_helper'

describe Shard::Lister do

  subject do
    Shard::Lister.new('shard-test').tap do |obj|
      def obj.fetch_gists
        TestGists
      end
    end
  end

  describe :gists do

    it "lists 5 gists" do
      subject.gists.length.must_equal 5
    end

    it "returns Gists" do
      subject.gists.each do |gist|
        gist.must_be_instance_of Shard::Gist
      end
    end

  end

  describe :shards do

    it "lists 4 shards" do
      subject.shards.length.must_equal 4
    end

    it "returns ShardRecords" do
      subject.shards.each do |name, shard|
        shard.must_be_instance_of Shard::Gist
      end
    end

  end

end
