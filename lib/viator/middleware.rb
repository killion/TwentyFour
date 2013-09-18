module Viator
  module Middleware
    class Http
      def initialize(app, options = {})
        @app = app
        @options = options
      end
      
      def call(env)
        query = {
          :apiKey => @options[:api_key]
        }.to_query
        
        env[:url].query = if env[:url].query
          "#{env[:url].query}&#{query}"
        else
          query
        end
        
        @app.call(env).on_complete do |env|
          if env[:status].to_s =~ /2\d\d/
            env[:body] = Hashie::Rash.new(MultiJson.decode(env[:body]))
            unless env[:body].success
              error! env, "Viator API request not successful"
            end
          else
            error! env
          end
        end
      end
      
      def error!(env, message="Viator API Exception")
        raise Viator::Error.new <<-FATAL

URL:
#{env[:url]}

Status:
#{env[:status]}

Body:
#{env[:body]}

FATAL
      end
    end
  end
end