require 'webrick'

module Contentful
  module Webhook
    module Listener
      module Controllers
        # Abstract Base Controller
        # Extend and redefine #perform to run a process in background
        class Base < WEBrick::HTTPServlet::AbstractServlet
          attr_reader :logger

          def initialize(server, logger, *options)
            super(server, options)
            @logger = logger
          end

          def respond(request, response)
            response.body = ''
            response.status = 200
            puts "request #{request}"

            Thread.new do
                perform(request, response)
            end
          end

          alias_method :do_GET, :respond
          alias_method :do_POST, :respond

          protected

          def perform(_request, _response)
            fail 'must implement'
          end
        end
      end
    end
  end
end
