# TODO extendしているクラスごとに送信先が変わるのでglobalにpoolを持つ
# TODO %s/pool_server/server_pool/g
module ProconBypassMan::Background::HasServerPool
  def reset_server_pool!
    @pool_server = nil
  end

  def pool_server
    @pool_server ||= ProconBypassMan::Background::ServerPool.new(
      servers: servers
    )
  end

  def servers
    raise NotImplementedError, nil
  end
end
