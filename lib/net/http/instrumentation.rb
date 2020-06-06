require "net/http/instrumentation/version"
require "thread"

module Net
  module Http
    module Instrumentation
      UUID_REGEX = /[a-f0-9]{8}-([a-f0-9]{4}-){3}[a-f0-9]{12}/

      class << self

        attr_accessor :ignore_request, :tracer, :status_codes

        def instrument(tracer: OpenTracing.global_tracer,
                       ignore_request: nil,
                       status_code_errors: [ ::Net::HTTPServerError ])
          @ignore_request = ignore_request
          @tracer = tracer
          @status_codes = status_code_errors

          patch_request if !@instrumented
          @instrumented = true
        end

        def remove
          return if !@instrumented

          ::Net::HTTP.module_eval do
            remove_method :request
            alias_method :request, :request_original
            remove_method :request_original
          end

          @instrumented = false
        end

        def patch_request

          ::Net::HTTP.module_eval do
            alias_method :request_original, :request

            def request(req, body = nil, &block)
              res = ''

              if ::Net::Http::Instrumentation.ignore_request.respond_to?(:call) &&
                 ::Net::Http::Instrumentation.ignore_request.call

                res = request_original(req, body, &block)
              else
                tags = {
                  "component" => "Net::HTTP",
                  "span.kind" => "client",
                  "http.method" => req.method,
                  "http.url" => req.path,
                  "peer.host" => @address,
                  "peer.port" => @port,
                }

                operation_name = "HTTP #{req.method.to_s.upcase} #{req.path.to_s.gsub(UUID_REGEX,'<uuid>')}"
                ::Net::Http::Instrumentation.tracer.start_active_span(operation_name, tags: tags) do |scope|
                  # inject the trace so it's available to the remote service
                  OpenTracing.inject(scope.span.context, OpenTracing::FORMAT_RACK, req)

                  begin
                    # call the original request method
                    res = request_original(req, body, &block)

                    # set response code and error if applicable
                    scope.span.set_tag("http.status_code", res.code)
                    scope.span.set_tag("error", true) if ::Net::Http::Instrumentation.status_codes.any? { |e| res.is_a? e } || (res.code.to_i >= 500 && res.code.to_i < 600)
                  rescue StandardError => err
                    scope.span.set_tag("error", true)
                    scope.span.log_kv(
                      event: "error",
                      'error.kind': err.class.to_s,
                      'error.object': err,
                      message: err.respond_to?(:message) ? err.message : err.to_s,
                      stack: err.respond_to?(:backtrace) ? err.backtrace.join("\n") : err.to_s
                    )
                    raise
                  end
                end
              end

              res
            end
          end
        end
      end
    end
  end
end
