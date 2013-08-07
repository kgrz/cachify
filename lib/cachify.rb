require "cachify/version"
require "fileutils"
require "open-uri"
require "tmpdir"

module Cachify

  class Downloader

    attr_reader :uri, :cache_location
    def initialize(uri, options = {})
      @uri = uri
      @cache = options.fetch(:cache) { true }
      @cache_location = options[:cache_location] || "#{Dir.tmpdir}/cachify"
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
      File.write(cached_file, file) unless cached_file_exists?
      file
    end

    def cache_enabled?
      !!@cache
    end

    def hashed_filename_based_on_uri
      Digest::MD5.hexdigest(uri)
    end

    def cached_file
      "#{cache_location}/#{hashed_filename_based_on_uri}"
    end

    def cached_file_exists?
      File.exists?(cached_file)
    end

    def initialize_cache!
      unless Dir.exists?(cache_location)
        Dir.mkdir(cache_location)
        FileUtils.chmod 0700, cache_location
      end
    end

  end
end
