class ProconBypassMan::TimeScopedMap
  def initialize
    @duration = 60
    @map = {}
    @result = nil
  end

  def add(value, &block)
    if @map[key].nil?
      rotate
      block.call(result) if block_given? && result[:list]
      @map = { key => [] }
    end

    @map[key] << value
  end

  def result
    @result || {}
  end

  private

  # 0.1sec刻みで進行する
  def key
    time = Time.now
    t = [time.to_i, time.usec.to_s[0]].join.to_i
    @duration - (t % @duration)
  end

  def rotate
    @result = { list: @map.values.first }
  end
end
