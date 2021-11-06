require "procon_bypass_man/outbound/base"

class ProconBypassMan::PressedButtonsReporter < ProconBypassMan::Outbound::Base
  PATH = "/api/pressed_buttons"

  def self.report(body: )
    Client.new(
      path: PATH,
      servers: ProconBypassMan.config.internal_api_servers,
    ).post(body: body)
  end
end

