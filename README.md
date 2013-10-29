# Rack::SeoRedirect

Rack middleware for making non-www to www (and conversely) redirects and removing trailing slash in urls. Use it if you can not edit Nginx or Apache rewrite rules.

## Installation

Add this line to your application's Gemfile:

    gem 'rack-seo_redirect'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-seo_redirect

## Usage

### With any Rack application

    # config.ru
    require 'rack/seo_redirect'
    use Rack::SeoRedirect::Www
    use Rack::SeoRedirect::TrailingSlash
    run MyApp

### With Rails

Insert to the top of the Rails middleware stack:

    # application.rb
    config.middleware.insert 0, Rack::SeoRedirect::Www
    config.middleware.insert 0, Rack::SeoRedirect::TrailingSlash

## Customization

### Rack::SeoRedirect::Www

Your can pass *true* or *false* as a parameter to *Www* middleware. This indicates either you need *www* in your url or not.

For non-www to www redirect use:

    use Rack::SeoRedirect::Www, true

For www to non-www redirect use:

    use Rack::SeoRedirect::Www, false

Default is *false* (www to non-www).

### Rack::SeoRedirect::TrailingSlash

Your can pass *true* or *false* as a parameter to *TrailingSlash* middleware. This indicates either you need */* in the end of your url or not.

For adding */* to the end of urls use:

    use Rack::SeoRedirect::TrailingSlash, true

For removing */* from the end of urls use:

    use Rack::SeoRedirect::TrailingSlash, false

Default is *false* (removing trailing slash).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
