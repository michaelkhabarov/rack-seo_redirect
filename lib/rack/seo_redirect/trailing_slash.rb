module Rack
  module SeoRedirect
    class TrailingSlash < Base
      def initialize app, slash = false
        super(app)
        @should_ends_with_slash = slash
      end

      def call env
        @env = env
        req = Rack::Request.new(env)
        ends_with_slash = !!(req.path =~ /\A(.*)\/\z/)

        if req.get? && req.path != '/' && @should_ends_with_slash != ends_with_slash
          path = @should_ends_with_slash ? "#{req.path}/" : "#{$1}"
          url = build_url(:path => path)

          [ 301, headers(url), [ redirect_message(url) ] ]
        else
          @app.call(env)
        end
      end
    end
  end
end
