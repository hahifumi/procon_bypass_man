module ProconBypassMan
  class HttpClient
    class HttpRequest
      def self.request!(http_method:, uri: , hostname: , request_body: {}, event_type: nil)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme === "https"
        case http_method
        when :get
          http.public_send(
            http_method,
            uri.path,
            { "Content-Type" => "application/json" },
          )
        when :post
          http.public_send(
            http_method,
            uri.path,
            request_body.to_json,
            { "Content-Type" => "application/json" },
          )
        end
      end
    end

    def initialize(path: , pool_server: , retry_on_connection_error: false)
      @path = path
      @pool_server = pool_server
      @hostname = `hostname`.chomp
      @retry_on_connection_error = retry_on_connection_error
    end

    def get
      handle_request do
        response = HttpRequest.request!(
          http_method: :get,
          uri: URI.parse("#{@pool_server.server}#{@path}"),
          hostname: @hostname,
        )
        break process_response(response)
      end
    end

    def post(body: , event_type: )
      handle_request do
        request_body = {
          body: body.to_json,
          hostname: @hostname,
          session_id: ProconBypassMan.session_id,
          device_id: ProconBypassMan.device_id,
          event_type: event_type,
        }
        response = HttpRequest.request!(
          http_method: :post,
          uri: URI.parse("#{@pool_server.server}#{@path}"),
          hostname: @hostname,
          request_body: request_body,
          event_type: event_type,
        )
        break process_response(response)
      end
    end

    private

    def process_response(response)
      case response.code
      when /^200/
        return JSON.parse(response.body)
      else
        @pool_server.next!
        ProconBypassMan.logger.error("200以外(#{response.code})が帰ってきました. #{response.body}")
      end
    end

    def handle_request
      raise "need block" unless block_given?
      if @pool_server.server.nil?
        ProconBypassMan.logger.info('送信先が未設定なのでスキップしました')
        return
      end
      return yield
    rescue SocketError => e
      ProconBypassMan.logger.error("error in outbound module: #{e}")
      if @retry_on_connection_error
        sleep(10)
        retry
      end
    rescue => e
      puts e
      ProconBypassMan.logger.error("error in outbound module: #{e}")
    end
  end
end
