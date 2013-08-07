require "cachify/version"
require "fileutils"
require "open-uri"

module Cachify

  class Downloader

    attr_reader :uri, :cache_location
    def initialize(uri, cache = true, cache_location = "/tmp/cachify")
      @uri = uri
      @cache = cache
      @cache_location = cache_location
      initialize_cache!
    end

    def get
      if cache_enabled?
        download_from_cache
      else
        download_from_resource
      end
    end

    def download_from_resource
      open(uri).read
    end

    def download_from_cache
      file = if cached_file_exists?
               open(cached_file).read
             else
               download_from_resource
             end
      File.open(cached_file, "w") { |f| f.write(file) }
      file
    end

    def initialize_cache!
      unless Dir.exists?(cache_location)
        Dir.mkdir(cache_location)
      end
    end

    def cache_enabled?
      !!@cache
    end

    def cached_filename_based_on_uri
      Digest::MD5.hexdigest(uri)
    end

    def cached_file
      "#{cache_location}/#{cached_filename_based_on_uri}.html"
    end

    def cached_file_exists?
      File.exists?(cached_file)
    end

  end
end

