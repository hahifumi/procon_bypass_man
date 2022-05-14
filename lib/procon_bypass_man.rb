require "logger"
require 'yaml'
require "json"
require "net/http"
require "fileutils"
require "securerandom"
require 'em/pure_ruby'
require "action_cable_client"
require "ext/em_pure_ruby"
require "ext/module"
require "resolv-replace"
require "pbmenv"

require_relative "procon_bypass_man/version"
require_relative "procon_bypass_man/remote_pbm_action"
require_relative "procon_bypass_man/remote_macro"

require_relative "procon_bypass_man/device_connection"
require_relative "procon_bypass_man/support/usb_device_controller"
require_relative "procon_bypass_man/support/device_procon_finder"
require_relative "procon_bypass_man/support/device_mouse_finder"
require_relative "procon_bypass_man/support/signal_handler"
require_relative "procon_bypass_man/support/callbacks"
require_relative "procon_bypass_man/support/yaml_writer"
require_relative "procon_bypass_man/support/safe_timeout"
require_relative "procon_bypass_man/support/compress_array"
require_relative "procon_bypass_man/support/uptime"
require_relative "procon_bypass_man/support/on_memory_cache"
require_relative "procon_bypass_man/support/http_client"
require_relative "procon_bypass_man/support/report_http_client"
require_relative "procon_bypass_man/support/remote_macro_http_client"
require_relative "procon_bypass_man/support/update_remote_pbm_action_status_http_client"
require_relative "procon_bypass_man/support/send_device_stats_http_client"
require_relative "procon_bypass_man/support/server_pool"
require_relative "procon_bypass_man/support/analog_stick_hypotenuse_tilting_power_scaler"
require_relative "procon_bypass_man/support/never_exit_accidentally"
require_relative "procon_bypass_man/support/cycle_sleep"
require_relative "procon_bypass_man/background"
require_relative "procon_bypass_man/commands"
require_relative "procon_bypass_man/bypass"
require_relative "procon_bypass_man/device_status"
require_relative "procon_bypass_man/runner"
require_relative "procon_bypass_man/processor"
require_relative "procon_bypass_man/configuration"
require_relative "procon_bypass_man/buttons_setting_configuration"
require_relative "procon_bypass_man/procon"
require_relative "procon_bypass_man/procon/button"
require_relative "procon_bypass_man/procon/analog_stick_cap"
require_relative "procon_bypass_man/procon/analog_stick_manipulator"
require_relative "procon_bypass_man/remote_pbm_action/value_objects/remote_pbm_action_object"
require_relative "procon_bypass_man/scheduler"
require_relative "procon_bypass_man/plugins"
require_relative "procon_bypass_man/websocket/client"
require_relative "procon_bypass_man/websocket/watchdog"
require_relative "procon_bypass_man/websocket/forever"

STDOUT.sync = true
Thread.abort_on_exception = true

module ProconBypassMan
  extend ProconBypassMan::Configuration::ClassMethods
  extend ProconBypassMan::NeverExitAccidentally

  class CouldNotLoadConfigError < StandardError; end
  class EternalConnectionError < StandardError; end

  # @return [void]
  def self.run(setting_path: nil)
    ProconBypassMan::PrintMessageCommand.execute(text: "PBMを起動しています")
    initialize_pbm

    begin
      ProconBypassMan::ButtonsSettingConfiguration::Loader.load(setting_path: setting_path)
    rescue ProconBypassMan::CouldNotLoadConfigError
      ProconBypassMan::SendErrorCommand.execute(error: "設定ファイルが不正です。設定ファイルの読み込みに失敗しました")
      ProconBypassMan::DeviceStatus.change_to_setting_syntax_error_and_shutdown!
      # TODO シグナルトラップをしていないのでUSR2を送ったときにプロセスが停止している. 明示的にハンドリングするべき.
      ProconBypassMan::NeverExitAccidentally.exit_if_allow_at_config do
        terminate_pbm
      end
      return
    end

    begin
      gadget, procon = ProconBypassMan::DeviceConnection::Command.execute!
    rescue ProconBypassMan::DeviceConnection::NotFoundProconError
      ProconBypassMan::SendErrorCommand.execute(error: "プロコンが見つかりませんでした。")
      ProconBypassMan::DeviceStatus.change_to_procon_not_found_error!
      # TODO シグナルトラップをしていないのでUSR2を送ったときにプロセスが停止している. 明示的にハンドリングするべき.
      ProconBypassMan::NeverExitAccidentally.exit_if_allow_at_config do
        terminate_pbm
      end
      return
    rescue ProconBypassMan::EternalConnectionError
      ProconBypassMan::SendErrorCommand.execute(error: "接続の見込みがないのでsleepしまくります")
      ProconBypassMan::DeviceStatus.change_to_connected_but_sleeping!
      eternal_sleep
      return
    end

    ready_pbm
    Runner.new(gadget: gadget, procon: procon).run # ここでblockingする
    terminate_pbm
  end

  # 実行ファイル(app.rb)から呼び出している
  # @return [void]
  def self.configure(&block)
    @@configuration = ProconBypassMan::Configuration.new
    @@configuration.instance_eval(&block)
    nil
  end

  # @return [ProconBypassMan::Configuration]
  def self.config
    @@configuration ||= ProconBypassMan::Configuration.new
  end

  # @return [void]
  def self.reset!
    ProconBypassMan::Procon::MacroRegistry.reset!
    ProconBypassMan::Procon::ModeRegistry.reset!
    ProconBypassMan::Procon.reset!
    ProconBypassMan::ButtonsSettingConfiguration.instance.reset!
    ProconBypassMan::IOMonitor.reset!
  end

  # @return [void]
  def self.initialize_pbm
    ProconBypassMan::Scheduler.start!
    ProconBypassMan::Background::JobRunner.start!
    ProconBypassMan::Websocket::Client.start!
    ProconBypassMan::QueueOverProcess.start!

    ProconBypassMan::WriteDeviceIdCommand.execute
    ProconBypassMan::WriteSessionIdCommand.execute
    `renice -n -20 -p #{$$}`
    File.write(pid_path, $$)
    ProconBypassMan::DeviceStatus.change_to_running!
  end

  def self.ready_pbm
    ProconBypassMan::PrintBootMessageCommand.execute
    ProconBypassMan::ReportLoadConfigJob.perform_async(ProconBypassMan.config.raw_setting)
  end

  # @return [void]
  def self.terminate_pbm
    FileUtils.rm_rf(ProconBypassMan.pid_path)
    FileUtils.rm_rf(ProconBypassMan.digest_path)
    ProconBypassMan::QueueOverProcess.shutdown
  end

  # @return [void]
  def self.eternal_sleep
    sleep(999999999)
  end
end
