require 'spec_helper'

describe Shard::Gist do

  let(:hashie) { TestGists.detect { |g| g.description == gist_name } }

  subject { Shard::Gist.new(hashie) }

  describe "shard gist" do

    let(:gist_name) { 'Shard: multiple files sample' }

    it "has 3 ruby files" do
      subject.ruby_files.length.must_equal 3
    end

    it "has a shard.rb file" do
      subject.shard_file.wont_be_nil
    end

  end

end
