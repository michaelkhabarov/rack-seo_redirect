module Rack
  module SeoRedirect
    class Www < Base
      def initialize app, www = false
        super(app)
        @should_starts_from_www = www
      end

      def call env
        @env = env

        starts_from_www = !!(request.host =~ /\Awww.(.*)\z/)

        if request.get? && @should_starts_from_www != starts_from_www
          host = @should_starts_from_www ? "www.#{request.host}" : $1
          url = build_url(:host => host)

          [ 301, headers(url), [ redirect_message(url) ] ]
        else
          @app.call(env)
        end
      end
    end
  end
end
