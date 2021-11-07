require "procon_bypass_man/outbound/servers_picker"

module ProconBypassMan
  module Outbound
    class Base
      class Client
        class Result < Struct.new(:stats); end

        def initialize(path: , servers: )
          @path = path
          @server_picker = ProconBypassMan::Outbound::ServersPicker.new(servers: servers)
          @hostname = `hostname`.chomp
        end

        def post(body: )
          @server = @server_picker.pick

          if @server.nil?
            ProconBypassMan.logger.info('送信先が未設定なのでスキップしました')
            return Result.new(false)
          end

          unless body.is_a?(Hash)
            body = { value: body }
          end

          uri = URI.parse("#{@server}#{@path}")
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = uri.scheme === "https"
          params = { hostname: @hostname }.merge(body)
          response = http.post(
            uri.path,
            params.to_json,
            { "Content-Type" => "application/json" },
          )
          case response.code
          when /^200/
            return Result.new(true)
          else
            ProconBypassMan.logger.error("200以外(#{response.code})が帰ってきました. #{response.body}")
            return Result.new(false)
          end
        rescue => e
          puts e
          ProconBypassMan.logger.error("erro: #{e}")
          Result.new(false)
        end
      end
    end
  end
end
