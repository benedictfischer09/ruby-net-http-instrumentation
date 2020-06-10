# frozen_string_literal: true

require "spec_helper"
require "net/http/instrumentation"

RSpec.describe Net::Http::Instrumentation do
  describe "Class Methods" do
    it { is_expected.to respond_to :instrument }
    it { is_expected.to respond_to :patch_request }
  end

  describe "tracing requests" do
    describe "without config" do
      before(:all) do
        OpenTracing.global_tracer = OpenTracingTestTracer.build

        described_class.instrument
      end

      after do
        OpenTracing.global_tracer.spans.clear
      end

      it "adds spans for GET using a direct method" do
        stub_request(:any, "www.example.com")
        Net::HTTP.get("www.example.com", "/")

        expect(OpenTracing.global_tracer.spans.count).to be > 0
      end

      it "adds spans for POST with URI" do
        stub_request(:any, "www.example.com")
        uri = URI("http://www.example.com/")
        Net::HTTP.post_form(uri, "q" => "test")

        expect(OpenTracing.global_tracer.spans.count).to be > 0
      end

      it "adds spans for PUT in block style" do
        stub_request(:any, "www.example.com")
        uri = URI("http://www.example.com/")

        Net::HTTP.start(uri.host, uri.port) do |http|
          request = Net::HTTP::Put.new uri

          http.request request
        end

        expect(OpenTracing.global_tracer.spans.count).to be > 0
      end

      it "tags errors for default Net::HTTPServerError response class" do
        stub_request(:any, "www.example.com").
          to_return(body: "abc", status: 500,
                    headers: { "Content-Length" => 3 })
        uri = URI("http://www.example.com/")

        Net::HTTP.start(uri.host, uri.port) do |http|
          request = Net::HTTP::Put.new uri

          http.request request
        end

        expect(OpenTracing.global_tracer.spans.count).to be > 0

        expect(OpenTracing.global_tracer.spans.first.tags).to have_key("error")
        expect(OpenTracing.global_tracer.spans.first.tags["error"]).to be true
      end

      it "does not tag client errors by default" do
        stub_request(:any, "www.example.com").
          to_return(body: "abc", status: 400,
                    headers: { "Content-Length" => 3 })
        uri = URI("http://www.example.com/")

        Net::HTTP.start(uri.host, uri.port) do |http|
          request = Net::HTTP::Put.new uri

          http.request request
        end

        expect(OpenTracing.global_tracer.spans.count).to be > 0

        expect(OpenTracing.global_tracer.spans.first.tags).not_to have_key("error")
      end

      it "provides a operation name based on request info" do
        stub_request(:any, "www.example.com/api/v1/article/97863119-0fb4-4303-a0ca-0337406e8645?callback=0").
          to_return(body: "abc", status: 400,
                    headers: { "Content-Length" => 3 })
        uri = URI("http://www.example.com/api/v1/article/97863119-0fb4-4303-a0ca-0337406e8645?callback=0")

        allow(OpenTracing.global_tracer).to receive(:start_active_span).with("HTTP PUT www.example.com/api/v1/article/<uuid>", anything)

        Net::HTTP.start(uri.host, uri.port) do |http|
          request = Net::HTTP::Put.new uri

          http.request request
        end

        expect(OpenTracing.global_tracer).to have_received(:start_active_span).with("HTTP PUT www.example.com/api/v1/article/<uuid>", anything)
      end
    end

    describe "with config" do
      before(:context) do
        OpenTracing.global_tracer = OpenTracingTestTracer.build

        described_class.instrument(status_code_errors: [::Net::HTTPSuccess, ::Net::HTTPClientError])
      end

      after do
        OpenTracing.global_tracer.spans.clear
      end

      it "tags success as error" do
        stub_request(:any, "www.example.com").
          to_return(body: "abc", status: 200,
                    headers: { "Content-Length" => 3 })
        uri = URI("http://www.example.com/")

        Net::HTTP.start(uri.host, uri.port) do |http|
          request = Net::HTTP::Put.new uri

          http.request request
        end

        expect(OpenTracing.global_tracer.spans.count).to be > 0

        expect(OpenTracing.global_tracer.spans.first.tags).to have_key("error")
        expect(OpenTracing.global_tracer.spans.first.tags["error"]).to be true
      end

      it "tags client errors as error" do
        stub_request(:any, "www.example.com").
          to_return(body: "abc", status: 400,
                    headers: { "Content-Length" => 3 })
        uri = URI("http://www.example.com/")

        Net::HTTP.start(uri.host, uri.port) do |http|
          request = Net::HTTP::Put.new uri

          http.request request
        end

        expect(OpenTracing.global_tracer.spans.count).to be > 0

        expect(OpenTracing.global_tracer.spans.first.tags).to have_key("error")
        expect(OpenTracing.global_tracer.spans.first.tags["error"]).to be true
      end
    end
  end
end
