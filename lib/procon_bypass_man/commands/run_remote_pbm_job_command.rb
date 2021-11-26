class ProconBypassMan::RunRemotePbmActionCommand
  def self.execute(action: , uuid: )
    case action
    when ProconBypassMan::RemotePbmAction::CHANGE_PBM_VERSION
      ProconBypassMan::RemotePbmAction::ChangePbmVersionAction.new(pbm_job_uuid: uuid).run!
    when ProconBypassMan::RemotePbmAction::REBOOT_PBM
      ProconBypassMan::RemotePbmAction::RebootPbmAction.new(pbm_job_uuid: uuid).run!
    when ProconBypassMan::RemotePbmAction::REBOOT_OS
      ProconBypassMan::RemotePbmAction::RebootOsAction.new(pbm_job_uuid: uuid).run!
    else
      ProconBypassMan::SendErrorCommand.execute(error: "#{action}は対応していないアクションです")
    end
  rescue ProconBypassMan::RemotePbmAction::ActionUnexpectedError => e
    ProconBypassMan::SendErrorCommand.execute(error: e)
  end
end
