require 'spec_helper'

describe Shard::Ref do

  describe "Parsing the shard line" do

    it "parses a fully qualified shard line" do
      subject = Shard::Ref.parse('shard-test/multiple_files/bar:1')
      
      subject.user.must_equal    'shard-test'
      subject.name.must_equal    'multiple_files'
      # subject.file.must_equal    'bar.rb'
      # subject.version.must_equal '1'
    end

    it "parses a shard line without a file name or version" do
      subject = Shard::Ref.parse('shard-test/multiple_files')
      
      subject.user.must_equal    'shard-test'
      subject.name.must_equal    'multiple_files'
      # subject.file.must_equal    'shard.rb'
      # subject.version.must_equal 'HEAD'
    end

    it "parses a shard line with a file name but no version" do
      subject = Shard::Ref.parse('shard-test/multiple_files/foo')
      
      subject.user.must_equal    'shard-test'
      subject.name.must_equal    'multiple_files'
      # subject.file.must_equal    'foo.rb'
      # subject.version.must_equal 'HEAD'
    end

    it "parses a shard line with a version but no file name" do
      subject = Shard::Ref.parse('shard-test/multiple_files:2')
      
      subject.user.must_equal    'shard-test'
      subject.name.must_equal    'multiple_files'
      # subject.file.must_equal    'shard.rb'
      # subject.version.must_equal '2'
    end

  end

  describe "Loading" do

    it "will load the provided file" do

    end
    
  end


end
