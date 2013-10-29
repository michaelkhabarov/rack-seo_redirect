require 'spec_helper'

describe Rack::SeoRedirect::Www do

  let(:base) { Proc.new { |env| [ 200, env, 'App' ] } }

  context "default behaviour" do
    let(:app) { Rack::SeoRedirect::Www.new(base) }

    it 'set @should_starts_from_www to false' do
      app.instance_variable_get('@should_starts_from_www').should be_false
    end

    it 'removes www' do
      get 'http://www.example.com/'
      last_response.status.should == 301
      last_response.location.should == 'http://example.com/'
    end
  end

  context "non-www to www" do
    let(:app) { Rack::SeoRedirect::Www.new(base, true) }

    it 'adds www' do
      get 'http://example.com/'
      last_response.status.should == 301
      last_response.location.should == 'http://www.example.com/'
    end

    it 'adds www preserving port and path' do
      get 'http://example.com:3000/users?foo=bar'
      last_response.status.should == 301
      last_response.location.should == 'http://www.example.com:3000/users?foo=bar'
    end

    it 'does not do anything if www presence in url' do
      get 'http://www.example.com/users?foo=bar'
      last_response.status.should == 200
    end
  end

  context "www to non-www" do
    let(:app) { Rack::SeoRedirect::Www.new(base, false) }

    it 'removes www' do
      get 'http://www.example.com/'
      last_response.status.should == 301
      last_response.location.should == 'http://example.com/'
    end

    it 'removes www preserving port and path' do
      get 'http://www.example.com:3000/users?foo=bar'
      last_response.status.should == 301
      last_response.location.should == 'http://example.com:3000/users?foo=bar'
    end

    it 'does not redirect if www not presence in url' do
      get 'http://example.com/users?foo=bar'
      last_response.status.should == 200
    end
  end
end
