_Avoid installing the 0.0.1 version. API might change. Work still under progress_

____

# Cachify

This is an extract from the Upton parser project. This serves as a drop-in 
replacement for all ye download-cache-reading needs.



## Installation

Add this line to your application's Gemfile:

    gem 'cachify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cachify

## Usage

The primary interface is the `Cachify::Downloader` class. This takes three 
paramters: a URI, a cache enable/disable option, and a cache location.

**options**

* URI: For now, only `get` requests work properly since the library 
internally uses `open-uri` for the fetching part. You can encode the URL 
as per your requirement.

* Cache enable/disable: This takes a truthy or falsy value. True-ish if 
you want caching and false-ish if you don't want it.

* Cache location: This is the cache location. By default, this is set to 
`Dir.tmpdir/cachify`.

    # Checks if a cache is present. If not, the cache is created, 
    # the file is downloaded and is saved in the cache and is read.
    Cachify::Downloader.new("http://www.example.com").get

    # Ignores the cache and downloads the url for every call to #get
    Cachify::Downloader.new("http://www.example.com", :cache => false).get

    # Ignores the cache and downloads the url for every call and saves 
    # the cache to the "cache" folder in the same directory
    Cachify::Downloader.new("http://www.example.com", :cache => false, :cache_location => "./cache").get


## Todo

1. #get reads the whole file. Ideally, this should just save the file in 
the cache or memory. A #read method should read the file contents.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
