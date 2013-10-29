require 'spec_helper'

describe Rack::SeoRedirect::TrailingSlash do

  let(:base) { Proc.new { |env| [ 200, env, 'App' ] } }

  context "default behaviour" do
    let(:app) { Rack::SeoRedirect::TrailingSlash.new(base) }

    it 'set @should_ends_with_slash to false' do
      app.instance_variable_get('@should_ends_with_slash').should be_false
    end

    it 'removes trailing slash' do
      get 'http://www.example.com/users/'
      last_response.status.should == 301
      last_response.location.should == 'http://www.example.com/users'
    end
  end

  context "with trailing slash" do
    let(:app) { Rack::SeoRedirect::TrailingSlash.new(base, true) }

    it 'adds slash' do
      get 'http://example.com/users'
      last_response.status.should == 301
      last_response.location.should == 'http://example.com/users/'
    end

    it 'adds slash preserving port and path' do
      get 'http://example.com:3000/users?foo=bar'
      last_response.status.should == 301
      last_response.location.should == 'http://example.com:3000/users/?foo=bar'
    end

    it 'does not do anything if slash is already in url' do
      get 'http://example.com/users/?foo=bar'
      last_response.status.should == 200
    end

    it 'does not do anything for root url' do
      get 'http://example.com'
      last_response.status.should == 200

      get 'http://example.com/'
      last_response.status.should == 200
    end
  end

  context "without trailing slash" do
    let(:app) { Rack::SeoRedirect::TrailingSlash.new(base, false) }

    it 'removes slash' do
      get 'http://example.com/users/'
      last_response.status.should == 301
      last_response.location.should == 'http://example.com/users'
    end

    it 'adds slash preserving port and path' do
      get 'http://example.com:3000/users/?foo=bar'
      last_response.status.should == 301
      last_response.location.should == 'http://example.com:3000/users?foo=bar'
    end

    it 'does not do anything if no slash in url' do
      get 'http://example.com/users?foo=bar'
      last_response.status.should == 200
    end

    it 'does not do anything for root url' do
      get 'http://example.com'
      last_response.status.should == 200

      get 'http://example.com/'
      last_response.status.should == 200
    end
  end
end
