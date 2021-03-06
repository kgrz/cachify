require "spec_helper.rb"
require_relative "../lib/cachify.rb"
require "webmock/rspec"

describe Cachify::Downloader do

  def prorepublica
    File.read(File.expand_path("../fixtures/easttimor.html", __FILE__))
  end

  def remove_default_cache_folder!
    FileUtils.rm_rf("#{Dir.tmpdir}/cachify")
  end

  let(:cach) { Cachify::Downloader.new("http://www.example.com") }
  let(:uncach) { Cachify::Downloader.new("http://www.example.com", cache: false ) }

  context "When caching enabled" do

    context "When disk cache is unavailable" do
      before(:each) do
        remove_default_cache_folder!
      end

      it "should download from the resource once" do
        stub = stub_request(:get, "http://www.example.com")
        cach.get
        stub.should have_been_requested.once
      end

      it "should use the cache from the second request" do
        stub = stub_request(:get, "http://www.example.com")
        cach.get
        cach.get
        stub.should have_been_requested.once
      end

    end

    context "cache available" do
      it "should not make a http request" do
        stub = stub_request(:get, "http://www.example.com")
        cach.get
        stub.should_not have_been_requested
      end
    end


    context "Different urls should have different caches" do
      let(:cach_one) { Cachify::Downloader.new("http://www.example.com", cache: true) }
      let(:cach_two) { Cachify::Downloader.new("http://www.example.com?a=1&b=2", cache: true) }

      it "should create two cached files inside the cache directory" do
        stub_one = stub_request(:get, "http://www.example.com")
        stub_two = stub_request(:get, "http://www.example.com?a=1&b=2")

        cach_one.get
        cach_two.get
        Dir.entries("/tmp/cachify").count.should eq(4)
      end

    end
  end

  context "When caching disabled" do
    context "When #download is called twice" do
      it "should make two requests" do
        stub = stub_request(:get, "http://www.example.com")
        uncach.get
        uncach.get
        stub.should have_been_requested.twice
      end
    end
  end
end
