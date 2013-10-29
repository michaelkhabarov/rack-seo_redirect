require 'rack/mime'

module Rack
  module SeoRedirect
    class Base
      def initialize app
        @app = app
      end

      private

      def request
        Rack::Request.new(@env)
      end

      def headers url
        {
          'Location' => url,
          'Content-Type' => ::Rack::Mime.mime_type(::File.extname(request.path), 'text/html')
        }
      end

      def redirect_message url
        "Redirecting to <a href='#{url}'>#{url}</a>"
      end

      def build_url options = {}
        options[:host] ||= request.host
        options[:path] ||= request.path

        url = "#{request.scheme}://#{options[:host]}"

        if request.scheme == "https" && request.port != 443 ||
          request.scheme == "http" && request.port != 80
          url << ":#{request.port}"
        end

        url << "#{options[:path]}"
        url << "?#{request.query_string}" unless request.query_string.empty?

        url
      end
    end
  end
end
