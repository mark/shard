require 'spec_helper'

describe Shard::Loader do

  describe "Parsing the shard line" do

    it "parses a fully qualified shard line" do
      shard = Shard::Loader.new('shard-test/multiple_files/bar:1')
      
      shard.username.must_equal 'shard-test'
      shard.shard.must_equal    'multiple_files'
      shard.filename.must_equal 'bar.rb'
      shard.version.must_equal  '1'
    end

    it "parses a shard line without a file name or version" do
      shard = Shard::Loader.new('shard-test/multiple_files')
      
      shard.username.must_equal 'shard-test'
      shard.shard.must_equal    'multiple_files'
      shard.filename.must_equal 'shard.rb'
      shard.version.must_equal  'HEAD'
    end

    it "parses a shard line with a file name but no version" do
      shard = Shard::Loader.new('shard-test/multiple_files/foo')
      
      shard.username.must_equal 'shard-test'
      shard.shard.must_equal    'multiple_files'
      shard.filename.must_equal 'foo.rb'
      shard.version.must_equal  'HEAD'
    end

    it "parses a shard line with a version but no file name" do
      shard = Shard::Loader.new('shard-test/multiple_files:2')
      
      shard.username.must_equal 'shard-test'
      shard.shard.must_equal    'multiple_files'
      shard.filename.must_equal 'shard.rb'
      shard.version.must_equal  '2'
    end

  end

  describe "Loading" do

    it "will load the provided file" do

    end
    
  end


end
